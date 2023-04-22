Imports System.Data

Partial Class access_recovery

    Inherits System.Web.UI.Page
    Public nombre_objeto As String = "access_recovery"
    Public pagina_grilla As String = "access_recovery.aspx"
    Public nombre As String
    Public email As String
    Public emrpesa_id As String
    Public uuid As String

    ReadOnly Property pk As String
        Get
            If IsNothing(Request.Params("pk")) Then
                Return ""
            End If
            Return Request.Params("pk")
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
        step_2.Visible = False
        step_3.Visible = False
        If Not IsPostBack Then

        End If

    End Sub

    Sub inicializar_controles()
        cbo_email.Items.Add(New ListItem("No tengo acceso a ninguno de estos emails", "0"))
        cbo_email.SelectedIndex = 1
    End Sub


    <System.Web.Services.WebMethod()> Public Shared Function fill_data_email(ByVal cuil As String) As String
        Return "A"
        Try

            'Dim row As DataRow = cls_db.get_id("SP_Usuarios_Consul_email_by_cuil", "cuil", cuil)
            'Dim email As String
            'If Not IsNothing(row) Then
            'email = row("email")
            'Else
            'email = "asd"
            'cbo_email.Items.Add(New ListItem("mail******@ejemplo.com", 0))

            'Response.Redirect("login.aspx")
            'End If

            Return "1"
        Catch ex As Exception
            Return "0"
        End Try
    End Function



    Private Sub btn_comenzar_Click(sender As Object, e As EventArgs) Handles btn_comenzar.Click
        Try
            Dim sql As New cls_db
            Dim cuil As String = txt_cuil.Text
            cuil = Replace(cuil, "-", "")
            sql.parametros.Add("cuil", cuil)
            Dim dt As DataTable = sql.ejecutar_sp("SP_Usuarios_Consul_email_by_cuil")
            Dim correo As String
            Dim format_correo As String
            If Not dt.Rows.Count = 0 Then
                For i As Integer = 0 To dt.Rows.Count - 1
                    correo = dt.Rows(0)("email")
                    Dim correoArr() As String
                    correoArr = correo.Split("@")
                    correo = correoArr(0)
                    format_correo = correo.Substring(0, 4) + "******@" + correoArr(1)
                    cbo_email.Items.Add(New ListItem(format_correo, (dt.Rows(i))("empresa_id")))
                Next
                inicializar_controles()
                step_1.Visible = False
                step_2.Visible = True
                'panel_cbo_email.Update()
            Else
                ScriptManager.RegisterStartupScript(Me, Me.Page.GetType, "show_alert", "show_alert('Cuil Inválido', 'El cuil no se encuentra registrado en nuestro sistema. Verifique los datos.', 'warning');", True)
            End If
        Catch ex As Exception
            Dim err As String = ex.ToString
        End Try
    End Sub

    Private Sub btn_continuar_Click(sender As Object, e As EventArgs) Handles btn_continuar.Click
        'Dim cbo() As String
        Dim sql As New cls_db
        emrpesa_id = cbo_email.SelectedValue
        Dim empresa As String = cls_utils.nombre_de_empresa_by_empresa_id(emrpesa_id)
        Dim cuil As String = txt_cuil.Text
        cuil = Replace(cuil, "-", "")
        sql.parametros.Add("cuil", cuil)
        sql.parametros.Add("empresa_id", emrpesa_id)
        Dim dt As DataTable = sql.ejecutar_sp("SP_Usuarios_Consul_by_cuil_and_emp_id")
        If dt.Rows.Count > 0 Then
            nombre = dt.Rows(0)("nombre")
            email = dt.Rows(0)("email")
            uuid = dt.Rows(0)("uuid")
            'cls_postmark_mail.enviar_correo_generar_certificado(nombre, email, uuid, empresa)
            sql.parametros.Clear()
            sql.parametros.Add("cuil", cuil)
            sql.ejecutar_sp("SP_access_recovery_pass")
        End If
        step_2.Visible = False
        step_3.Visible = True
    End Sub
End Class




