Imports System.Data
Imports System.IO

Partial Class shopStore
    Inherits System.Web.UI.Page

    Public sp As String = "SP_stock_shopStore_GRILLA"
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

    Public Shared Function GetImageUrl(imagePath As String) As String
        Try
            Dim serverPath As String = HttpContext.Current.Server.MapPath(imagePath)
            If File.Exists(serverPath) Then
                Return imagePath
            Else
                Return "static\img\imagen_vacia.png"
            End If
        Catch ex As Exception
            Return "static\img\imagen_vacia.png"
        End Try
    End Function

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
    <System.Web.Services.WebMethod(EnableSession:=True)> Public Shared Function articulo_visitado(ByVal art_id As Integer) As String
        Dim sql As New cls_db
        sql.parametros.Add("id", art_id)
        sql.ejecutar_sp("SP_stock_UPDATE_producto_visitado")
        Return True
    End Function


    Public Function llenar_grilla()

        Dim sql As New cls_db
        Dim dt As New DataTable

        dt = sql.ejecutar_sp(sp)
        table = dt
        Dim grilla As New cls_grid(dt, formulario)
        If grilla.dt.Rows.Count > 0 Then
            GV_shopStore.DataSource = dt
            GV_shopStore.DataBind()
            GV_shopStore.HeaderRow.TableSection = TableRowSection.TableHeader
            panel_shop.Update()

        Else
            Dim tabla = "<br/><center><h4>No hay Resultados para esta Búsqueda</h4></center><br/>"
        End If
    End Function
    <System.Web.Services.WebMethod(EnableSession:=True)>
    Public Shared Function registrar_pedido(ByVal articulos As String) As String
        Dim sql As New cls_db
        Dim array_articulos As Array
        array_articulos = articulos.Split(",")
        Dim direccion_numero As Integer
        Dim monto As Integer = array_articulos(array_articulos.Length - 1)
        Dim nombre_cliente As String = array_articulos(array_articulos.Length - 5)
        Dim celular As Integer = array_articulos(array_articulos.Length - 4)
        Dim direccion_calle As String = array_articulos(array_articulos.Length - 3)

        If Not array_articulos(array_articulos.Length - 2) = "" Then
            direccion_numero = CInt(array_articulos(array_articulos.Length - 2))
        End If
        sql.parametros.Clear()

        sql.parametros.Add("nombre_cliente", nombre_cliente)
        sql.parametros.Add("celular", celular)
        sql.parametros.Add("direccion_calle", direccion_calle)
        sql.parametros.Add("direccion_numero", direccion_numero)
        sql.parametros.Add("monto", monto)

        ' Nueva estructura del mensaje de WhatsApp con emojis
        Dim redaccion_mensaje As String = "📦 *¡Pedido Recibido! 🎉* %0A%0A" &
                                          "👤 *Cliente:* " & nombre_cliente & " %0A" &
                                          "📞 *Teléfono:* " & celular & " %0A"

        ' Verificar si la dirección es TAKEAWAY
        If direccion_calle = "0" Or direccion_numero = 0 Then
            redaccion_mensaje &= "🚶‍♂️ *Dirección:* TAKE-AWAY %0A%0A"
        Else
            redaccion_mensaje &= "🏠 *Dirección:* " & direccion_calle & " " & direccion_numero & " %0A%0A"
        End If

        redaccion_mensaje &= "🛒 *Resumen de tu pedido:* %0A"

        Dim dt As DataTable = sql.ejecutar_sp("SP_pedidos_INSERT")
        Dim pedido_id As Integer = dt(0)(0)
        Dim articulo_id As Integer

        Try
            Dim cantidad As String = ""
            Dim nombre_articulo As String = ""
            Dim monto_articulo As String = ""

            ' Procesar cada artículo y cantidad del pedido
            For i As Integer = 0 To array_articulos.Length - 6
                If i Mod 2 = 0 Then
                    sql.parametros.Clear()
                    articulo_id = array_articulos(i)
                    sql.parametros.Add("articulo_id", articulo_id)
                    dt = sql.ejecutar_sp("SP_stock_Consul_ID")
                    monto_articulo = dt(0).ItemArray(8)
                    nombre_articulo = dt(0).ItemArray(1)

                    sql.parametros.Clear()
                    sql.parametros.Add("pedido_id", pedido_id)
                    sql.parametros.Add("articulo_id", articulo_id)

                Else
                    cantidad = array_articulos(i)
                    sql.parametros.Add("cantidad", CInt(cantidad))
                    sql.ejecutar_sp("SP_PEDIDOLISTA_INSERT")

                    ' Agregar información del artículo al mensaje
                    redaccion_mensaje &= "➖ *" & cantidad & " x " & nombre_articulo & "* ➡️ *$" & monto_articulo & ".00* c/u %0A"
                End If
            Next

            ' Agregar total y número de pedido al mensaje
            Dim total As String = array_articulos(array_articulos.Length - 1)
            redaccion_mensaje &= "%0A💵 *Total a pagar:* 💲" & total & ".00 %0A"
            redaccion_mensaje &= "%0A🧾 *N° de Pedido:* " & pedido_id.ToString & " %0A"
            redaccion_mensaje &= "%0A✨ *Gracias por tu compra* ✨ Ya recibimos tu pedido!"
            redaccion_mensaje &= "%0A Enviá éste mensaje si querés estar en contacto hasta recibirlo."
            redaccion_mensaje &= "%0A Si tienes alguna duda, estamos a tu disposición. 😊"

        Catch ex As Exception
            Return False
        End Try

        ' Retornar el ID del pedido y el mensaje formateado para WhatsApp
        Return pedido_id.ToString & "|" & redaccion_mensaje & "%0A %0A"
    End Function


End Class
