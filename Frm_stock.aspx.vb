Imports System.Data
Imports System.IO
Imports System.Drawing
Imports System.Drawing.Imaging

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

    Sub btnGuardarImagenes()
        If imgInput1.PostedFile IsNot Nothing AndAlso imgInput1.PostedFile.ContentLength > 0 Then
            Try
                Dim nombreCarpetaSave As String = "App1"
                ' Obtener la ruta de la carpeta donde se guardará la imagen
                Dim rutaCarpeta As String = Server.MapPath("~/static/Articulos/" & nombreCarpetaSave)

                ' Verificar si la carpeta existe, si no, crearla
                If Not Directory.Exists(rutaCarpeta) Then
                    Directory.CreateDirectory(rutaCarpeta)
                End If

                ' Obtener el nombre de la imagen
                Dim nombreImagen1 As String = Path.GetFileName(imgInput1.PostedFile.FileName)
                Dim rutaImagen1 As String = Path.Combine(rutaCarpeta, nombreImagen1)

                ' Convertir la imagen a PNG y ajustar su tamaño
                Using imagenOriginal As Image = Image.FromStream(imgInput1.PostedFile.InputStream)
                    ' Calcular el nuevo tamaño manteniendo la relación de aspecto
                    Dim newWidth As Integer = 400
                    Dim newHeight As Integer = CInt((imagenOriginal.Height / imagenOriginal.Width) * newWidth)

                    ' Crear una nueva imagen con el nuevo tamaño
                    Using imagenRedimensionada As New Bitmap(newWidth, newHeight)
                        ' Dibujar la imagen original en la nueva imagen con el nuevo tamaño
                        Using g As Graphics = Graphics.FromImage(imagenRedimensionada)
                            g.InterpolationMode = Drawing2D.InterpolationMode.HighQualityBicubic
                            g.DrawImage(imagenOriginal, 0, 0, newWidth, newHeight)
                        End Using

                        ' Guardar la imagen redimensionada como PNG
                        imagenRedimensionada.Save(rutaImagen1, ImageFormat.Png)

                        ' Mostrar la ruta de la imagen guardada en el TextBox
                        txt_ruta_imagen1.Text = rutaImagen1
                    End Using
                End Using

            Catch ex As Exception
                ' Manejar cualquier excepción que pueda ocurrir durante la carga de la imagen
                ' Puedes mostrar un mensaje de error o registrar la excepción en un registro
            End Try
        Else
            ' Si no se seleccionó ningún archivo, asignar una cadena vacía al TextBox
            txt_ruta_imagen1.Text = ""
        End If

        If imgInput2.PostedFile IsNot Nothing AndAlso imgInput2.PostedFile.ContentLength > 0 Then
            Try
                Dim nombreCarpetaSave As String = "App1"
                ' Obtener la ruta de la carpeta donde se guardará la imagen
                Dim rutaCarpeta As String = Server.MapPath("~/static/Articulos/" & nombreCarpetaSave)

                ' Verificar si la carpeta existe, si no, crearla
                If Not Directory.Exists(rutaCarpeta) Then
                    Directory.CreateDirectory(rutaCarpeta)
                End If

                ' Obtener el nombre de la imagen
                Dim nombreImagen1 As String = Path.GetFileName(imgInput2.PostedFile.FileName)
                Dim rutaImagen1 As String = Path.Combine(rutaCarpeta, nombreImagen1)

                ' Convertir la imagen a PNG y ajustar su tamaño
                Using imagenOriginal As Image = Image.FromStream(imgInput2.PostedFile.InputStream)
                    ' Calcular el nuevo tamaño manteniendo la relación de aspecto
                    Dim newWidth As Integer = 400
                    Dim newHeight As Integer = CInt((imagenOriginal.Height / imagenOriginal.Width) * newWidth)

                    ' Crear una nueva imagen con el nuevo tamaño
                    Using imagenRedimensionada As New Bitmap(newWidth, newHeight)
                        ' Dibujar la imagen original en la nueva imagen con el nuevo tamaño
                        Using g As Graphics = Graphics.FromImage(imagenRedimensionada)
                            g.InterpolationMode = Drawing2D.InterpolationMode.HighQualityBicubic
                            g.DrawImage(imagenOriginal, 0, 0, newWidth, newHeight)
                        End Using

                        ' Guardar la imagen redimensionada como PNG
                        imagenRedimensionada.Save(rutaImagen1, ImageFormat.Png)

                        ' Mostrar la ruta de la imagen guardada en el TextBox
                        txt_ruta_imagen1.Text = rutaImagen1
                    End Using
                End Using

            Catch ex As Exception
                ' Manejar cualquier excepción que pueda ocurrir durante la carga de la imagen
                ' Puedes mostrar un mensaje de error o registrar la excepción en un registro
            End Try
        Else
            ' Si no se seleccionó ningún archivo, asignar una cadena vacía al TextBox
            txt_ruta_imagen2.Text = ""
        End If
        If imgInput3.PostedFile IsNot Nothing AndAlso imgInput3.PostedFile.ContentLength > 0 Then
            Try
                Dim nombreCarpetaSave As String = "App1"
                ' Obtener la ruta de la carpeta donde se guardará la imagen
                Dim rutaCarpeta As String = Server.MapPath("~/static/Articulos/" & nombreCarpetaSave)

                ' Verificar si la carpeta existe, si no, crearla
                If Not Directory.Exists(rutaCarpeta) Then
                    Directory.CreateDirectory(rutaCarpeta)
                End If

                ' Obtener el nombre de la imagen
                Dim nombreImagen1 As String = Path.GetFileName(imgInput3.PostedFile.FileName)
                Dim rutaImagen1 As String = Path.Combine(rutaCarpeta, nombreImagen1)

                ' Convertir la imagen a PNG y ajustar su tamaño
                Using imagenOriginal As Image = Image.FromStream(imgInput3.PostedFile.InputStream)
                    ' Calcular el nuevo tamaño manteniendo la relación de aspecto
                    Dim newWidth As Integer = 400
                    Dim newHeight As Integer = CInt((imagenOriginal.Height / imagenOriginal.Width) * newWidth)

                    ' Crear una nueva imagen con el nuevo tamaño
                    Using imagenRedimensionada As New Bitmap(newWidth, newHeight)
                        ' Dibujar la imagen original en la nueva imagen con el nuevo tamaño
                        Using g As Graphics = Graphics.FromImage(imagenRedimensionada)
                            g.InterpolationMode = Drawing2D.InterpolationMode.HighQualityBicubic
                            g.DrawImage(imagenOriginal, 0, 0, newWidth, newHeight)
                        End Using

                        ' Guardar la imagen redimensionada como PNG
                        imagenRedimensionada.Save(rutaImagen1, ImageFormat.Png)

                        ' Mostrar la ruta de la imagen guardada en el TextBox
                        txt_ruta_imagen1.Text = rutaImagen1
                    End Using
                End Using

            Catch ex As Exception
                ' Manejar cualquier excepción que pueda ocurrir durante la carga de la imagen
                ' Puedes mostrar un mensaje de error o registrar la excepción en un registro
            End Try
        Else
            ' Si no se seleccionó ningún archivo, asignar una cadena vacía al TextBox
            txt_ruta_imagen3.Text = ""
        End If
    End Sub



    Private Sub btn_save_Click(sender As Object, e As EventArgs) Handles btn_save.Click
        btnGuardarImagenes()
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
            txt_precio.Text = row("precio")
            txt_precio_costo.Text = row("precio_costo")

            If Not row("ruta_imagen") Is DBNull.Value Then txt_ruta_imagen1.Text = row("ruta_imagen")
            If Not row("ruta_imagen_2") Is DBNull.Value Then txt_ruta_imagen2.Text = row("ruta_imagen_2")
            If Not row("ruta_imagen_3") Is DBNull.Value Then txt_ruta_imagen3.Text = row("ruta_imagen_3")
            If Not String.IsNullOrEmpty(row("ruta_imagen")) Then img1.Src = row("ruta_imagen")
            If Not String.IsNullOrEmpty(row("ruta_imagen_2")) Then img2.Src = row("ruta_imagen_2")
            If Not String.IsNullOrEmpty(row("ruta_imagen_3")) Then img3.Src = row("ruta_imagen_3")
        End If
    End Sub


    Function insertar() As Boolean
        Dim sql As New cls_db
        Dim app As String = "App1"

        Dim path1 As String = IIf(imgInput1.Value.ToString = "", img1.Src, imgInput1.Value.ToString)
        Dim path2 As String = IIf(imgInput2.Value.ToString = "", img2.Src, imgInput2.Value.ToString)
        Dim path3 As String = IIf(imgInput3.Value.ToString = "", img3.Src, imgInput3.Value.ToString)

        sql.parametros.Add("nombre", txt_nombre.Text)
        sql.parametros.Add("descripcion", txt_descripcion.Text)
        sql.parametros.Add("cantidad", txt_cantidad.Text)
        sql.parametros.Add("tamaño", txt_tamaño.Text)
        sql.parametros.Add("categoria", cbo_categoria.SelectedValue)
        sql.parametros.Add("color", txt_color.Text)
        sql.parametros.Add("ruta_imagen", IIf(imgInput1.Value.ToString = "", img1.Src, "static\Articulos\" & app & "\" & path1))
        sql.parametros.Add("ruta_imagen_2", IIf(imgInput2.Value.ToString = "", img2.Src, "static\Articulos\" & app & "\" & path2))
        sql.parametros.Add("ruta_imagen_3", IIf(imgInput3.Value.ToString = "", img3.Src, "static\Articulos\" & app & "\" & path3))
        sql.parametros.Add("codigo_barra", txt_codigo_barra.Text)
        sql.parametros.Add("precio", txt_precio.Text)
        sql.parametros.Add("precio_costo", txt_precio_costo.Text)


        Dim dt As DataTable = sql.ejecutar_sp("SP_stock_INSERT")
        Return True
    End Function

    Function actualizar() As Boolean
        Dim sql As New cls_db
        Dim app As String = "App1"

        Dim path1 As String = IIf(imgInput1.Value.ToString = "", img1.Src, imgInput1.Value.ToString)
        Dim path2 As String = IIf(imgInput2.Value.ToString = "", img2.Src, imgInput2.Value.ToString)
        Dim path3 As String = IIf(imgInput3.Value.ToString = "", img3.Src, imgInput3.Value.ToString)

        sql.parametros.Add("id", pk)
        sql.parametros.Add("nombre", txt_nombre.Text)
        sql.parametros.Add("descripcion", txt_descripcion.Text)
        sql.parametros.Add("cantidad", txt_cantidad.Text)
        sql.parametros.Add("tamaño", txt_tamaño.Text)
        sql.parametros.Add("categoria", cbo_categoria.SelectedValue)
        sql.parametros.Add("color", txt_color.Text)
        sql.parametros.Add("ruta_imagen", IIf(imgInput1.Value.ToString = "", img1.Src, "static\Articulos\" & app & "\" & path1))
        sql.parametros.Add("ruta_imagen_2", IIf(imgInput2.Value.ToString = "", img2.Src, "static\Articulos\" & app & "\" & path2))
        sql.parametros.Add("ruta_imagen_3", IIf(imgInput3.Value.ToString = "", img3.Src, "static\Articulos\" & app & "\" & path3))
        sql.parametros.Add("codigo_barra", txt_codigo_barra.Text)
        sql.parametros.Add("precio", txt_precio.Text)
        sql.parametros.Add("precio_costo", txt_precio_costo.Text)


        sql.ejecutar_sp("SP_stock_UPDATE")

        btnGuardarImagenes()

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

