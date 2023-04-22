Imports System.Data

Partial Class grilla_ranking
    Inherits System.Web.UI.Page

    Public tabla As String
    Public tabla_vacia As Boolean = False
    Public sp As String = "SP_RANKING_FILTRAR"
    Public formulario As String = "grilla_ranking.aspx"
    Public Titulo As String = "RANKING"
    'Public categorias As New List(Of String)


    Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            inicializar_variables()
            inicializar_controles()
            'llenar_grilla() 
            filldata()
        End If
    End Sub

    Sub inicializar_variables()
        'If sp = "" AndAlso Request.QueryString("sp") <> "" Then sp = Request.QueryString("sp")
        If formulario = "" AndAlso Request.QueryString("formulario") <> "" Then formulario = Request.QueryString("formulario")
        If Titulo = "" AndAlso Request.QueryString("Titulo") <> "" Then Titulo = Request.QueryString("Titulo")
    End Sub

    Sub inicializar_controles()

        cbo_categoria.Items.Add(New ListItem("Todas", -1))
        cargar_cbo_categoria()
        panel_btn_filtrar.Update()
    End Sub


    Sub cargar_cbo_categoria()
        Dim sql As New cls_db
        Dim dt_tkt As DataTable
        dt_tkt = sql.ejecutar_sp("SP_Categorias_CONSUL")
        For Each dr As DataRow In dt_tkt.Rows
            cbo_categoria.Items.Add(New ListItem(dr("descripcion"), dr("id")))
        Next
    End Sub


    Private Sub btn_filtrar_Click(sender As Object, e As EventArgs) Handles btn_filtrar.Click
        filldata()
    End Sub
    Sub filldata()
        Dim sql As New cls_db
        Dim desde As String = "" ' txt_desde.Text
        Dim hasta As String = "" 'txt_hasta.Text
        sql.parametros.Add("categoria_id", cbo_categoria.SelectedValue)

        Dim dt As DataTable = sql.ejecutar_sp("SP_RANKING_FILTRAR", sql.parametros)

        Dim grilla As New cls_grid(dt, formulario)
        If grilla.dt.Rows.Count > 0 Then
            tabla_vacia = False
            GV_ranking.Visible = True
            GV_ranking.DataSource = dt
            GV_ranking.DataBind()
            GV_ranking.HeaderRow.TableSection = TableRowSection.TableHeader
            panel_ranking.Update()
            panel_btn_filtrar.Update()
        Else
            GV_ranking.Visible = False
            tabla_vacia = True
            tabla = "<br/><center><h4>No hay Resultados para esta Búsqueda</h4></center><br/>"
        End If

    End Sub
End Class

