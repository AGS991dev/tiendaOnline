Imports System.Data

Partial Class Grilla_Empleados
    Inherits System.Web.UI.Page

    Public tabla As String
    Public sp As String = "SP_Empleados_GRILLA"
    Public formulario As String = "Frm_Empleados.aspx"
    Public Titulo As String = "Empleados"
    Public total_text As String = ""
    Public system_name As String = ConfigurationManager.AppSettings("system_name").ToString() '"firma_nativa" ' esta variable cambia la estetica de la pagina , firma_nativa, san_antonio


    Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        btn_reenviar_mail.Visible = False

        If Not IsPostBack Then
            Try
                inicializar_variables()
                inicializar_controles()
                llenar_grilla_primera_vez(1) '0 = ver todos los empleados 1 = a ver activos 2 = desvinculados
            Catch ex As Exception
                cls_utils.redirect_msg_error(Response, "login.aspx", "La sesión ha expirado, vuelve a iniciar Sesión.")
            End Try
        End If
    End Sub

    Sub inicializar_variables()
        If sp = "" AndAlso Request.QueryString("sp") <> "" Then sp = Request.QueryString("sp")
        If formulario = "" AndAlso Request.QueryString("formulario") <> "" Then formulario = Request.QueryString("formulario")
        If Titulo = "" AndAlso Request.QueryString("Titulo") <> "" Then Titulo = Request.QueryString("Titulo")
    End Sub
    Private Sub btn_filtrar_Click(sender As Object, e As EventArgs) Handles btn_filtrar.Click

        Dim estado As String = cbo_estado.SelectedValue
        llenar_grilla(estado)
        ScriptManager.RegisterStartupScript(Me, Me.Page.GetType, "refresh_filter", "refresh_filter()", True)

    End Sub


    <System.Web.Services.WebMethod(EnableSession:=True)> Public Shared Function eliminar(ByVal id As Integer, ByVal cuil As String) As String

        'Dim empresa_id As Integer = cls_security.usuario_actual.empresa_id
        'Dim certificado_id As Integer = cls_utils.certificado_del_empleado(cuil, empresa_id)
        'Dim empresas_trabajadas As DataTable = cls_utils.empresas_del_empleado(cuil) 'Ver para cuantas empresas trabaja este empleado
        'Dim docs_firmados_de_mi_empresa As DataTable = cls_utils.documentos_firmados(cuil) 'Ver documentos firmados de la empresa del supervisor. -> CUil y Empresa ID

        'If empresas_trabajadas.Rows.Count > 1 Then ' ----------- TRABAJA PARA VARIAS EMPRESAS
        '    If docs_firmados_de_mi_empresa.Rows.Count = 0 Then ' NO FIRMO NADA en mi empresa
        '        cls_utils.baja_fisica(id)
        '        cls_utils.borrar_certificados_fisicos_de_mi_empresa(empresa_id, cuil, certificado_id)
        '    Else 'SI FIRMO DOCUMENTOS en mi empresa
        '        cls_utils.baja_logica(id)
        '    End If
        'Else ' ------------------------------------------------- TRABAJA PARA 1 SOLA EMPRESA
        '    If docs_firmados_de_mi_empresa.Rows.Count = 0 Then ' NO FIRMO NADA  en mi empresa
        '        cls_utils.eliminar_login(cuil, id)
        '        cls_utils.baja_fisica(id)
        '        cls_utils.borrar_certificados_fisicos_de_mi_empresa(empresa_id, cuil, certificado_id)
        '    Else 'SI FIRMO DOCUMENTOS en mi empresa
        '        cls_utils.baja_logica(id) 'else hacer baja logica
        '    End If
        'End If

        Return "true"

    End Function


    Sub llenar_grilla_primera_vez(estado As String)

        Dim sql As New cls_db
        Dim dt As New DataTable

        sql.parametros.Add("empresa_id", cls_security.usuario_actual.empresa_id)
        sql.parametros.Add("estado", estado)

        dt = sql.ejecutar_sp("SP_empleados_GRILLA_filtro")

        Dim grilla As New cls_grid(dt, formulario)
        If grilla.dt.Rows.Count > 0 Then
            GV_empleados.DataSource = dt
            GV_empleados.DataBind()
            GV_empleados.Visible = True
            panel_empleados.Update()

        Else
            tabla = "<br/><center class='tabla_vacia'><h6>La lista de Empleados está Vacia, Puedes dar de Alta empleados utilizando los botones en pantalla.</h6></center><br/>"
            GV_empleados.Visible = False
            panel_empleados.Update()
        End If
        'ScriptManager.RegisterStartupScript(Me, Me.Page.GetType, "refresh_filter", "refresh_filter()", True)
    End Sub
    Sub llenar_grilla(estado As String)

        Dim sql As New cls_db
        Dim dt As New DataTable

        sql.parametros.Add("empresa_id", cls_security.usuario_actual.empresa_id)
        sql.parametros.Add("estado", estado)

        dt = sql.ejecutar_sp("SP_empleados_GRILLA_filtro")

        Dim grilla As New cls_grid(dt, formulario)
        If grilla.dt.Rows.Count > 0 Then
            GV_empleados.DataSource = dt
            GV_empleados.DataBind()
            GV_empleados.Visible = True
            panel_empleados.Update()

        Else
            tabla = "<br/><center class='tabla_vacia'><h6>Sin Registros</h6></center><br/>"
            GV_empleados.Visible = False
            panel_empleados.Update()

        End If
        ScriptManager.RegisterStartupScript(Me, Me.Page.GetType, "modal_espere_off", "modal_espere_off()", True)
    End Sub

    Overridable Sub inicializar_controles()
        cbo_estado.Items.Add(New ListItem("TODOS", 0))
        cbo_estado.Items.Add(New ListItem("ACTIVOS", 1))
        cbo_estado.Items.Add(New ListItem("DESVINCULADOS", 2))
        cbo_estado.SelectedIndex = 1

    End Sub

    Private Sub GV_empleados_RowDataBound(sender As Object, e As GridViewRowEventArgs) Handles GV_empleados.RowDataBound
        If (e.Row.RowType = DataControlRowType.Header) Then
            e.Row.TableSection = TableRowSection.TableHeader
        End If
        Dim i As Integer
        For i = 0 To (GV_empleados.Columns().Count) - 2 Step 1
            e.Row.Cells(i).Attributes("data-th") = GV_empleados.Columns(i).HeaderText
        Next
    End Sub

    Private Sub btn_reenviar_mail_Click(sender As Object, e As EventArgs) Handles btn_reenviar_mail.Click
        Dim msg As String = "Emails Reenviados con Éxito"
        Dim sql As New cls_db
        Dim dt As New DataTable
        sql.parametros.Add("empresa_id", cls_security.usuario_actual.empresa_id)
        dt = sql.ejecutar_sp("SP_Empleados_en_proceso_reenviar_mail")

        Try
            For Each row As DataRow In dt.Rows
                Dim id As String = row("id")
                Dim nombre_y_apellido As String = row("Nombre_y_Apellido")
                Dim email As String = row("email")
                Dim uuid As String = row("uuid")
                Dim empresa As String = cls_utils.nombre_de_empresa_by_empresa_id(cls_security.usuario_actual.empresa_id)
                'cls_postmark_mail.enviar_correo_generar_certificado(nombre_y_apellido, email, uuid, empresa)
            Next
        Catch ex As Exception
            Session("toast_denegado") = "Ocurrió un error inesperado"
        End Try
        cls_utils.redirect_msg(Response, "Grilla_empleados.aspx", msg)

    End Sub

End Class

