Imports System.Data

Partial Class Grilla_caja
    Inherits System.Web.UI.Page

    Public tabla As String
    Public tabla_vacia As Boolean = False
    Public sp As String = "SP_caja_GRILLA"
    Public formulario As String = "Frm_caja.aspx"
    Public Titulo As String = "Caja"
    'Public categorias As New List(Of String)


    Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            inicializar_variables()
            inicializar_controles()
            'llenar_grilla()
        End If
    End Sub

    Sub inicializar_variables()
        If sp = "" AndAlso Request.QueryString("sp") <> "" Then sp = Request.QueryString("sp")
        If formulario = "" AndAlso Request.QueryString("formulario") <> "" Then formulario = Request.QueryString("formulario")
        If Titulo = "" AndAlso Request.QueryString("Titulo") <> "" Then Titulo = Request.QueryString("Titulo")
    End Sub

    Sub inicializar_controles()

        cbo_buscador_articulos.Items.Add(New ListItem("Sin Seleccionar", -1))
        cargar_cbo_art()
    End Sub

    Sub cargar_cbo_art()
        Dim sql As New cls_db
        Dim dt_art As DataTable
        dt_art = sql.ejecutar_sp("SP_stock_CBO_buscador_articulos")
        For Each dr As DataRow In dt_art.Rows
            cbo_buscador_articulos.Items.Add(New ListItem(dr("nombre"), dr("codigo_barra")))
        Next
    End Sub

    <System.Web.Services.WebMethod(EnableSession:=True)> Public Shared Function eliminar(ByVal id As Integer) As String
        'Dim sql As New cls_db
        'sql.parametros.Add("id", id)
        'sql.ejecutar_sp("SP_caja_DELETE")
        'Return "true"
    End Function

    <System.Web.Services.WebMethod(EnableSession:=True)> Public Shared Function escaneo_codigo_barra(ByVal codigo As Integer) As String
        Dim sql As New cls_db
        sql.parametros.Add("codigo_barra", codigo)
        Dim dt As DataTable = sql.ejecutar_sp("SP_stock_consul_codigo_barra")
        Dim string_articulo As String
        If dt.Rows.Count > 0 Then
            Dim articulo As String = dt.Rows(0).ItemArray(1)
            Dim descripcion As String = dt.Rows(0).ItemArray(2)
            Dim cantidad As String = dt.Rows(0).ItemArray(3)
            Dim tamaño As String = dt.Rows(0).ItemArray(4)
            Dim categoria As String = dt.Rows(0).ItemArray(5)
            Dim color As String = dt.Rows(0).ItemArray(6)
            Dim ruta_imagen As String = dt.Rows(0).ItemArray(7)
            Dim precio As String = dt.Rows(0).ItemArray(8)
            Dim codigo_barra As String = dt.Rows(0).ItemArray(9)
            string_articulo = articulo & "|" & descripcion & "|" & cantidad & "|" & tamaño & "|" & categoria & "|" & color & "|" & ruta_imagen & "|" & precio & "|" & codigo_barra

            Return string_articulo
        Else
            Return "Articulo no Encontrado"
        End If



        Return "true"
    End Function

    <System.Web.Services.WebMethod(EnableSession:=True)> Public Shared Function registrar_compra(ByVal articulos As String) As String
        Dim sql As New cls_db
        Dim array_articulos As Array
        array_articulos = articulos.Split(",")
        Dim monto As Integer = array_articulos(array_articulos.Length - 1)

        sql.parametros.Add("usuario_id", cls_security.usuario_actual.id)
        sql.parametros.Add("concepto_id", 1) ' 1 es ventas
        sql.parametros.Add("monto", monto)
        Dim dt As DataTable = sql.ejecutar_sp("SP_registro_INSERT")
        Dim identity As Integer = dt(0)(0)
        Dim codigo As Integer
        Dim cantidad As Integer
        Dim cantidad_total As Integer
        Try
            For i As Integer = 0 To array_articulos.Length - 2 'resta stock

                If i Mod 2 = 0 Then 'si es par o impar
                    sql.parametros.Clear()
                    codigo = array_articulos(i)
                    sql.parametros.Add("codigo_barra", codigo) 'cod_barra
                Else
                    cantidad = array_articulos(i)
                    sql.parametros.Add("cantidad", cantidad) 'cantidad
                    sql.ejecutar_sp("SP_stock_RESTAR") 'tambien agrega al ranking de ventas el producto
                    cantidad_total += cantidad
                End If
            Next

            For i As Integer = 0 To array_articulos.Length - 2  'carga datos de ticket
                If i Mod 2 = 0 Then  'si es par o impar
                    sql.parametros.Clear()
                    codigo = array_articulos(i)
                    sql.parametros.Add("codigo_barra", codigo) 'cod_barra
                Else
                    cantidad = array_articulos(i)
                    sql.parametros.Add("cantidad", cantidad) 'cantidad
                    sql.parametros.Add("venta_id", identity)
                    sql.parametros.Add("cantidad_total", cantidad_total)
                    sql.ejecutar_sp("SP_ticket_INSERT")
                End If
            Next
        Catch ex As Exception
            Return False
        End Try
        Return identity.ToString

    End Function


End Class

