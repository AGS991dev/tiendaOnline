Imports OfficeOpenXml
Imports System.IO
Imports System.Data
Imports OfficeOpenXml.Style
Imports System.Drawing

Partial Class c_movimientos
    Inherits System.Web.UI.Page

    Public tabla As String
    Public tabla_vacia As Boolean = False
    Public sp As String = "SP_REGISTRO_MOV_GRILLA_FILTRAR"
    Public formulario As String = "Frm_movimientos.aspx" 'no tiene
    Public Titulo As String = "Movimientos"
    Public total_text As String = ""


    Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        ' Configurar el contexto de la licencia de EPPlus
        ExcelPackage.LicenseContext = LicenseContext.NonCommercial

        If Not IsPostBack Then
            inicializar_variables()
            inicializar_controles()
            llenar_grilla()
        End If
    End Sub

    Sub inicializar_variables()
        'If sp = "" AndAlso Request.QueryString("sp") <> "" Then sp = Request.QueryString("sp")
        If formulario = "" AndAlso Request.QueryString("formulario") <> "" Then formulario = Request.QueryString("formulario")
        If Titulo = "" AndAlso Request.QueryString("Titulo") <> "" Then Titulo = Request.QueryString("Titulo")
    End Sub

    Overridable Sub inicializar_controles()
        cargar_cbo_concepto()
        ' Obtener el primer día del mes actual
        Dim primerDiaDelMes As DateTime = New DateTime(DateTime.Now.Year, DateTime.Now.Month, 1)
        ' Establecer el texto en el campo txt_desde
        txt_desde.Text = primerDiaDelMes.ToString("yyyy-MM-dd")
        ' Establecer el texto en el campo txt_hasta con la fecha actual
        txt_hasta.Text = DateTime.Now.AddDays(1).ToString("yyyy-MM-dd")
    End Sub
    Sub cargar_cbo_concepto()
        Dim sql As New cls_db
        Dim dt_tkt As DataTable
        dt_tkt = sql.ejecutar_sp("SP_concepto_cbo")
        For Each dr As DataRow In dt_tkt.Rows
            cbo_concepto.Items.Add(New ListItem(dr("concepto"), dr("id")))
        Next
    End Sub
    Overridable Sub llenar_grilla()
        Dim sql As New cls_db
        Dim desde As String = txt_desde.Text
        Dim hasta As String = txt_hasta.Text
        If desde = "" Then
            sql.parametros.Add("desde", DBNull.Value)
        Else
            Dim _desde As DateTime = DateTime.ParseExact(desde, "yyyy-MM-dd", System.Globalization.CultureInfo.InvariantCulture)
            sql.parametros.Add("desde", _desde)
        End If
        If hasta = "" Then
            sql.parametros.Add("hasta", DBNull.Value)
        Else
            Dim _hasta As DateTime = DateTime.ParseExact(hasta, "yyyy-MM-dd", System.Globalization.CultureInfo.InvariantCulture)
            sql.parametros.Add("hasta", _hasta)
        End If
        Dim dt As DataTable = sql.ejecutar_sp(sp, sql.parametros)

        Dim grilla As New cls_grid(dt, formulario)
        If grilla.dt.Rows.Count > 0 Then
            tabla_vacia = False
            GV_registros.Visible = True
            GV_registros.DataSource = dt
            GV_registros.DataBind()
            GV_registros.HeaderRow.TableSection = TableRowSection.TableHeader
            lbl_total.InnerText = dt(0)("total").ToString().Replace("$", "").Trim()
            Update_txt_desde.Update()
            Update_txt_hasta.Update()
            panel_consultas.Update()
            Update_lbl_total.Update()

        Else
            GV_registros.Visible = False
            tabla_vacia = True
            tabla = "<br/><center><h4>No hay Resultados para esta Búsqueda</h4></center><br/>"
            lbl_total.InnerText = "$ 0.00"
        End If


    End Sub

    Private Sub btn_add_Click(sender As Object, e As EventArgs) Handles btn_add.Click
        Dim sql As New cls_db
        sql.parametros.Add("usuario_id", cls_security.usuario_actual.id)
        sql.parametros.Add("concepto_id", cbo_concepto.SelectedValue)
        sql.parametros.Add("monto", txt_monto.Text)
        sql.parametros.Add("descripcion", txt_descripcion.Text)
        sql.ejecutar_sp("SP_registro_manual_INSERT")

        llenar_grilla()
    End Sub

    Private Sub btn_refresh_Click(sender As Object, e As EventArgs) Handles btn_refresh.Click
        llenar_grilla()
    End Sub
    ' Nueva función para exportar a Excel
    Protected Sub btnExportarExcel_mov_Click(sender As Object, e As EventArgs) Handles btnExportarExcel_mov.Click
        Try
            Dim sql As New cls_db
            Dim desde As String = txt_desde.Text
            Dim hasta As String = txt_hasta.Text

            ' Manejo de fechas y parámetros
            If desde = "" Then
                sql.parametros.Add("desde", DBNull.Value)
            Else
                Dim _desde As DateTime = DateTime.ParseExact(desde, "yyyy-MM-dd", System.Globalization.CultureInfo.InvariantCulture)
                sql.parametros.Add("desde", _desde)
            End If
            If hasta = "" Then
                sql.parametros.Add("hasta", DBNull.Value)
            Else
                Dim _hasta As DateTime = DateTime.ParseExact(hasta, "yyyy-MM-dd", System.Globalization.CultureInfo.InvariantCulture)
                sql.parametros.Add("hasta", _hasta)
            End If

            ' Ejecutar el procedimiento almacenado y obtener los datos
            Dim dt As DataTable = sql.ejecutar_sp("SP_REGISTRO_MOV_GRILLA_FILTRAR_EXCEL", sql.parametros)

            Using package As New ExcelPackage()
                ' Configurar el contexto de la licencia de EPPlus
                ExcelPackage.LicenseContext = LicenseContext.NonCommercial

                Dim ws As ExcelWorksheet = package.Workbook.Worksheets.Add("Datos")

                ' Añadir título personalizado
                ws.Cells("A1").Value = "Movimientos"
                ws.Cells("A1:E1").Merge = True
                ws.Cells("A1").Style.Font.Size = 16
                ws.Cells("A1").Style.Font.Bold = True
                ws.Cells("A1").Style.HorizontalAlignment = ExcelHorizontalAlignment.Center

                ' Añadir rango de fechas
                ws.Cells("A2").Value = "Desde:"
                ws.Cells("B2").Value = desde
                ws.Cells("A3").Value = "Hasta:"
                ws.Cells("B3").Value = hasta
                ws.Cells("A2:B2").Style.Font.Bold = True
                ws.Cells("A3:B3").Style.Font.Bold = True

                ' Cargar los datos en la hoja de cálculo, comenzando en la fila 5
                ws.Cells("A5").LoadFromDataTable(dt, True)

                ' Formato de la primera fila de encabezados
                Using range As ExcelRange = ws.Cells("A5:F5")
                    range.Style.Font.Bold = True
                    range.Style.Fill.PatternType = ExcelFillStyle.Solid
                    range.Style.Fill.BackgroundColor.SetColor(Color.LightGray)
                    range.Style.HorizontalAlignment = ExcelHorizontalAlignment.Center
                End Using

                ' Convertir los encabezados a mayúsculas
                For col As Integer = 1 To dt.Columns.Count
                    ws.Cells(5, col).Value = dt.Columns(col - 1).ColumnName.ToUpper()
                Next

                ' Ajustar el tamaño de las columnas
                ws.Cells(ws.Dimension.Address).AutoFitColumns()

                ' Preparar la respuesta HTTP
                Response.Clear()
                Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
                Response.AddHeader("content-disposition", "attachment; filename=" & "Movimientos desde " & desde.ToString() & " hasta " & hasta.ToString() & ".xlsx")
                Response.BinaryWrite(package.GetAsByteArray())
                Response.End()
            End Using
        Catch ex As Exception
            ' Manejar el error
            Response.Write("Ocurrió un error: " & ex.Message)
        End Try
    End Sub

End Class

