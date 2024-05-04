Imports System.Data

Partial Class shop
    Inherits System.Web.UI.Page

    Public sp As String = "SP_stock_GRILLA"
    Public table As DataTable
    Public formulario As String = "Frm_stock.aspx"
    Public numero_whatsapp As String = ""
    Public categorias As New List(Of String)


    Protected Sub Page_Load(sender As Object, e As System.EventArgs) Handles Me.Load

        llenar_grilla()
        inicializar_variables()
        inicializar_controles()
    End Sub

    Sub inicializar_controles()
        Dim sql As New cls_db
        Dim dt As DataTable = sql.ejecutar_sp("SP_Categorias_GRILLA")
        For Each row As DataRow In dt.Rows
            categorias.Add(row(1))
        Next
    End Sub


    Sub inicializar_variables()
        Dim sql As New cls_db
        Dim dt As DataTable = sql.ejecutar_sp("SP_WHATSAPP_CONSUL")
        numero_whatsapp = dt(0)(1)
    End Sub

    <System.Web.Services.WebMethod(EnableSession:=True)> Public Shared Function comprar(ByVal id As Integer) As String
        Dim sql As New cls_db
        sql.parametros.Add("id", id)
        'sql.ejecutar_sp("SP_Stock_COMPRAR")
        Return "true"
    End Function
    <System.Web.Services.WebMethod(EnableSession:=True)> Public Shared Function articulo_consul(ByVal art_id As Integer) As String
        'Dim sql As New cls_db
        'sql.parametros.Add("id", art_id)
        'Dim dt As DataTable = sql.ejecutar_sp("SP_stock_Consul_ID")
        'Dim art_string As String = ""

        'Return art_string
    End Function


    Sub llenar_grilla()

        Dim sql As New cls_db
        Dim dt As New DataTable

        dt = sql.ejecutar_sp(sp)
        table = dt
        Dim grilla As New cls_grid(dt, formulario)
        If grilla.dt.Rows.Count > 0 Then
            GV_shop.DataSource = dt
            GV_shop.DataBind()
            GV_shop.HeaderRow.TableSection = TableRowSection.TableHeader
            panel_shop.Update()

        Else
            Dim tabla = "<br/><center><h4>No hay Resultados para esta Búsqueda</h4></center><br/>"
        End If
    End Sub
    <System.Web.Services.WebMethod(EnableSession:=True)> Public Shared Function registrar_pedido(ByVal articulos As String) As String
        Dim sql As New cls_db
        Dim array_articulos As Array
        array_articulos = articulos.Split(",")
        Dim direccion_numero As Integer
        Dim monto As Integer = array_articulos(array_articulos.Length - 1)
        'Dim nombre_cliente As String = array_articulos(array_articulos.Length - 5)
        'Dim celular As Integer = array_articulos(array_articulos.Length - 4)
        'Dim direccion_calle As String = array_articulos(array_articulos.Length - 3)

        If Not array_articulos(array_articulos.Length - 2) = "" Then
            direccion_numero = CInt(array_articulos(array_articulos.Length - 2))
        End If
        sql.parametros.Clear()

        sql.parametros.Add("nombre_cliente", "nombre_cliente")
        sql.parametros.Add("celular", 0)
        sql.parametros.Add("direccion_calle", "direccion_calle")
        sql.parametros.Add("direccion_numero", 0)
        sql.parametros.Add("monto", monto)

        Dim redaccion_mensaje As String = "Hola 👋🏻​ quiero hacerte el siguiente pedido... %0A"

        Dim dt As DataTable = sql.ejecutar_sp("SP_pedidos_INSERT")
        Dim pedido_id As Integer = dt(0)(0)
        Dim articulo_id As Integer

        Try
            Dim cantidad As String = ""
            Dim nombre_articulo As String = ""
            Dim monto_articulo As String = ""
            For i As Integer = 0 To array_articulos.Length - 6 'resta stock
                If i Mod 2 = 0 Then 'en el string de dato el primer dato es el articulo y segundo la cantidad y el ultimo el monto
                    sql.parametros.Clear()
                    articulo_id = array_articulos(i)
                    sql.parametros.Add("articulo_id", articulo_id)
                    dt = sql.ejecutar_sp("SP_stock_Consul_ID")
                    'Dim img_art As String = dt(0).ItemArray(7)
                    monto_articulo = dt(0).ItemArray(8)
                    nombre_articulo = dt(0).ItemArray(1)

                    sql.parametros.Clear()
                    sql.parametros.Add("pedido_id", pedido_id)
                    sql.parametros.Add("articulo_id", articulo_id)
                    'AQUI REDACTO MENSAJE DE WHATSAPP

                Else
                    cantidad = array_articulos(i)
                    sql.parametros.Add("cantidad", CInt(cantidad))
                    sql.ejecutar_sp("SP_PEDIDOLISTA_INSERT")
                    'sql.parametros.Add("cantidad", cantidad) 'cantidad
                    redaccion_mensaje = redaccion_mensaje + "%0A ➖ " + cantidad + " Unidades de ➖ " + nombre_articulo + " de $" + monto_articulo + ".00 c/u"
                End If
            Next
            Dim total As String = array_articulos(array_articulos.Length - 1)
            redaccion_mensaje = redaccion_mensaje + "%0A%0A TOTAL = 💲​" + total + ".00"
        Catch ex As Exception
            Return False
        End Try
        Return pedido_id.ToString + "|" + redaccion_mensaje + "%0A %0A 🧾​​​​ N°PEDIDO - " + pedido_id.ToString '+ celular.ToString + " es el número de " + nombre_cliente.ToString

    End Function
End Class
