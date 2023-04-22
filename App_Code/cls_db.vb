Imports Microsoft.VisualBasic
Imports System.Data
Imports System.Data.OleDb
Imports Microsoft.Win32


Imports System.Data.SqlClient
Imports System.Configuration



Public Class cls_db


    Const alta_code As Integer = 1
    Const modificacion_code As Integer = 2
    Const baja_code As Integer = 3
    Const reset_pass_code As Integer = 4

    Public parametros As New Dictionary(Of String, Object)

    Public Sub agregar_parametro_fecha(nombre As String, txt As TextBox)
        If txt.Text = "" Then
            Me.parametros.Add(nombre, Nothing)
        Else
            Me.parametros.Add(nombre, cls_utils.fecha_sql(txt.Text))
        End If
    End Sub

    Public Sub agregar_parametro_combo(nombre As String, cbo As DropDownList)
        If cbo.SelectedValue.ToString = "-1" Then
            Me.parametros.Add(nombre, Nothing)
        Else
            Me.parametros.Add(nombre, cbo.SelectedValue)
        End If
    End Sub



    Public Function conectar() As OleDb.OleDbConnection
        Dim connStrig As String = CrearConexion()
        conectar = New OleDb.OleDbConnection(connStrig)
        conectar.Open()

    End Function


    'Private Function CrearConexion(Optional ByVal sqlConection As Boolean = False) As String

    'Dim rk As RegistryKey = Registry.LocalMachine.OpenSubKey("Software").OpenSubKey("codigo_nativo").OpenSubKey("firma_nativa")
    'Dim servidor As String = rk.GetValue("server") '"190.220.142.98"
    'Dim base As String = rk.GetValue("base")
    'Dim user As String = rk.GetValue("user")
    'Dim pass As String = rk.GetValue("pass")

    'pass = cls_crypto.Decrypt(pass)
    'Dim connStrig As String

    'If sqlConection = False Then
    '       connStrig = "Provider=SQLOLEDB;Data Source=" & servidor & ";Initial Catalog=" & base & ";User Id=" & user & ";Password=" & pass & ";"
    'Else
    '       connStrig = "Data Source=" & servidor & ";Initial Catalog=" & base & ";User Id=" & user & ";Password=" & pass & ";"
    'End If

    'Return connStrig

    'End Function
    Private Function CrearConexion(Optional ByVal sqlConection As Boolean = False) As String

        'Dim rk As RegistryKey = Registry.LocalMachine.OpenSubKey("Software").OpenSubKey("codigo_nativo").OpenSubKey("firma_nativa")
        Dim servidor As String = ConfigurationManager.AppSettings("servidor").ToString()
        Dim base As String = ConfigurationManager.AppSettings("base").ToString()
        Dim user As String = ConfigurationManager.AppSettings("user").ToString()
        Dim pass As String = ConfigurationManager.AppSettings("pass").ToString()

        'Dim key As String
        'key = cls_crypto.Decrypt("UYati0guuTI=")
        Dim connStrig As String

        If sqlConection = False Then
            connStrig = "Provider=SQLOLEDB;Data Source=" & servidor & ";Initial Catalog=" & base & ";User Id=" & user & ";Password=" & pass & ";"
        Else
            connStrig = "Data Source=" & servidor & ";Initial Catalog=" & base & ";User Id=" & user & ";Password=" & pass & ";"
        End If

        Return connStrig

    End Function

#Region "combos"

    'Public Sub llenarCombo(ByRef combo As DropDownList, tabla As String, campoValor As String, campoDescripcion As String)

    '    For Each dr As DataRow In get_select(campoValor & ", " & campoDescripcion, tabla, " fecha_baja Is null ", "order by " & campoDescripcion).Rows
    '        combo.Items.Add(New ListItem(dr(campoDescripcion), dr(campoValor)))
    '    Next
    'End Sub

    'Public Sub llenarCombo(ByRef combo As DropDownList, ByVal tabla As String, ByVal where As String, ByVal campoValor As String, ByVal campoDescripcion As String)

    '    For Each dr As DataRow In get_select(campoValor & ", " & campoDescripcion, tabla, where, "order by " & campoDescripcion).Rows
    '        combo.Items.Add(New ListItem(dr(campoDescripcion), dr(campoValor)))
    '    Next
    'End Sub

    Public Shared Function indexCombo(ByVal combo As DropDownList, ByVal valor As String) As Integer

        For i As Integer = 0 To combo.Items.Count - 1
            If combo.Items(i).Value.Trim.ToLower = valor.Trim.ToLower Then
                Return i
            End If
        Next
        Return -1
    End Function


#End Region

#Region "ejecutar"

    Public Function ejecutar(consulta As String) As DataTable

        Dim conn As OleDbConnection = conectar()

        Dim myCMD As OleDbCommand
        Dim myda As OleDbDataAdapter
        Dim dt As New DataTable



        myCMD = New OleDbCommand(consulta, conn)
        myCMD.CommandType = CommandType.Text
        myda = New OleDbDataAdapter(myCMD)
        myda.Fill(dt)

        conn.Close()
        conn.Dispose()


        Try
            conn.Close()
            conn.Dispose()
        Catch ex As Exception

        End Try

        Return dt

    End Function


    Public Function ejecutar_sp(procedimiento As String, Optional ByVal parametros As Dictionary(Of String, Object) = Nothing) As DataTable

        If IsNothing(Me.parametros) OrElse Me.parametros.Count = 0 Then
            Me.parametros = parametros
        End If


        Dim conn As System.Data.OleDb.OleDbConnection = conectar()

        Dim myCMD As System.Data.OleDb.OleDbCommand
        Dim myda As System.Data.OleDb.OleDbDataAdapter
        Dim dt As New DataTable


        myCMD = New System.Data.OleDb.OleDbCommand(procedimiento, conn)
        myCMD.CommandType = CommandType.StoredProcedure

        If Not IsNothing(Me.parametros) Then

            For Each p As KeyValuePair(Of String, Object) In Me.parametros
                If IsNothing(p.Value) Then
                    myCMD.Parameters.AddWithValue(p.Key, DBNull.Value)
                Else
                    myCMD.Parameters.AddWithValue(p.Key, p.Value)
                End If

            Next

        End If

        myda = New System.Data.OleDb.OleDbDataAdapter(myCMD)

        myda.Fill(dt)

        conn.Close()
        conn.Dispose()

        Try
            conn.Close()
            conn.Dispose()
        Catch ex As Exception

        End Try

        Return dt

    End Function
    Public Function ejecutar_sp_identity(consulta As String, Optional ByVal parametros As List(Of OleDbParameter) = Nothing) As Integer

        Dim identity As Integer
        Dim conn As OleDbConnection = conectar()
        Dim myCMD As OleDbCommand
        Dim myda As OleDbDataAdapter
        Dim dt As New DataTable

        Try

            myCMD = New OleDbCommand(consulta, conn)
            myCMD.CommandType = CommandType.StoredProcedure
            myCMD.Parameters.Clear()
            If Not IsNothing(parametros) Then

                For Each parametro As OleDbParameter In parametros
                    myCMD.Parameters.Add(parametro)
                Next

            End If
            myCMD.ExecuteNonQuery()
            myCMD = New OleDbCommand("select @@identity", conn)
            myCMD.Parameters.Clear()
            identity = myCMD.ExecuteScalar()

            conn.Close()
            conn.Dispose()

        Catch ex As Exception
            Dim a As String = ex.Message ' MsgBox(ex.Message)
            ' MsgBox(a)
        Finally
            Try
                conn.Close()
                conn.Dispose()
            Catch ex As Exception

            End Try
        End Try

        Return identity

    End Function
    Public Function ejecutar_sp_Dataset(procedimiento As String, Optional ByVal parametros As Dictionary(Of String, Object) = Nothing) As DataSet

        If IsNothing(Me.parametros) OrElse Me.parametros.Count = 0 Then
            Me.parametros = parametros
        End If


        Dim conn As System.Data.OleDb.OleDbConnection = conectar()

        Dim myCMD As System.Data.OleDb.OleDbCommand
        Dim myda As System.Data.OleDb.OleDbDataAdapter
        Dim ds As New DataSet


        myCMD = New System.Data.OleDb.OleDbCommand(procedimiento, conn)
        myCMD.CommandType = CommandType.StoredProcedure

        If Not IsNothing(Me.parametros) Then

            For Each p As KeyValuePair(Of String, Object) In Me.parametros
                If IsNothing(p.Value) Then
                    myCMD.Parameters.AddWithValue(p.Key, DBNull.Value)
                Else
                    myCMD.Parameters.AddWithValue(p.Key, p.Value)
                End If

            Next

        End If

        myda = New System.Data.OleDb.OleDbDataAdapter(myCMD)

        myda.Fill(ds)

        conn.Close()
        conn.Dispose()

        Try
            conn.Close()
            conn.Dispose()
        Catch ex As Exception

        End Try

        Return ds

    End Function

    Public Function ejecutar_sp_row(procedimiento As String, Optional ByVal parametros As Dictionary(Of String, Object) = Nothing) As DataRow

        Dim row As DataRow = Nothing
        Dim dt As DataTable = ejecutar_sp(procedimiento, parametros)
        If dt.Rows.Count > 0 Then
            row = dt.Rows(0)
        End If
        Return row
    End Function


    Public Function ejecutar_sp_scalar(procedimiento As String, Optional ByVal parametros As Dictionary(Of String, Object) = Nothing) As Object

        If IsNothing(Me.parametros) OrElse Me.parametros.Count = 0 Then
            Me.parametros = parametros
        End If

        Dim conn As System.Data.OleDb.OleDbConnection = conectar()
        Dim myCMD As System.Data.OleDb.OleDbCommand
        Dim dt As New DataTable


        myCMD = New System.Data.OleDb.OleDbCommand(procedimiento, conn)
        myCMD.CommandType = CommandType.StoredProcedure

        If Not IsNothing(Me.parametros) Then

            For Each p As KeyValuePair(Of String, Object) In Me.parametros
                If IsNothing(p.Value) Then
                    myCMD.Parameters.AddWithValue(p.Key, DBNull.Value)
                Else
                    myCMD.Parameters.AddWithValue(p.Key, p.Value)
                End If

            Next

        End If

        Dim valor_scalar As Object = myCMD.ExecuteScalar()


        conn.Close()
        conn.Dispose()

        Try
            conn.Close()
            conn.Dispose()
        Catch ex As Exception

        End Try

        Return valor_scalar

    End Function




#End Region

    Public Function ejecutar_sp_timeout(procedimiento As String, ByVal parametros As Dictionary(Of String, Object), timeout As Integer) As DataTable

        If IsNothing(Me.parametros) OrElse Me.parametros.Count = 0 Then
            Me.parametros = parametros
        End If


        Dim conn As System.Data.OleDb.OleDbConnection = conectar()

        Dim myCMD As System.Data.OleDb.OleDbCommand
        Dim myda As System.Data.OleDb.OleDbDataAdapter
        Dim dt As New DataTable


        myCMD = New System.Data.OleDb.OleDbCommand(procedimiento, conn)
        myCMD.CommandType = CommandType.StoredProcedure
        myCMD.CommandTimeout = timeout

        If Not IsNothing(Me.parametros) Then

            For Each p As KeyValuePair(Of String, Object) In Me.parametros
                If IsNothing(p.Value) Then
                    myCMD.Parameters.AddWithValue(p.Key, DBNull.Value)
                Else
                    myCMD.Parameters.AddWithValue(p.Key, p.Value)
                End If

            Next

        End If

        myda = New System.Data.OleDb.OleDbDataAdapter(myCMD)

        myda.Fill(dt)

        conn.Close()
        conn.Dispose()

        Try
            conn.Close()
            conn.Dispose()
        Catch ex As Exception

        End Try

        Return dt

    End Function

    Public Shared Function get_id(sp As String, codigo As String, valor As String) As DataRow

        Dim sql As New cls_db
        sql.parametros.Add(codigo, valor)

        Dim dt As DataTable = sql.ejecutar_sp(sp)

        If dt.Rows.Count > 0 Then
            Return dt.Rows(0)
        End If

        Return Nothing
    End Function

    Public Shared Function get_all(sp As String) As DataTable

        Dim sql As New cls_db
        Return sql.ejecutar_sp(sp)

    End Function



#Region "BulkCopy"

    Public Sub bulk_copy(dt As DataTable, table_name As String, Optional cant_col As Integer = 0)

        If cant_col = 0 Then
            cant_col = dt.Columns.Count
        End If

        Dim con As New SqlConnection(CrearConexion(True))
        Dim SqlBulkCopy As New SqlBulkCopy(con)

        SqlBulkCopy.DestinationTableName = table_name


        For i As Integer = 0 To cant_col - 1

            SqlBulkCopy.ColumnMappings.Add(i, i)
        Next

        con.Open()
        SqlBulkCopy.WriteToServer(dt)
        con.Close()



    End Sub

    Public Sub bulk_copy_by_name(dt As DataTable, table_name As String, Optional cant_col As Integer = 0)

        If cant_col = 0 Then
            cant_col = dt.Columns.Count
        End If

        Dim con As New SqlConnection(CrearConexion(True))
        Dim SqlBulkCopy As New SqlBulkCopy(con)

        SqlBulkCopy.DestinationTableName = table_name


        For i As Integer = 0 To cant_col - 1

            Dim EntityID As New SqlBulkCopyColumnMapping(dt.Columns(i).ColumnName, dt.Columns(i).ColumnName)
            SqlBulkCopy.ColumnMappings.Add(EntityID)

        Next

        con.Open()
        SqlBulkCopy.WriteToServer(dt)
        con.Close()



    End Sub


#End Region



End Class











