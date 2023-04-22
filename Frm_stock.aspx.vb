Imports System.Data

Partial Class Frm_stock
    Inherits System.Web.UI.Page
    Public nombre_objeto As String = "Stock"
    Public pagina_grilla As String = "Grilla_stock.aspx"

    Public post_msg_error As String = ""

    ReadOnly Property pk As String
        Get
            If IsNothing(Request.Params("id")) Then
                Return ""
            End If
            Return Request.Params("id")
        End Get
    End Property

    ReadOnly Property es_alta As Boolean
        Get
            Return (pk = "")
        End Get
    End Property

    ReadOnly Property titulo As String
        Get

            If (es_alta) Then
                Return "Nueva " & nombre_objeto
            Else
                Return "Modificación de " & nombre_objeto
            End If

        End Get
    End Property


    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        'Dim cod As String = cls_utils.obtener_parametros("ruta a certificado")
        If Not IsPostBack Then
            inicializar_controles()
            If Not es_alta Then fill_data()
        End If

    End Sub


    Private Sub btn_save_Click(sender As Object, e As EventArgs) Handles btn_save.Click
        guardar()
    End Sub

    Sub inicializar_controles()
        cls_utils.cargar_combo(cbo_categoria, "SP_stock_CBO_categorias", "descripcion", "descripcion")
        cbo_categoria.Items.Add(New ListItem("Sin Seleccionar", -1))
        cbo_categoria.SelectedValue = -1
    End Sub

    Sub fill_data()

        Dim row As DataRow = cls_db.get_id("SP_stock_Consul_ID", "codigo", pk)

        If Not IsNothing(row) Then
            txt_nombre.Text = row("nombre")
            txt_descripcion.Text = row("descripcion")
            txt_cantidad.Text = row("cantidad")
            txt_codigo_barra.Text = row("codigo_barra")
            txt_tamaño.Text = row("tamaño")
            cbo_categoria.SelectedValue = row("categoria")
            txt_color.Text = row("color")
            txt_ruta_imagen1.Text = row("ruta_imagen")
            If Not row("ruta_imagen_2") Is DBNull.Value Then
                txt_ruta_imagen2.Text = row("ruta_imagen_2")
            End If
            If Not row("ruta_imagen_3") Is DBNull.Value Then
                txt_ruta_imagen3.Text = row("ruta_imagen_3")
            End If
            txt_precio.Text = row("precio")
        End If

    End Sub


    Function insertar() As Boolean
        Dim sql As New cls_db

        sql.parametros.Add("nombre", txt_nombre.Text)
        sql.parametros.Add("descripcion", txt_descripcion.Text)
        sql.parametros.Add("cantidad", txt_cantidad.Text)
        sql.parametros.Add("tamaño", txt_tamaño.Text)
        sql.parametros.Add("categoria", cbo_categoria.SelectedValue)
        sql.parametros.Add("color", txt_color.Text)
        sql.parametros.Add("ruta_imagen", txt_ruta_imagen1.Text)
        sql.parametros.Add("ruta_imagen_2", txt_ruta_imagen2.Text)
        sql.parametros.Add("ruta_imagen_3", txt_ruta_imagen3.Text)
        sql.parametros.Add("codigo_barra", txt_codigo_barra.Text)
        sql.parametros.Add("precio", txt_precio.Text)


        Dim dt As DataTable = sql.ejecutar_sp("SP_stock_INSERT")
        Return True
    End Function

    Function actualizar() As Boolean
        Dim sql As New cls_db
        sql.parametros.Add("id", pk)
        sql.parametros.Add("nombre", txt_nombre.Text)
        sql.parametros.Add("descripcion", txt_descripcion.Text)
        sql.parametros.Add("cantidad", txt_cantidad.Text)
        sql.parametros.Add("tamaño", txt_tamaño.Text)
        sql.parametros.Add("categoria", cbo_categoria.SelectedValue)
        sql.parametros.Add("color", txt_color.Text)
        sql.parametros.Add("ruta_imagen", txt_ruta_imagen1.Text)
        sql.parametros.Add("ruta_imagen_2", txt_ruta_imagen2.Text)
        sql.parametros.Add("ruta_imagen_3", txt_ruta_imagen3.Text)
        sql.parametros.Add("codigo_barra", txt_codigo_barra.Text)
        sql.parametros.Add("precio", txt_precio.Text)



        sql.ejecutar_sp("SP_stock_UPDATE")
        Return True

    End Function



    <System.Web.Services.WebMethod(EnableSession:=True)> Public Shared Function eliminar(ByVal id As String) As String
        Dim sql As New cls_db
        sql.parametros.Add("id", id)
        sql.ejecutar_sp("SP_stock_DELETE")

        Return "true"


    End Function




    Sub guardar()

        Dim resultado_transaccion As Boolean

        If es_alta Then
            resultado_transaccion = insertar()
        Else
            resultado_transaccion = actualizar()
        End If

        If resultado_transaccion = True Then
            Response.Redirect(pagina_grilla)
        End If

    End Sub


End Class

