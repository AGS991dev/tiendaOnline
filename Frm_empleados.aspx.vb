Imports System.Data
Imports System.IO

Partial Class Frm_empleados
    Inherits System.Web.UI.Page

    Public nombre_objeto As String = "Empleado"
    Public pagina_grilla As String = "Grilla_Empleados.aspx"
    Public debe_generar_pass As Integer
    Public entrego_auth As String
    Public post_msg_error As String = ""

    ReadOnly Property pk As String
        Get
            If IsNothing(Request.Params("id")) Then
                Return ""
            End If
            Return Request.Params("id")
        End Get
    End Property

    ReadOnly Property es_alta As Boolean
        Get
            Return (pk = "")
        End Get
    End Property

    ReadOnly Property titulo As String
        Get

            If (es_alta) Then
                Return "Nuevo " & nombre_objeto
            Else
                Return "Modificación de " & nombre_objeto
            End If

        End Get
    End Property


    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Try
            If pk <> "" Then
                recurso_valido(cls_security.usuario_actual.empresa_id, pk) 'tabla usuarios
            End If
            If Not IsPostBack Then
                If Not es_alta Then fill_data()
            End If

        Catch ex As Exception
            cls_utils.Log("---------")
            cls_utils.Log(ex.ToString)
            cls_utils.Log("---------")
            cls_utils.redirect_msg_error(Response, "login.aspx", "Logueo expirado, vuelva a iniciar sesión por favor.")
        End Try

    End Sub
    Function recurso_valido(empresa_id As Integer, id_recuros As Integer) As Boolean

        Dim sql As New cls_db
        sql.parametros.Add("empresa_id", empresa_id)
        sql.parametros.Add("id_recurso", id_recuros)


        Dim dt As DataTable = sql.ejecutar_sp("SP_validar_recurso_usuarios")
        If IsNothing(dt(0)) Then
            Session("toast_denegado") = "Acesso Restringido"
            Response.Redirect(pagina_grilla)
            Return False
        End If
        If Not IsNothing(dt(0)) Then
            Return True
        End If
        'y que haga un query dinámico en la base tipo
        'select  * from tabla where campo = valor and id = id_recurso
        'entonces si existe el registro es válido, sino existe es inválido

    End Function

    Private Sub btn_save_Click(sender As Object, e As EventArgs) Handles btn_save.Click
        guardar()
    End Sub

    Sub fill_data()

        Dim row As DataRow = cls_db.get_id("SP_Usuarios_Consul_ID", "id", pk)

        If Not IsNothing(row) Then
            debe_generar_pass = row("debe_generar_pass")
            Session("uuid") = row("uuid") ' 
            txt_Nombre.Text = row("nombre")
            txt_apellido.Text = row("apellido")

            If Not IsDBNull(row("legajo")) Then
                txt_legajo.Text = row("legajo")
                If row("legajo") = "---" Then
                    txt_legajo.Visible = False
                    lbl_legajo.Visible = False
                End If
            End If
            If Not IsDBNull(row("auth_signed")) Then
                entrego_auth = row("auth_signed")
            Else
                entrego_auth = "NO"
            End If

            txt_email.Text = row("email")
            txt_cuil.Text = row("cuil")


            'SI ACCEDO A UN EMPLEADO QUE NO ES DE MI EMPRESA
            If cls_security.usuario_actual.empresa_id <> row("empresa_id") Then
                Response.Redirect("login.aspx")
            End If
        End If

    End Sub


    Function insertar() As Boolean
        Dim sql As New cls_db
        Dim cuil As String = Replace(txt_cuil.Text, "-", "")
        Dim uuid As String = cls_utils.generar_uuid
        'sql.parametros.Add("pass", cls_crypto.Encrypt(txt_pass.Text))
        sql.parametros.Add("nombre", txt_Nombre.Text)
        sql.parametros.Add("apellido", txt_apellido.Text)
        sql.parametros.Add("legajo", txt_legajo.Text)

        sql.parametros.Add("email", txt_email.Text)
        sql.parametros.Add("cuil", cuil)
        sql.parametros.Add("perfil_codigo", cls_security.PERFIL_EMPLEADO)
        sql.parametros.Add("empresa_id", cls_security.usuario_actual.empresa_id)
        sql.parametros.Add("uuid", uuid)

        Dim dt As DataTable = sql.ejecutar_sp("SP_empleados_INSERT")
        sql.parametros.Clear()

        sql.parametros.Add("cuil", cuil)
        Dim usuarioLogin_existe As DataTable = sql.ejecutar_sp("SP_UsuariosLogin_ConsulByCuil")
        sql.parametros.Clear()

        If usuarioLogin_existe.Rows.Count = 0 Then
            sql.parametros.Add("cuil", cuil)
            sql.parametros.Add("pass", DBNull.Value)
            sql.ejecutar_sp("SP_UsuariosLogin_INSERT")
        End If
        If cls_security.usuario_actual.es_supervisor Then
            Dim empresa As String = cls_utils.nombre_de_empresa_by_empresa_id(cls_security.usuario_actual.empresa_id)
            'cls_postmark_mail.enviar_correo_generar_certificado(txt_Nombre.Text, txt_email.Text, uuid, empresa)
        End If
        cls_utils.redirect_msg(Response, pagina_grilla, "Nuevo Empleado Creado") 'se le envia el mail automaticamente cuando se inserta por primera vez

        'primer parámetro: Nombre del empleado
        'segundo parámetro: Email del empleado
        'tercer parámetro url del asistente: acá tenés que calcularla, con el hash que se generó para ese empleado https://codigonativo.com.ar
        Return True
    End Function

    Function actualizar() As Boolean

        Dim sql As New cls_db
        sql.parametros.Add("id", pk)
        sql.parametros.Add("nombre", txt_Nombre.Text)
        sql.parametros.Add("apellido", txt_apellido.Text)
        sql.parametros.Add("legajo", txt_legajo.Text)

        sql.parametros.Add("email", txt_email.Text)
        Dim cuil As String = Replace(txt_cuil.Text, "-", "")
        sql.parametros.Add("cuil", cuil)
        sql.parametros.Add("empresa_id", cls_security.usuario_actual.empresa_id)
        sql.ejecutar_sp("SP_Usuarios_UPDATE") 'Primer sp

        cls_utils.redirect_msg(Response, "Grilla_empleados.aspx", "Cambios guardados correctamente")

        Return True

    End Function


    <System.Web.Services.WebMethod(EnableSession:=True)> Public Shared Function eliminar(ByVal id As String) As String
        Dim sql As New cls_db
        Dim usuario_baja_id As Integer = cls_security.usuario_actual.id
        sql.parametros.Add("id", id)
        sql.parametros.Add("usuario_baja_id", usuario_baja_id)
        sql.ejecutar_sp("SP_Usuarios_DELETE")

        Return "true"


    End Function


    <System.Web.Services.WebMethod()> Public Shared Function existe_codigo(ByVal codigo As String, empresa_id As String) As String
        Dim sql As New cls_db
        Dim mydt As DataTable
        Dim parametros As New Dictionary(Of String, Object)

        parametros.Add("codigo", codigo)
        parametros.Add("empresa_id", empresa_id)
        mydt = sql.ejecutar_sp("SP_Usuarios_from_empresa_id_Consul", parametros)

        If mydt.Rows.Count = 0 Then
            Return "1"
        Else
            Return "0"
        End If



    End Function




    Sub guardar()

        Dim resultado_transaccion As Boolean

        If es_alta Then
            resultado_transaccion = insertar()
        Else
            resultado_transaccion = actualizar()
        End If

        If resultado_transaccion = True Then
            Response.Redirect(pagina_grilla)
        End If

    End Sub

End Class
