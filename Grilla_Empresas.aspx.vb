Imports System.Data

Partial Class Grilla_Empresas
    Inherits System.Web.UI.Page

    Public tabla As String
    Public sp As String = "SP_Empresas_GRILLA"
    Public formulario As String = "Frm_Empresas.aspx"
    Public Titulo As String = "Empresas"
    Public total_text As String = ""


        Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
            If Not IsPostBack Then
                inicializar_variables()
                inicializar_controles()
            llenar_grilla()
        End If
        End Sub

        Sub inicializar_variables()
        If sp = "" AndAlso Request.QueryString("sp") <> "" Then sp = Request.QueryString("sp")
        If formulario = "" AndAlso Request.QueryString("formulario") <> "" Then formulario = Request.QueryString("formulario")
            If Titulo = "" AndAlso Request.QueryString("Titulo") <> "" Then Titulo = Request.QueryString("Titulo")
        End Sub

    Overridable Sub inicializar_controles()

    End Sub
    <System.Web.Services.WebMethod(EnableSession:=True)> Public Shared Function eliminar(ByVal id As Integer) As String
        Dim sql As New cls_db
        sql.parametros.Add("id", id)
        sql.ejecutar_sp("SP_Empresas_DELETE")
        Return "true"
    End Function


    Sub llenar_grilla()

        Dim sql As New cls_db
        Dim dt As New DataTable

        dt = sql.ejecutar_sp(sp)

        Dim grilla As New cls_grid(dt, formulario)
        If grilla.dt.Rows.Count > 0 Then
            GV_empresas.DataSource = dt
            GV_empresas.DataBind()
            panel_empresas.Update()

        Else
            tabla = "<br/><center><h4>No hay Resultados para esta Búsqueda</h4></center><br/>"
        End If
    End Sub


End Class

