Imports System.Data

Partial Class Grilla_stock
    Inherits System.Web.UI.Page

    Public tabla As String
    Public sp As String = "SP_stock_GRILLA"
    Public formulario As String = "Frm_stock.aspx"
    Public Titulo As String = "Stock"
    Public total_text As String = ""
    Public categorias As New List(Of String)
    Public index_categoria As Integer = 0



    Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            inicializar_variables()
            inicializar_controles()
            consultar_categorias()
            llenar_grilla()
            llenar_grilla_tabla()
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
        sql.ejecutar_sp("SP_Stock_DELETE")
        Return "true"
    End Function
    <System.Web.Services.WebMethod(EnableSession:=True)> Public Shared Function inicializar_grafico_inicio(ByVal id As Integer) As String
        Dim sql As New cls_db
        Dim dt As DataTable = sql.ejecutar_sp("SP_stock_GRILLA")
        Dim i As Integer
        Dim _categorias As String = ""
        Dim _cantidades As String = ""

        For i = 0 To (dt.Rows().Count) - 1 Step 1
            Dim categoria As String = dt.Rows(i).ItemArray(1)
            Dim cantidad As String = dt.Rows(i).ItemArray(3)
            If i = 0 Then
                _categorias = categoria
                _cantidades = cantidad
            Else
                _categorias = _categorias & "," & categoria
                _cantidades = _cantidades & "," & cantidad
            End If
        Next
        Dim data As String = _categorias & "/" & _cantidades
        Return data
    End Function


    Sub consultar_categorias()
        Dim sql As New cls_db
        Dim dt As DataTable = sql.ejecutar_sp("SP_stock_categorias_CONSUL")
        For Each row As DataRow In dt.Rows
            If Not row("categoria") Is Nothing Then
                categorias.Add(row("categoria"))
            End If
        Next

    End Sub

    Sub llenar_grilla()

        Dim sql As New cls_db
        Dim dt As New DataTable

        dt = sql.ejecutar_sp(sp)

        Dim grilla As New cls_grid(dt, formulario)
        If grilla.dt.Rows.Count > 0 Then
            GV_empresas.DataSource = dt
            GV_empresas.DataBind()
            GV_empresas.HeaderRow.TableSection = TableRowSection.TableHeader
            panel_empresas.Update()
        Else
            tabla = "<br/><center><h4>No hay Resultados para esta Búsqueda</h4></center><br/>"
        End If
    End Sub
    Sub llenar_grilla_tabla()
        Dim sql As New cls_db
        Dim dt As New DataTable
        dt = sql.ejecutar_sp("SP_stock_GRILLA_table")
        Dim grilla As New cls_grid(dt, formulario)
        tabla = grilla.html()
    End Sub

    <System.Web.Services.WebMethod(EnableSession:=True)> Public Shared Function recarga_grafico(ByVal hi_categoria As String) As String
        Dim sql As New cls_db
        Dim sql_string As String = "SELECT * FROM productos where categoria = "
        Dim empieza_con As String = ""

        If Not hi_categoria = "" Then
            empieza_con = hi_categoria.Substring(0, 1)
        End If
        Dim categorias_procesado As String = ""
        If empieza_con = "," Then
            categorias_procesado = hi_categoria.Substring(1, hi_categoria.Length - 1)
        End If
        Dim categorias_arr As Array = categorias_procesado.Split(",")

        Dim i As Integer
        For i = 0 To categorias_arr.Length() - 1 Step 1
            If i = 0 Then
                If Not categorias_arr(i) = "" Then
                    sql_string += "'" & categorias_arr(i) & "'"
                Else
                    sql_string += "categoria"
                End If
            Else
                If Not categorias_arr(i) = "" Then
                    sql_string += " or categoria = '" & categorias_arr(i) & "'"
                Else
                    sql_string += "categoria"
                End If
            End If
        Next

        If hi_categoria = "" Then
            Return "/"
        End If

        Dim dt As DataTable = sql.ejecutar(sql_string)

        Dim _categorias As String = ""
        Dim _cantidades As String = ""

        For i = 0 To (dt.Rows().Count) - 1 Step 1
            Dim categoria As String = dt.Rows(i).ItemArray(1)
            Dim cantidad As String = dt.Rows(i).ItemArray(3)
            If i = 0 Then
                _categorias = categoria
                _cantidades = cantidad
            Else
                _categorias = _categorias & "," & categoria
                _cantidades = _cantidades & "," & cantidad
            End If
        Next
        Return _categorias & "/" & _cantidades
    End Function


    Private Sub btn_filter_Click(sender As Object, e As EventArgs) Handles btn_filter.Click
        llenar_grilla_tabla()
        Update_grilla.Update()

        Dim sql_string As String = "SELECT * FROM productos where categoria = "
        Dim hi_categoria As String = hi_categoria_filter.Value
        Dim categorias As Array = hi_categoria.Split(",")
        Dim empieza_con As String = ""
        Dim categorias_procesado As String = hi_categoria

        If Not hi_categoria = "" Then
            empieza_con = hi_categoria.Substring(0, 1)
            If empieza_con.Contains(",") Then
                categorias_procesado = hi_categoria.Substring(1, hi_categoria.Length - 1)
            End If
        End If

        Dim categorias_arr As Array = categorias_procesado.Split(",")

        For i = 0 To categorias_arr.Length() - 1 Step 1
            If i = 0 Then
                sql_string += "'" & categorias_arr(i) & "'"
            Else
                sql_string += " or categoria = '" & categorias_arr(i) & "'"
            End If
        Next
        If hi_categoria = "" Then
            ScriptManager.RegisterStartupScript(Me, Me.Page.GetType, "procesar_toast", "procesar_toast('SELECCIONÁ AL MENOS UN FILTRO','error')", True)
            Return
        End If


        Dim sql As New cls_db
        Dim dt As New DataTable

        Dim sql_query_grilla As String = "SELECT id as [Artículo ID], codigo_barra, categoria, nombre, cantidad, tamaño, precio from productos"
        Dim where As String = sql_string.Replace("SELECT * FROM productos", sql_query_grilla)
        dt = sql.ejecutar(where)
        Dim grilla_1 As New cls_grid(dt, formulario)
        tabla = grilla_1.html()
        Update_grilla.Update()


        dt = sql.ejecutar(sql_string)

        Dim row As DataRow = dt(0)

        Dim grilla As New cls_grid(dt, formulario)
        If grilla.dt.Rows.Count > 0 Then
            GV_empresas.DataSource = dt
            GV_empresas.DataBind()
            GV_empresas.HeaderRow.TableSection = TableRowSection.TableHeader
            panel_empresas.Update()
            ScriptManager.RegisterStartupScript(Me, Me.Page.GetType, "refresh_filter", "refresh_filter()", True)
            'ScriptManager.RegisterStartupScript(Me, Me.Page.GetType, "refrescar_grafico_categorias_circular", "refrescar_grafico_categorias_circular(""" & _categorias & """,""" & _cantidades & """)", True)
            'ScriptManager.RegisterStartupScript(Me, Me.Page.GetType, "refrescar_grafico_categorias", "refrescar_grafico_categorias(""" & _categorias & """,""" & _cantidades & """)", True)
        Else
            'ScriptManager.RegisterStartupScript(Me, Me.Page.GetType, "destroy_chart", "destroy_chart()", True)
            tabla = "<br/><center><h4>No hay Resultados para esta Búsqueda</h4></center><br/>"
            'avisar al señor q no tiene datos en pantalla
        End If
    End Sub

End Class

