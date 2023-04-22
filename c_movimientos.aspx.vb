

Imports System.Data

Partial Class c_movimientos
    Inherits System.Web.UI.Page

    Public tabla As String
    Public tabla_vacia As Boolean = False
    Public sp As String = "SP_REGISTRO_MOV_GRILLA_FILTRAR"
    Public formulario As String = "Frm_movimientos.aspx" 'no tiene
    Public Titulo As String = "Movimientos"
    Public total_text As String = ""


    Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

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
            Dim _desde As Date = cls_utils.string_to_date(desde)
            sql.parametros.Add("desde", _desde)
        End If
        If hasta = "" Then
            sql.parametros.Add("hasta", DBNull.Value)
        Else
            Dim _hasta As Date = cls_utils.string_to_date(hasta)
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
            lbl_total.InnerText = dt(0)(6)
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
End Class

