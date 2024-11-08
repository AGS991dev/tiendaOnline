﻿Imports OfficeOpenXml
Imports System.IO
Imports System.Data
Imports OfficeOpenXml.Style
Imports System.Drawing
Imports System.Data.SqlClient
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
    Protected Sub btnExportarExcel_stock_Click(sender As Object, e As EventArgs) Handles btnExportarExcel_stock.Click
        Try
            Dim fecha As String = DateTime.Now.ToString("yyyy-MM-dd") ' Formato de fecha: Año-Mes-Día

            Dim sql As New cls_db
            Dim dt As DataTable = sql.ejecutar_sp("SP_stock_GRILLA_EXCEL", sql.parametros)

            Using package As New ExcelPackage()
                ExcelPackage.LicenseContext = LicenseContext.NonCommercial

                ' Crear la hoja de trabajo
                Dim ws As ExcelWorksheet = package.Workbook.Worksheets.Add("Datos")

                ' Título del reporte
                ws.Cells("A1").Value = "Stock"
                ws.Cells("A1:L1").Merge = True
                ws.Cells("A1").Style.Font.Size = 16
                ws.Cells("A1").Style.Font.Bold = True
                ws.Cells("A1").Style.HorizontalAlignment = ExcelHorizontalAlignment.Center

                ' Cargar los datos desde el DataTable
                ws.Cells("A2").LoadFromDataTable(dt, True)

                ' Estilo para la fila de encabezado
                Using range As ExcelRange = ws.Cells("A2:L2")
                    range.Style.Font.Bold = True
                    range.Style.Fill.PatternType = ExcelFillStyle.Solid
                    range.Style.Fill.BackgroundColor.SetColor(Color.LightGray)
                    range.Style.HorizontalAlignment = ExcelHorizontalAlignment.Center
                End Using

                ' Encabezados de las columnas
                For col As Integer = 1 To dt.Columns.Count
                    ws.Cells(2, col).Value = dt.Columns(col - 1).ColumnName.ToUpper()
                Next

                ' Ajustar automáticamente el ancho de las columnas
                ws.Cells(ws.Dimension.Address).AutoFitColumns()

                ' Limpiar la respuesta y enviar el archivo al cliente
                Response.Clear()
                Response.Buffer = True
                Response.AddHeader("content-disposition", "attachment; filename=Stock_" & fecha & ".xlsx")
                Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"

                ' Escribir los datos del archivo Excel a la respuesta
                Dim fileBytes As Byte() = package.GetAsByteArray()
                If fileBytes IsNot Nothing AndAlso fileBytes.Length > 0 Then
                    Response.BinaryWrite(fileBytes)
                End If

                ' Configuración de caché y finalización de la respuesta
                Response.Cache.SetCacheability(HttpCacheability.NoCache)
                Response.Flush()
                Response.End()
            End Using
        Catch ex As Exception
            Response.Write("Ocurrió un error: " & ex.Message)
        End Try
    End Sub

    Protected Sub btnImportarExcel_stock_Click(sender As Object, e As EventArgs) Handles btnImportarExcel_Stock.Click
        If fileUploadExcel.HasFile Then
            Dim dt As DataTable = LeerArchivoExcel(fileUploadExcel.PostedFile.InputStream)

            If dt IsNot Nothing AndAlso dt.Rows.Count > 0 Then
                Dim sql As New cls_db

                ' Iterar sobre cada fila del DataTable
                For Each row As DataRow In dt.Rows
                    sql.parametros.Clear()
                    ' Formatear el precio eliminando el símbolo de pesos y convirtiéndolo a decimal
                    Dim precioSinSimbolo As String = row("Precio").ToString().Replace("$", "").Trim()
                    Dim precioDecimal As Decimal = Convert.ToDecimal(precioSinSimbolo)
                    ' Agregar parámetros para cada columna del DataTable
                    sql.parametros.Add("@Nombre", row("Nombre").ToString())
                    sql.parametros.Add("@Descripcion", row("Descripción").ToString())
                    sql.parametros.Add("@Cantidad", Convert.ToInt32(If(String.IsNullOrEmpty(row("Cantidad").ToString()), 0, row("Cantidad"))))
                    sql.parametros.Add("@Tamaño", row("Tamaño").ToString())
                    sql.parametros.Add("@Categoria", row("Categoría").ToString())
                    sql.parametros.Add("@Color", row("Color").ToString())
                    sql.parametros.Add("@RutaImagen", row("URL1").ToString())
                    sql.parametros.Add("@Precio", precioDecimal)
                    sql.parametros.Add("@CodigoBarra", Convert.ToInt32(If(String.IsNullOrEmpty(row("Código de barra").ToString()), 0, row("Código de barra"))))
                    sql.parametros.Add("@PrecioCostoConvert", 0)
                    sql.parametros.Add("@RutaImagen2", row("URL2").ToString())
                    sql.parametros.Add("@RutaImagen3", row("URL3").ToString())
                    sql.parametros.Add("@ProductoVisitado", 0)

                    ' Ejecutar el procedimiento almacenado para cada fila
                    sql.ejecutar_sp("SP_stock_CARGA_MASIVA_EXCEL", sql.parametros)
                Next
            End If
            Response.Redirect(Request.RawUrl, True)

        End If
    End Sub

    Private Function LeerArchivoExcel(fileStream As Stream) As DataTable
        Dim dt As New DataTable()

        Using package As New ExcelPackage(fileStream)
            Dim worksheet As ExcelWorksheet = package.Workbook.Worksheets(0)

            ' Leer las columnas
            For col As Integer = 1 To worksheet.Dimension.End.Column
                dt.Columns.Add(worksheet.Cells(2, col).Text) ' Supone que la fila 2 tiene los nombres de columnas
            Next

            ' Leer las filas
            For row As Integer = 3 To worksheet.Dimension.End.Row
                Dim dataRow As DataRow = dt.NewRow()
                For col As Integer = 1 To worksheet.Dimension.End.Column
                    dataRow(col - 1) = worksheet.Cells(row, col).Text
                Next
                dt.Rows.Add(dataRow)
            Next
        End Using

        Return dt
    End Function




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
End Class

