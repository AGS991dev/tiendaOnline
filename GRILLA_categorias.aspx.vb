

Imports System.Data

Partial Class GRILLA_categorias
    Inherits System.Web.UI.Page

    Public tabla As String
    Public sp As String = "SP_categorias_GRILLA"
    Public formulario As String = "Frm_categorias.aspx"
    Public Titulo As String = "Categorías"
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

    Overridable Sub llenar_grilla()

        Dim sql As New cls_db
        Dim dt As New DataTable
        dt = sql.ejecutar_sp(sp)

        Dim grid As New cls_grid(dt, formulario)
        grid.show_delete = True
        If formulario = "" Then

            grid.show_edit = False
            grid.show_view = False
        End If
        tabla = grid.html()

        total_text = "Total " & dt.Rows.Count & " registros"
    End Sub



End Class

