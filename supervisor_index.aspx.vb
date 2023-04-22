Imports System.Web.Hosting
Imports System.Data

Partial Class supervisor_index
    Inherits System.Web.UI.Page

    Public path As String = ""
    Public pedidos_pendientes As Integer

    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load

        Dim sql As New cls_db
        Dim dt As DataTable = sql.ejecutar_sp("SP_Pedidos_pendientes_contador")
        Dim row As DataRow = dt.Rows(0)
        pedidos_pendientes = CInt(row("pedidos_pendientes"))
        Dim system_name As String = ConfigurationManager.AppSettings("system_name").ToString()
        If system_name = "san_antonio" Then
            path = "san_antonio"
        End If
        If system_name = "firma_nativa" Then
            path = "firma_nativa"
        End If

    End Sub

    <System.Web.Services.WebMethod()> Public Shared Function mis_documentos(ByVal codigo As String, objid As String) As String
        Dim sql As New cls_db
        Dim debe_generar_cert As Boolean
        Dim debe_generar_pass As Boolean

        Dim row As DataRow = cls_db.get_id("SP_Usuarios_Consul_ID", "id", cls_security.usuario_actual.id)

        If Not IsNothing(row) Then
            debe_generar_cert = row("debe_generar_certificado")
            debe_generar_pass = row("debe_generar_pass")
        End If

        If debe_generar_pass = True Then 'debe_generar_cert = True Or 
            Return "0" '0
        Else
            Return "1"
        End If



    End Function
End Class
