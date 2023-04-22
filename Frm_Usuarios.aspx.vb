Imports System.Data
Imports System.Data.OleDb

Partial Class Frm_Usuarios
    Inherits System.Web.UI.Page
    Public nombre_objeto As String = "usuario"
    Public uuid As String
    Public pagina_grilla As String = "Grilla_Usuarios.aspx"
    Public debe_generar_cert As Integer
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

        If Not IsPostBack Then
            inicializar_controles()
            If Not es_alta Then fill_data()
        End If

    End Sub


    Private Sub btn_save_Click(sender As Object, e As EventArgs) Handles btn_save.Click
        guardar()
    End Sub

    Sub inicializar_controles()

        cls_utils.cargar_combo(cbo_perfil, "SP_Perfiles_CONSUL_admin", "codigo", "descripcion")
        cls_utils.cargar_combo(cbo_empresa, "SP_Empresas_CONSUL", "id", "razon_social")
        'cbo_empresa.Items.Add(New ListItem("Ninguna", "0"))
        cbo_empresa.SelectedValue = 0
        'cbo_perfil.Items.Add(New ListItem("Sin Asignar", "0"))
        'cbo_empresa.Items.Add(New ListItem("Sin Asignar", "0"))

    End Sub


    Sub fill_data()

        Dim row As DataRow = cls_db.get_id("SP_Usuarios_Consul_ID", "id", pk)

        If Not IsNothing(row) Then
            txt_legajo.Text = row("legajo")
            txt_Nombre.Text = row("nombre")
            txt_apellido.Text = row("apellido")
            txt_email.Text = row("email")
            txt_cuil.Text = row("cuil")
            cbo_perfil.SelectedValue = row("perfil_codigo")
            uuid = row("uuid")

            debe_generar_pass = row("debe_generar_pass")


            If Not IsDBNull(row("empresa_id")) Then
                cbo_empresa.SelectedValue = row("empresa_id")
            Else
                cbo_empresa.SelectedIndex = 0
            End If
        End If
    End Sub



    Function insertar() As Boolean
        Dim sql As New cls_db
        Dim cuil As String = Replace(txt_cuil.Text, "-", "")
        Dim enviar_mail As Boolean = False

        sql.parametros.Add("cuil", cuil)
        Dim usuarioLogin_existe As DataTable = sql.ejecutar_sp("SP_UsuariosLogin_ConsulByCuil")
        sql.parametros.Clear()

        If usuarioLogin_existe.Rows.Count = 0 Then
            sql.parametros.Add("cuil", cuil)
            sql.parametros.Add("pass", DBNull.Value)
            sql.ejecutar_sp("SP_UsuariosLogin_INSERT")
            sql.parametros.Clear()
            enviar_mail = True
        End If

        sql.parametros.Add("nombre", txt_Nombre.Text)
        sql.parametros.Add("apellido", txt_apellido.Text)
        sql.parametros.Add("legajo", txt_legajo.Text)

        sql.parametros.Add("email", txt_email.Text)

        sql.parametros.Add("cuil", cuil)

        If cbo_perfil.SelectedValue <> 1 Then
            sql.parametros.Add("perfil_codigo", cbo_perfil.SelectedValue)
        Else
            sql.parametros.Add("perfil_codigo", 1)
        End If

        sql.parametros.Add("empresa_id", cbo_empresa.SelectedValue)

        Dim uuid_generado As String = cls_utils.generar_uuid()
        sql.parametros.Add("uuid", uuid_generado)

        Dim empresa As String = cls_utils.nombre_de_empresa_by_empresa_id(cbo_empresa.SelectedItem.Value)

        Dim dt As DataTable = sql.ejecutar_sp("SP_Usuarios_INSERT")

        cls_utils.redirect_msg(Response, "Grilla_Usuarios.aspx", "Usuario Insertado Correctamente")

        Return True
    End Function

    Function actualizar() As Boolean

        Dim sql As New cls_db
        Dim cuil As String = Replace(txt_cuil.Text, "-", "")
        sql.parametros.Add("id", pk)

        sql.parametros.Add("nombre", txt_Nombre.Text)
        sql.parametros.Add("apellido", txt_apellido.Text)
        sql.parametros.Add("legajo", txt_legajo.Text)
        sql.parametros.Add("email", txt_email.Text)
        sql.parametros.Add("cuil", cuil)
        'sql.parametros.Add("perfil_codigo", cbo_perfil.SelectedValue)
        sql.parametros.Add("empresa_id", cbo_empresa.SelectedValue)

        sql.ejecutar_sp("SP_Usuarios_UPDATE")
        cls_utils.redirect_msg(Response, "Grilla_Usuarios.aspx", "Usuario Actualizado Correctamente")

        Return True

    End Function



    <System.Web.Services.WebMethod(EnableSession:=True)> Public Shared Function eliminar(ByVal id As String) As String
        Dim sql As New cls_db
        sql.parametros.Add("id", id)
        sql.parametros.Add("usuario_baja_id", cls_security.usuario_actual.id)

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


