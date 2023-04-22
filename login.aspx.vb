Imports System.Data

Partial Class login
    Inherits System.Web.UI.Page



    Protected Sub Page_Load(sender As Object, e As System.EventArgs) Handles Me.Load


        Response.Cache.SetExpires(DateTime.UtcNow.AddMinutes(-1))
        Response.Cache.SetCacheability(HttpCacheability.NoCache)
        Response.Cache.SetNoStore()
        If Request.QueryString("logout") = "true" Then
            Session("usuario_actual") = Nothing
            Response.Redirect("login.aspx")
        End If

    End Sub

    Protected Sub btn_aceptar_Click(sender As Object, e As EventArgs) Handles btn_aceptar.Click
        Dim formatUser As String = Replace(txt_usuario.Text, "-", "")

        Dim user As New cls_security.cls_usuario(formatUser)

        If user.login(txt_pass.Text) And user.debe_generar_pass <> 1 Then
            Response.Redirect(cls_security.usuario_actual.perfil.page_index)
        Else
            show_alert_error.Value = "true"
        End If
        If user.debe_generar_pass = 1 Then
            show_alert_error.Value = "false"
            show_alert_pass.Value = "true"
            cls_utils.Log(user.debe_generar_pass)
            cls_utils.Log(user.debe_generar_certificado)
            cls_utils.Log("- - - - - - - - - - - - - - -")
            cls_utils.Log("user: " & cls_crypto.Decrypt(user.cuil))
            cls_utils.Log("pass: " & cls_crypto.Decrypt(txt_pass.Text))
            cls_utils.Log("- - - - - - - - - - - - - - -")
            Dim pass As String = cls_crypto.Decrypt("72FCiRwsVSA=")


        End If

    End Sub
End Class
