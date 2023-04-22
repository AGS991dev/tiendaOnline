
Imports System.Data

Partial Class empleado_index
    Inherits System.Web.UI.Page
    Public docs_sin_firmar_row As Integer
    Public docs_firmados_row As Integer

    Public docs_firmados As String

    Public docs_sin_firmar_template As String = "<div class='row center'><div style='margin: auto;width: 90%;'><div class='card card_color darken-1'><div style='padding: 50px 5px;' class='card-content white-text'><span class='card-title' style='position:relative;top:-20px'>Aquí verás los documentos <b>sin Firmar</b></span><p style='color:white'>En este momento no tenés documentos sin firmar</p></div></div></div></div>"
    Public docs_firmados_template As String = "<div class='row center'><div style='margin: auto;width: 90%;'><div class='card card_color darken-1'><div style='padding: 50px 5px' class='card-content white-text'><span class='card-title' style='position:relative;top:-20px'>Aquí verás Tus documentos <b>firmados</b></span><p style='color:white'>Aún no tenés documentos firmados.</p></div></div></div></div>"

    Public entrego_autorizacion As String
    Public certificado_id As Integer
    Public formulario As String = "empleado_index.aspx"

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Try
            'llenar_grilla_sin_firmar()
            'llenar_grilla_firmados()
            'inicializar_variables()
            'If certificado_id = 0 And cls_security.usuario_actual.es_supervisor Then
            'Response.Redirect("supervisor_index.aspx")
            'End If
        Catch ex As Exception
            cls_utils.Log("---------")
            cls_utils.Log(ex.ToString)
            cls_utils.Log("---------")
            cls_utils.redirect_msg_error(Response, "login.aspx", "Logueo expirado, vuelva a iniciar sesión por favor.")
        End Try
    End Sub


    Overridable Sub llenar_grilla_sin_firmar()

        Dim sql As New cls_db
        Dim dt As New DataTable
        sql.parametros.Add("cuil", cls_security.usuario_actual.cuil)
        sql.parametros.Add("empresa_id", cls_security.usuario_actual.empresa_id)

        dt = sql.ejecutar_sp("SP_Docs_sin_firmar_GRILLA")
        'Dim grid As New cls_grid(dt, formulario)
        'grid.show_delete = False

        If dt.Rows.Count = 0 Then
            docs_sin_firmar_row = dt.Rows.Count
        Else
            docs_sin_firmar_row = dt.Rows.Count
            GV_docs_sin_firma.DataSource = dt
            GV_docs_sin_firma.DataBind()
        End If
        'docs_sin_firmar = grid.html()
        'total_text = "Total " & dt.Rows.Count & " registros"
    End Sub

    Overridable Sub llenar_grilla_firmados()

        Dim sql As New cls_db
        Dim dt As New DataTable
        sql.parametros.Add("cuil", cls_security.usuario_actual.cuil)
        sql.parametros.Add("empresa_id", cls_security.usuario_actual.empresa_id)

        dt = sql.ejecutar_sp("SP_Docs_firmados_GRILLA")

        If dt.Rows.Count = 0 Then
            docs_firmados_row = dt.Rows.Count
        Else
            docs_firmados_row = dt.Rows.Count
            GV_docs_con_firma.DataSource = dt
            GV_docs_con_firma.DataBind()
        End If
        'total_text = "Total " & dt.Rows.Count & " registros"
    End Sub

    Private Sub GV_docs_sin_firma_RowDataBound(sender As Object, e As GridViewRowEventArgs) Handles GV_docs_sin_firma.RowDataBound

        Dim i As Integer
        For i = 1 To (GV_docs_sin_firma.Columns().Count) - 2 Step 1
            e.Row.Cells(i).Attributes("data-th") = GV_docs_sin_firma.Columns(i).HeaderText
        Next
    End Sub

    Private Sub GV_docs_con_firma_RowDataBound(sender As Object, e As GridViewRowEventArgs) Handles GV_docs_con_firma.RowDataBound
        Dim i As Integer
        For i = 1 To (GV_docs_con_firma.Columns().Count) - 2 Step 1
            e.Row.Cells(i).Attributes("data-th") = GV_docs_con_firma.Columns(i).HeaderText
        Next
    End Sub
    Sub inicializar_variables()
        Dim sql As New cls_db
        Dim dt As New DataTable
        Dim row As DataRow = cls_db.get_id("SP_Usuarios_Certificado_ID", "id", cls_security.usuario_actual.certificado_vigente_id)
        If Not IsNothing(row) Then

            If row("entrego_autorizacion") Is DBNull.Value Then
                entrego_autorizacion = "null"
            Else
                entrego_autorizacion = row("entrego_autorizacion")
            End If

            If row("certificado_id") Is DBNull.Value Then
                certificado_id = Nothing
            Else
                certificado_id = row("certificado_id")

            End If

        End If
    End Sub

    <System.Web.Services.WebMethod()> Public Shared Function recargar_usuario(ByVal cuil As String, empresa_id As String) As String
        Try
            Dim sql As New cls_db
            Dim dt As DataTable
            Dim parametros As New Dictionary(Of String, Object)

            parametros.Add("cuil", cuil)
            parametros.Add("empresa_id", empresa_id)

            dt = sql.ejecutar_sp("SP_recargar_usuario_Consul", parametros)

            If dt.Rows.Count > 0 Then
                cls_security.usuario_actual._recargar_usuario(cuil, empresa_id) 'refresca valores de usuario
                Dim user As New cls_security.cls_usuario(cuil)
                Return cls_security.usuario_actual.empresa_id
            Else
            End If
        Catch ex As Exception
            cls_utils.Log("---------")
            cls_utils.Log(ex.ToString)
            cls_utils.Log("---------")
            Return "0"
        End Try



    End Function
End Class
