
Imports System.Net
Imports Newtonsoft.Json.Linq
Imports Microsoft.Win32
Imports System.Data
Imports System.IO


Public Class cls_utils

    Public Enum CodeStatus
        OK = 1
        WITH_ERROR = 99
    End Enum

    'Public Shared Sub set_code_response(ByRef obj As JObject, code_status As CodeStatus)
    '    obj.Add("code", CInt(code_status))
    'End Sub

    'Public Shared Function new_obj_response(code_status As CodeStatus) As JObject
    '    Dim obj As New JObject
    '    obj.Add("code", CInt(code_status))
    '    Return obj
    'End Function



    Public Shared Function Log(texto As String)
        Dim activar_logs = ConfigurationManager.AppSettings("activar_logs").ToString() 'string true o false
        If activar_logs = "true" Then
            Dim strFile As String = System.Web.HttpContext.Current.Server.MapPath("~/logg.txt") '  MapPath("~/") + "log.txt"
            Dim fileExists As Boolean = File.Exists(strFile)


            Dim sw As New StreamWriter(strFile, True)
            sw.WriteLine(texto & "    <----  " & DateTime.Now)
            sw.WriteLine("          -               -               -             ")
            sw.Close()
        End If

    End Function
    Public Shared Function capitalize(text As String) As String
        Return System.Globalization.CultureInfo.CurrentCulture.TextInfo.ToTitleCase(text)
    End Function
    Public Shared Function quitar_ultimo_caracter(ByVal texto As String, ByVal cant_caracter As Integer) As String
        texto = texto.TrimEnd()
        Return texto.TrimEnd.Substring(0, texto.Length - cant_caracter)
    End Function


    Public Shared Function redirect_msg(ByRef response As System.Web.HttpResponse, pagina As String, msg As String) As String
        System.Web.HttpContext.Current.Session("msg_toast") = msg
        response.Redirect(pagina)
    End Function
    Public Shared Function redirect_msg_error(ByRef response As System.Web.HttpResponse, pagina As String, msg As String) As String
        System.Web.HttpContext.Current.Session("msg_toast_error") = msg
        response.Redirect(pagina)
    End Function


    ' ####################  COMBOS  ####################

    Public Shared Sub cargar_combo_anio(ByRef cbo As DropDownList)
        For i As Integer = Now.AddYears(-20).Year To Now.AddYears(1).Year
            cbo.Items.Add(New ListItem(i, i))
        Next
        cbo.SelectedValue = Now.Year
    End Sub

    Public Shared Sub cargar_combo_mes(ByRef cbo As DropDownList)
        cbo.Items.Add(New ListItem("Enero", 1))
        cbo.Items.Add(New ListItem("Febrero", 2))
        cbo.Items.Add(New ListItem("Marzo", 3))
        cbo.Items.Add(New ListItem("Abril", 4))
        cbo.Items.Add(New ListItem("Mayo", 5))
        cbo.Items.Add(New ListItem("Junio", 6))
        cbo.Items.Add(New ListItem("Julio", 7))
        cbo.Items.Add(New ListItem("Agosto", 8))
        cbo.Items.Add(New ListItem("Septiembre", 9))
        cbo.Items.Add(New ListItem("Octubre", 10))
        cbo.Items.Add(New ListItem("Noviembre", 11))
        cbo.Items.Add(New ListItem("Diciembre", 12))

        cbo.SelectedValue = Now.Month

    End Sub

    Public Shared Sub cargar_combo(ByRef combo As DropDownList, dt As DataTable, Optional ByVal campoid As String = "id", Optional ByVal campodescripcion As String = "Descripcion")
        combo.DataTextField = campodescripcion
        combo.DataValueField = campoid

        combo.DataSource = dt
        combo.DataBind()
    End Sub

    Public Shared Sub cargar_combo(ByRef combo As DropDownList, dt As DataTable, ByVal campoid As String, ByVal campodescripcion As String, ByVal campodescripcion2 As String)
        combo.Items.Clear()

       
        For Each row As DataRow In dt.Rows
            combo.Items.Add(New ListItem(row(campodescripcion) & " - " & row(campodescripcion2), row(campoid)))
        Next

    End Sub

    Public Shared Sub cargar_combo(ByRef combo As DropDownList, sp As String, ByVal campo_codigo As String, ByVal campo_desc As String)

        Dim dt As DataTable
        combo.DataTextField = campo_desc
        combo.DataValueField = campo_codigo

        combo.DataSource = cls_db.get_all(sp)
        combo.DataBind()
    End Sub
    Public Shared Sub cargar_combo_por_empresa(ByRef combo As DropDownList, sp As String, ByVal campo_codigo As String, ByVal campo_desc As String, empresa_id As Integer)

        Dim sql As New cls_db
        Dim dt As DataTable
        combo.DataTextField = campo_desc
        combo.DataValueField = campo_codigo
        sql.parametros.Add("empresa_id", empresa_id)
        combo.DataSource = sql.ejecutar_sp(sp)
        combo.DataBind()

    End Sub

    Public Shared Sub cargar_combo(ByRef combo As DropDownList, sp As String, Optional ByVal campo_codigo_index As Integer = 0, Optional ByVal campo_desc_index As Integer = 1)

        combo.Items.Clear()

        Dim dt As DataTable = cls_db.get_all(sp)

        For Each row As DataRow In dt.Rows
            combo.Items.Add(New ListItem(row(campo_desc_index), row(campo_codigo_index)))
        Next

    End Sub

    Public Shared Function value_null(ByRef combo As DropDownList) As Object
        If combo.SelectedValue = -1 Then
            Return DBNull.Value
        End If
        Return combo.SelectedValue
    End Function

    Public Shared Function value_null(ByRef txt As TextBox) As Object
        If txt.Text = "" Then
            Return DBNull.Value
        End If
        Return txt.Text
    End Function


    Public Shared Function get_null_object(valor As Object) As Object
        If IsDBNull(valor) Then
            Return Nothing
        End If
        Return valor
    End Function

    Public Shared Function value_null(valor As Date) As Object
        If IsNothing(valor) OrElse Format(valor, "yyyyMMdd") = "00010101" Then
            Return DBNull.Value
        End If
        Return fecha_sql(valor)
    End Function
    Public Shared Function cuil_by_uuid(pk_to_uuid As String) As String
        Dim uuid As String = pk_to_uuid
        Dim dt As DataTable
        Dim sql As New cls_db
        sql.parametros.Add("uuid", uuid) 'parametros de sp update
        dt = sql.ejecutar_sp("SP_usuario_consul_by_uuid")
        Dim cuil As String = dt(0)(1)
        Return cuil
    End Function

    Public Shared Function documentos_firmados(cuil As String) As DataTable
        Dim sql As New cls_db
        sql.parametros.Clear()
        sql.parametros.Add("cuil", cuil)
        sql.parametros.Add("empresa_id", cls_security.usuario_actual.empresa_id)
        Dim docs_firmados As DataTable = sql.ejecutar_sp("SP_Docs_firmados")
        Return docs_firmados
    End Function
    Public Shared Function borrar_certificados_fisicos_de_mi_empresa(empresa_id As Integer, cuil_empleado As String, certificad_id As Integer) As String
        Dim ubicacion_carpeta_empleado_certificados As String = cls_dir.CARPETA_CERTIFICADO(cuil_empleado, certificad_id)
        Dim papelera_de_certificados As String = cls_utils.obtener_parametros("CARPETA_BASE") & "\Empleados\papelera_de_certificados"
        If Not Directory.Exists(papelera_de_certificados & "\certificado_" & certificad_id) Then
            Directory.CreateDirectory(papelera_de_certificados & "\certificado_" & certificad_id)
        End If
        papelera_de_certificados = papelera_de_certificados & "\certificado_" & certificad_id
        If System.IO.Directory.Exists(ubicacion_carpeta_empleado_certificados) Then
            'My.Computer.FileSystem.DeleteDirectory(ubicacion_carpeta_empleado_certificados, FileIO.DeleteDirectoryOption.DeleteAllContents)
            My.Computer.FileSystem.MoveDirectory(ubicacion_carpeta_empleado_certificados, papelera_de_certificados)
        End If
        Return "true"
    End Function
    Public Shared Function empresas_del_empleado(cuil As String) As DataTable
        Dim sql As New cls_db
        sql.parametros.Clear()
        sql.parametros.Add("cuil", cuil)
        Dim empresas As DataTable = sql.ejecutar_sp("SP_usuario_consul_cuil")
        Return empresas
    End Function
    Public Shared Function certificado_del_empleado(cuil As String, empresa_id As Integer) As Integer
        Dim certificado_id As Integer
        Dim sql As New cls_db
        sql.parametros.Clear()
        sql.parametros.Add("cuil", cuil)
        sql.parametros.Add("empresa_id", empresa_id)
        Dim Usuario_certificado As DataTable = sql.ejecutar_sp("SP_usuario_consul_certificado")
        Try
            If Not Usuario_certificado.Rows(0)(2) Is DBNull.Value Then
                certificado_id = Usuario_certificado.Rows(0)(2)
            End If
        Catch ex As Exception
            cls_utils.Log("error al buscar certificado cls_utils")
            Return certificado_id
        End Try
        Return certificado_id
    End Function
    Public Shared Function nombre_de_empresa_by_empresa_id(empresa_id As Integer) As String
        Dim sql As New cls_db
        sql.parametros.Clear()
        sql.parametros.Add("empresa_id", empresa_id)
        Dim dt_empresa As DataTable = sql.ejecutar_sp("SP_Empresas_Consul_ID")
        Dim empresa As DataRow = dt_empresa(0)
        Dim nombre_empresa As String = empresa("razon_social")
        Return nombre_empresa
    End Function

    Public Shared Function baja_logica(id As Integer) As String
        Dim sql As New cls_db
        sql.parametros.Clear()
        sql.parametros.Add("id", id)
        sql.parametros.Add("usuario_baja_id", cls_security.usuario_actual.id)
        sql.ejecutar_sp("SP_Usuarios_DELETE") ' este Sp hace baja lógica
        Return "true"
    End Function
    Public Shared Function baja_fisica(id As Integer) As String
        Dim sql As New cls_db
        sql.parametros.Clear()
        sql.parametros.Add("id", id)
        sql.ejecutar_sp("SP_Usuario_full_delete") ' este Sp elimina de la tabla Usuarios
        Return "true"
    End Function
    Public Shared Function eliminar_login(cuil As String, id As Integer) As String
        Dim sql As New cls_db
        sql.parametros.Clear()
        sql.parametros.Add("cuil", cuil)
        sql.ejecutar_sp("SP_UsuarioLogin_delete")
        Return "true"
    End Function


    Public Shared Function importe_texto(valor As Decimal) As String
        Return "$ " & FormatNumber(valor, 2)
    End Function

    Public Shared Function numero_texto(valor As Decimal) As String
        Return FormatNumber(valor, 2)
    End Function



    Public Shared Function fecha_texto(dia As Date) As String
        Return Format(dia, "dd/MM/yyyy")
    End Function

    Public Shared Function texto_fecha(ByVal fecha As String) As Date
        If fecha.Trim = "" Then
            Return New DateTime(1899, 12, 30)
        Else
            Try
                Return DateTime.ParseExact(fecha, "dd/MM/yyyy", Nothing)
            Catch ex As Exception
                Return New DateTime(1899, 12, 30)
            End Try
        End If
    End Function

    Public Shared Function fecha_sql(ByVal fecha As Date) As String
        Return Format(fecha, "yyyyMMdd")
    End Function

    Public Shared Function fecha_sql(ByVal fecha As String) As String
        Return Format(texto_fecha(fecha), "yyyyMMdd")
    End Function


    Public Shared Function generar_uuid() As String
        Return System.Guid.NewGuid().ToString
    End Function

    Public Shared Function obtener_parametros(ByVal codigo As String) As String
        Dim sql As New cls_db
        sql.parametros.Add("codigo", codigo)
        Dim row As DataRow = cls_db.get_id("SP_parametros_Consul_ID", "codigo", codigo)
        Return row("valor")
    End Function

    Public Shared Function format_certificate(Text As String) As String
        Text = Text.ToUpper
        Text = Text.Replace("-----BEGIN CERTIFICATE-----", "")
        Text = Text.Replace("-----END CERTIFICATE-----", "")
        Text = Text.Replace(Chr(10), "")
        Text = Text.Replace(Chr(13), "")
        Dim builder As New StringBuilder(Text)
        Dim startIndex = builder.Length - (builder.Length Mod 2)

        For i As Int32 = startIndex To 2 Step -2
            builder.Insert(i, " "c)
        Next i
        builder.Insert(0, "------------------------BEGIN CERTIFICATE------------------------" & Chr(10))
        builder.Append(Chr(10) & "-------------------------END CERTIFICATE-------------------------")
        Return builder.ToString()
    End Function
    Public Shared Function format_certificate_html(Text As String) As String
        Text = Text.ToUpper
        Text = Text.Replace("-----BEGIN CERTIFICATE-----", "")
        Text = Text.Replace("-----END CERTIFICATE-----", "")
        Text = Text.Replace(Chr(10), "")
        Text = Text.Replace(Chr(13), "")
        Dim builder As New StringBuilder(Text)
        Dim startIndex = builder.Length - (builder.Length Mod 2)

        For i As Int32 = startIndex To 2 Step -2
            builder.Insert(i, " "c)
        Next i
        'builder.Insert(0, "------------------------BEGIN CERTIFICATE------------------------" & "<br />")
        'builder.Append("<br />" & "-------------------------END CERTIFICATE-------------------------")
        Return builder.ToString()
    End Function


    Public Shared Function date_esp(ByVal fecha As Date) As String
        Dim base As String = "{0},{1} de {2} de {3}"
        Dim dia As String = nombre_dia(fecha.DayOfWeek)
        Dim mes As String = nombre_mes(fecha.Month)

        Return String.Format(base, dia, fecha.Day, mes, fecha.Year)

    End Function

    Public Shared Function nombre_mes(ByVal mes As Integer) As String
        If mes = 1 Then Return "Enero"
        If mes = 2 Then Return "Febrero"
        If mes = 3 Then Return "Marzo"
        If mes = 4 Then Return "Abril"
        If mes = 5 Then Return "Mayo"
        If mes = 6 Then Return "Junio"
        If mes = 7 Then Return "Julio"
        If mes = 8 Then Return "Agosto"
        If mes = 9 Then Return "Septiembre"
        If mes = 10 Then Return "Octubre"
        If mes = 11 Then Return "Noviembre"
        If mes = 12 Then Return "Diciembre"

    End Function
    Public Shared Function ruta_certificado() As String
        Dim sql As New cls_db
        Dim dt As DataTable = sql.ejecutar_sp("SP_parametros_CONSUL")
        Dim ruta_cer As String = ((dt.Rows(5)).ItemArray)(2)
        'cls_utils.Log("ruta_cer " & ruta_cer)
        Return ruta_cer
    End Function
    Public Shared Function nombre_dia(ByVal dia As Integer) As String
        If dia = 1 Then Return "Lunes"
        If dia = 2 Then Return "Marte"
        If dia = 3 Then Return "Miércoles"
        If dia = 4 Then Return "Jueves"
        If dia = 5 Then Return "Viernes"
        If dia = 6 Then Return "Sábado"
        If dia = 0 Then Return "Domingo"

    End Function

    Public Shared Function string_to_date(ByVal fecha As String, Optional ByVal format As String = "dd/MM/yyyy") As DateTime
        If fecha.Trim = "" Then
            Return New DateTime(1899, 12, 30)
        Else
            Dim dte As DateTime = (fecha)
            Try
                Return dte.ToString(format)
            Catch ex As Exception
                Return New DateTime(1899, 12, 30)
            End Try
        End If
    End Function

    Public Shared Function check_documentos(path_files As List(Of String), documentos_id As List(Of String), legajo As List(Of String)) As List(Of String)
        Try
            Dim documento_id_inexistente As New List(Of String)()
            For i = 0 To path_files.Count - 1
                'cls_utils.Log(path_files(i))
                If Not My.Computer.FileSystem.FileExists(path_files(i)) Then
                    Dim doc_inexistente As String
                    doc_inexistente = documentos_id(i)
                    'cls_utils.Log("No se encontro el Documento " & documentos_id(i) & " en la ruta ----->  " & path_files(i))
                    documento_id_inexistente.Add(doc_inexistente)
                End If

            Next i
            Return documento_id_inexistente
        Catch ex As Exception
            cls_utils.Log(ex.ToString)
        End Try
    End Function

    Public Shared Function check_certificados(directorios As List(Of String), cuil As List(Of String), certificados_id As List(Of String)) As List(Of String)
        Try
            Dim certificados_id_inexistentes As New List(Of String)()
            Dim ext As New List(Of String)()
            ext.Add("cer")
            ext.Add("pem")
            ext.Add("pfx")
            ext.Add("rsa")
            ext.Add("_firmador.pfx")
            Dim fila_de_archivo_faltante As New System.Text.StringBuilder
            Dim bandera As Boolean
            For i = 0 To cuil.Count - 1
                bandera = False
                fila_de_archivo_faltante.Clear()
                'cls_utils.Log(directorios(i))
                Dim archivo As String
                fila_de_archivo_faltante.Append(cuil(i) & "," & certificados_id(i) & ",")

                For iteracion = 0 To ext.Count - 1
                    If Not ext(iteracion) = "_firmador.pfx" Then
                        archivo = directorios(i) & "\" & certificados_id(i) & "." & ext(iteracion)
                    Else
                        archivo = directorios(i) & "\" & certificados_id(i) & ext(iteracion)
                    End If

                    If My.Computer.FileSystem.FileExists(archivo) Then 'ENCONTRO EL ARCHIVO
                        'cls_utils.Log("No se encontro el certificado " & certificados_id(i) & " en la ruta ----->  " & archivo)
                        If Not ext(iteracion) = "_firmador.pfx" Then ' este IF soluciona que la extension no tenga un "punto" donde no debe
                            fila_de_archivo_faltante.Append(certificados_id(i) & "." & ext(iteracion) & ",")
                        Else
                            fila_de_archivo_faltante.Append(certificados_id(i) & ext(iteracion) & ",")
                        End If
                    Else ' NO ENCONTRO EL ARCHIVO - si no esta el archivo lo agrega en rojo
                        bandera = True
                        If Not ext(iteracion) = "_firmador.pfx" Then  ' este IF soluciona que la extension no tenga un "punto" donde no debe
                            fila_de_archivo_faltante.Append("<span style='color:#F44336'>" & certificados_id(i) & "." & ext(iteracion) & "</span>,")
                        Else
                            fila_de_archivo_faltante.Append("<span style='color:#F44336'>" & certificados_id(i) & ext(iteracion) & "</span>,")
                        End If
                    End If
                Next
                If bandera = True Then
                    certificados_id_inexistentes.Add(fila_de_archivo_faltante.ToString)
                End If

            Next i
            Return certificados_id_inexistentes
        Catch ex As Exception
            cls_utils.Log(ex.ToString)
        End Try

    End Function



End Class


Public Class Param_Codigo
    Public Property codigo As Long
End Class
