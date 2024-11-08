﻿Imports OfficeOpenXml
Imports System.IO
Imports System.Data
Imports OfficeOpenXml.Style
Imports System.Drawing


Partial Class Grilla_consulta
    Inherits System.Web.UI.Page

    Public tabla As String
    Public tabla_vacia As Boolean = False
    Public sp As String = "SP_caja_consulta"
    Public formulario As String = "Frm_caja.aspx"
    Public Titulo As String = "Caja"
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
        If sp = "" AndAlso Request.QueryString("sp") <> "" Then sp = Request.QueryString("sp")
        If formulario = "" AndAlso Request.QueryString("formulario") <> "" Then formulario = Request.QueryString("formulario")
        If Titulo = "" AndAlso Request.QueryString("Titulo") <> "" Then Titulo = Request.QueryString("Titulo")
    End Sub

    Sub inicializar_controles()

        cbo_ticket.Items.Add(New ListItem("Todos", -1))
        cargar_cbo_tkt()
        ' Obtener el primer día del mes actual
        Dim primerDiaDelMes As DateTime = New DateTime(DateTime.Now.Year, DateTime.Now.Month, 1)
        ' Establecer el texto en el campo txt_desde
        txt_desde.Text = primerDiaDelMes.ToString("yyyy-MM-dd")
        ' Establecer el texto en el campo txt_hasta con la fecha actual
        txt_hasta.Text = DateTime.Now.AddDays(1).ToString("yyyy-MM-dd")
        panel_btn_filtrar.Update()
    End Sub


    Sub cargar_cbo_tkt()
        Dim sql As New cls_db
        Dim dt_tkt As DataTable
        dt_tkt = sql.ejecutar_sp("SP_tickets_CBO")
        For Each dr As DataRow In dt_tkt.Rows
            cbo_ticket.Items.Add(New ListItem(dr("venta_id"), dr("venta_id")))
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
                    cantidad_total += cantidad
                    sql.parametros.Add("cantidad", cantidad) 'cantidad
                    sql.ejecutar_sp("SP_stock_RESTAR")
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



    Private Sub btn_filtrar_Click(sender As Object, e As EventArgs) Handles btn_filtrar.Click
        filldata()
    End Sub
    Sub filldata()
        Try
            Dim sql As New cls_db
            Dim desde As String = txt_desde.Text
            Dim hasta As String = txt_hasta.Text
            Dim _desde As Date
            Dim _hasta As Date

            sql.parametros.Add("venta_id", cbo_ticket.SelectedValue)

            ' Manejo de parámetro 'desde'
            If String.IsNullOrEmpty(desde) Then
                sql.parametros.Add("desde", DBNull.Value)
            Else
                If Date.TryParse(desde, _desde) Then
                    sql.parametros.Add("desde", _desde)
                Else
                    Throw New ArgumentException("Fecha 'desde' no válida.")
                End If
            End If

            ' Manejo de parámetro 'hasta'
            If String.IsNullOrEmpty(hasta) Then
                sql.parametros.Add("hasta", DBNull.Value)
            Else
                If Date.TryParse(hasta, _hasta) Then
                    sql.parametros.Add("hasta", _hasta)
                Else
                    Throw New ArgumentException("Fecha 'hasta' no válida.")
                End If
            End If

            ' Ejecutar procedimiento almacenado
            Dim dt As DataTable = sql.ejecutar_sp("SP_REGISTRO_FILTRAR", sql.parametros)

            ' Actualizar grilla con resultados
            Dim grilla As New cls_grid(dt, formulario)
            If grilla.dt.Rows.Count > 0 Then
                tabla_vacia = False
                GV_consultas.Visible = True
                GV_consultas.DataSource = dt
                GV_consultas.DataBind()
                GV_consultas.HeaderRow.TableSection = TableRowSection.TableHeader

                ' Actualizar UI
                panel_btn_filtrar.Update()
                lbl_total.InnerText = dt.Rows(0)(4).ToString() ' Asegúrate de que el índice de columna es correcto
                Update_lbl_total.Update()
                panel_consultas.Update()
            Else
                GV_consultas.Visible = False
                tabla_vacia = True
                tabla = "<br/><center><h4>No hay Resultados para esta Búsqueda</h4></center><br/>"
                lbl_total.InnerText = "$ 0.00"
            End If
        Catch ex As Exception
            ' Manejo de errores
            Dim err As String = "Ocurrió un error: " & ex.Message
        End Try
    End Sub

    Protected Sub btnExportarExcel_consul_Click(sender As Object, e As EventArgs) Handles btnExportarExcel_consul.Click
        Try
            Dim sql As New cls_db
            Dim desde As String = txt_desde.Text
            Dim hasta As String = txt_hasta.Text

            sql.parametros.Add("venta_id", cbo_ticket.SelectedValue)
            If desde = "" Then
                sql.parametros.Add("desde", DBNull.Value)
            Else
                Dim _desde As Date = cls_utils.string_to_date(desde)
                sql.parametros.Add("desde", _desde)
            End If
            If hasta = "" Then
                sql.parametros.Add("hasta", DBNull.Value)
            Else
                Dim _hasta As Date = cls_utils.string_to_date(hasta)
                sql.parametros.Add("hasta", _hasta)
            End If

            Dim dt As DataTable = sql.ejecutar_sp("SP_REGISTRO_FILTRAR_EXCEL", sql.parametros)

            Using package As New ExcelPackage()
                ExcelPackage.LicenseContext = LicenseContext.NonCommercial

                Dim ws As ExcelWorksheet = package.Workbook.Worksheets.Add("Datos")

                ws.Cells("A1").Value = "Consulta"
                ws.Cells("A1:E1").Merge = True
                ws.Cells("A1").Style.Font.Size = 16
                ws.Cells("A1").Style.Font.Bold = True
                ws.Cells("A1").Style.HorizontalAlignment = ExcelHorizontalAlignment.Center

                ws.Cells("A2").Value = "Desde:"
                ws.Cells("B2").Value = desde
                ws.Cells("A3").Value = "Hasta:"
                ws.Cells("B3").Value = hasta
                ws.Cells("A2:B2").Style.Font.Bold = True
                ws.Cells("A3:B3").Style.Font.Bold = True

                ws.Cells("A5").LoadFromDataTable(dt, True)

                Using range As ExcelRange = ws.Cells("A5:E5")
                    range.Style.Font.Bold = True
                    range.Style.Fill.PatternType = ExcelFillStyle.Solid
                    range.Style.Fill.BackgroundColor.SetColor(Color.LightGray)
                    range.Style.HorizontalAlignment = ExcelHorizontalAlignment.Center
                End Using

                For col As Integer = 1 To dt.Columns.Count
                    ws.Cells(5, col).Value = dt.Columns(col - 1).ColumnName.ToUpper()
                Next

                ws.Cells(ws.Dimension.Address).AutoFitColumns()

                Response.Clear()
                Response.Buffer = True
                Response.AddHeader("content-disposition", "attachment; filename=" & "Consulta desde " & desde.ToString & " hasta " & hasta.ToString & ".xlsx")
                Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
                Response.BinaryWrite(package.GetAsByteArray())
                Response.Flush()
                Response.End()
            End Using
        Catch ex As Exception
            Response.Write("Ocurrió un error: " & ex.Message)
        End Try
    End Sub



End Class

