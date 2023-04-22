Imports System.Data

Public Class Grilla_Usuarios
    Inherits System.Web.UI.Page


    Public tabla As String
    Public sp As String = "SP_Usuarios_GRILLA"
    Public formulario As String = "Frm_Usuarios.aspx"
    Public Titulo As String = "Usuarios"
    Public total_text As String = ""


    Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            inicializar_variables()
            inicializar_controles()
            llenar_grilla_primera_vez(0)
        End If
    End Sub

    Sub inicializar_variables()
        If sp = "" AndAlso Request.QueryString("sp") <> "" Then sp = Request.QueryString("sp")
        If formulario = "" AndAlso Request.QueryString("formulario") <> "" Then formulario = Request.QueryString("formulario")
        If Titulo = "" AndAlso Request.QueryString("Titulo") <> "" Then Titulo = Request.QueryString("Titulo")
    End Sub

    Overridable Sub inicializar_controles()

    End Sub

    Overridable Sub llenar_grilla()

        Dim sql As New cls_db
        Dim dt As New DataTable
        dt = sql.ejecutar_sp(sp)

        Dim grid As New cls_grid(dt, formulario)
        If formulario = "" Then
            grid.show_delete = False
            grid.show_edit = False
            grid.show_view = False
        End If
        tabla = grid.html()

        total_text = "Total " & dt.Rows.Count & " registros"
    End Sub

    Sub llenar_grilla_primera_vez(estado As String)

        Dim sql As New cls_db
        Dim dt As New DataTable

        sql.parametros.Add("estado", estado)

        dt = sql.ejecutar_sp("[SP_Usuarios_GRILLA_estado]")

        For i = 0 To dt.Rows.Count - 1 Step 1
            Dim pass As String = (dt.Rows(i)).ItemArray(3).ToString
            pass = cls_crypto.Decrypt(pass).ToString
            dt.Rows(i).SetField(3, pass)
        Next

        Dim grilla As New cls_grid(dt, formulario)
        If grilla.dt.Rows.Count > 0 Then
            GV_usuarios.DataSource = dt
            GV_usuarios.DataBind()
            GV_usuarios.Visible = True
            GV_usuarios.HeaderRow.TableSection = TableRowSection.TableHeader
            panel_usuarios.Update()

        Else
            tabla = "<br/><center class='tabla_vacia'><h6>La lista de Usuarios está Vacia, Puedes dar de Alta Usuarios utilizando los botones en pantalla.</h6></center><br/>"
            GV_usuarios.Visible = False
            panel_usuarios.Update()
        End If
        'ScriptManager.RegisterStartupScript(Me, Me.Page.GetType, "refresh_filter", "refresh_filter()", True)
    End Sub
    Private Sub GV_usuarios_RowDataBound(sender As Object, e As GridViewRowEventArgs) Handles GV_usuarios.RowDataBound
        If (e.Row.RowType = DataControlRowType.Header) Then
            e.Row.TableSection = TableRowSection.TableHeader
        End If
        Dim i As Integer
        For i = 0 To (GV_usuarios.Columns().Count) - 2 Step 1
            If GV_usuarios.Columns(i).HeaderText = "Password" Then
                If Not e.Row.Cells(i).Text = "Password" Then
                    e.Row.Cells(i).Attributes("class") = "hidetext"
                    e.Row.Cells(i).Attributes("style") = "text-align: center"
                End If
            End If
            If Not e.Row.Cells(i).Text = "Password" Then
                e.Row.Cells(i).Attributes("data-th") = GV_usuarios.Columns(i).HeaderText
            End If
        Next
    End Sub
    <System.Web.Services.WebMethod(EnableSession:=True)> Public Shared Function eliminar(ByVal id As Integer, ByVal cuil As String) As String

        Dim empresa_id As Integer = cls_security.usuario_actual.empresa_id
        Dim certificado_id As Integer = cls_utils.certificado_del_empleado(cuil, empresa_id)
        Dim empresas_trabajadas As DataTable = cls_utils.empresas_del_empleado(cuil) 'Ver para cuantas empresas trabaja este empleado
        Dim docs_firmados_de_mi_empresa As DataTable = cls_utils.documentos_firmados(cuil) 'Ver documentos firmados de la empresa del supervisor. -> CUil y Empresa ID

        If empresas_trabajadas.Rows.Count > 1 Then ' ----------- TRABAJA PARA VARIAS EMPRESAS
            If docs_firmados_de_mi_empresa.Rows.Count = 0 Then ' NO FIRMO NADA en mi empresa
                cls_utils.baja_fisica(id)
                cls_utils.borrar_certificados_fisicos_de_mi_empresa(empresa_id, cuil, certificado_id)
            Else 'SI FIRMO DOCUMENTOS en mi empresa
                cls_utils.baja_logica(id)
            End If
        Else ' ------------------------------------------------- TRABAJA PARA 1 SOLA EMPRESA
            If docs_firmados_de_mi_empresa.Rows.Count = 0 Then ' NO FIRMO NADA  en mi empresa
                cls_utils.eliminar_login(cuil, id)
                cls_utils.baja_fisica(id)
                cls_utils.borrar_certificados_fisicos_de_mi_empresa(empresa_id, cuil, certificado_id)
            Else 'SI FIRMO DOCUMENTOS en mi empresa
                cls_utils.baja_logica(id) 'else hacer baja logica
            End If
        End If

        Return "true"

    End Function

End Class
