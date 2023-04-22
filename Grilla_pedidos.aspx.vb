Imports System.Data

Partial Class Grilla_pedidos
    Inherits System.Web.UI.Page

    Public tabla As String
    Public sp As String = "SP_pedidos_GRILLA"
    Public formulario As String = "Frm_pedidos.aspx"
    Public Titulo As String = "Pedidos"
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
    <System.Web.Services.WebMethod(EnableSession:=True)> Public Shared Function actualizar_pedido_entregado(ByVal pedido As Integer) As String
        Dim sql As New cls_db

        sql.parametros.Add("id", pedido)
        Dim dt As DataTable = sql.ejecutar_sp("SP_pedido_lista_GRILLA")
        sql.parametros.Clear()

        Dim identity As Integer
        Dim codigo As Integer
        Dim cantidad As Integer
        Dim monto As Integer
        Dim cantidad_total As Integer

        Try
            monto = CInt(dt.Rows(0)(11)) 'precio_total
            sql.parametros.Add("usuario_id", cls_security.usuario_actual.id)
            sql.parametros.Add("concepto_id", 1) ' 1 es ventas
            sql.parametros.Add("monto", monto)
            dt = sql.ejecutar_sp("SP_registro_INSERT")
            sql.parametros.Clear()
            identity = dt(0)(0)

            sql.parametros.Clear()
            sql.parametros.Add("id", pedido)
            dt = sql.ejecutar_sp("SP_pedido_lista_GRILLA")
            sql.parametros.Clear()

            For Each row As DataRow In dt.Rows
                sql.parametros.Add("codigo_barra", row("codigo_barra")) 'cod_barra
                sql.parametros.Add("cantidad", row("cantidad"))
                sql.ejecutar_sp("SP_stock_RESTAR")
                sql.parametros.Clear()
                'separacion de procedimientos

                sql.parametros.Add("codigo_barra", row("codigo_barra")) 'cod_barra
                sql.parametros.Add("cantidad", row("cantidad"))
                sql.parametros.Add("venta_id", identity)
                sql.parametros.Add("cantidad_total", 1)
                sql.ejecutar_sp("SP_ticket_INSERT")
                cantidad_total += row("cantidad")

                sql.parametros.Clear()
            Next
            sql.parametros.Clear()
            sql.parametros.Add("id", pedido)
            sql.ejecutar_sp("SP_pedidos_UPDATE_to_ENTREGADO") 'ir a table tickets a busar todos los productos y descontarlos
            sql.parametros.Clear()
            sql.parametros.Add("venta_id", identity)
            sql.parametros.Add("cantidad_total", cantidad_total) 'ir a table tickets y actualizar la cantidad total
            sql.ejecutar_sp("SP_pedidos_UPDATE_cantidad_total")
        Catch ex As Exception
            Dim err As String = ex.ToString
            Return False
        End Try
        Return identity.ToString
    End Function
    <System.Web.Services.WebMethod(EnableSession:=True)> Public Shared Function actualizar_pedido_enproceso(ByVal pedido As Integer) As String
        Dim sql As New cls_db
        sql.parametros.Add("id", pedido)
        sql.ejecutar_sp("SP_pedidos_UPDATE_to_EN_PROCESO")
        Return "true"
    End Function

    <System.Web.Services.WebMethod(EnableSession:=True)> Public Shared Function comprar(ByVal id As Integer) As String
        Dim sql As New cls_db
        sql.parametros.Add("id", id)
        'sql.ejecutar_sp("SP_Stock_COMPRAR")
        Return "true"
    End Function

    Sub llenar_grilla()

        Dim sql As New cls_db
        Dim dt As New DataTable

        dt = sql.ejecutar_sp(sp)

        Dim grilla As New cls_grid(dt, formulario)
        If grilla.dt.Rows.Count > 0 Then
            GV_pedidos.DataSource = dt
            GV_pedidos.DataBind()
            GV_pedidos.HeaderRow.TableSection = TableRowSection.TableHeader

            panel_pedidos.Update()

        Else
            tabla = "<br/><center><h4>No hay Resultados para esta Búsqueda</h4></center><br/>"
        End If
    End Sub


End Class

