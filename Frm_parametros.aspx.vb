Imports System.Data

Partial Class Frm_parametros
    Inherits System.Web.UI.Page
    Public nombre_objeto As String = "Parámetro"
    Public pagina_grilla As String = "Grilla_parametros.aspx"

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
            'inicializar_controles()
            If Not es_alta Then fill_data()
        End If

    End Sub


    Private Sub btn_save_Click(sender As Object, e As EventArgs) Handles btn_save.Click
        guardar()
    End Sub

    'Sub inicializar_controles()
    'cls_utils.cargar_combo(cbo_perfil, "SP_Perfiles_CONSUL", "codigo", "descripcion")
    'End Sub

    Sub fill_data()

        Dim row As DataRow = cls_db.get_id("SP_parametros_Consul_ID", "codigo", pk)

        If Not IsNothing(row) Then
            txt_codigo.Text = row("codigo")
            txt_descripcion.Text = row("descripcion")
            txt_valor.Text = row("valor")

        End If

    End Sub


    Function insertar() As Boolean
        Dim sql As New cls_db

        sql.parametros.Add("codigo", txt_codigo.Text)
        sql.parametros.Add("descripcion", txt_descripcion.Text)
        sql.parametros.Add("valor", txt_valor.Text)
        'sql.parametros.Add("vendedor_codex", cls_utils.value_null(cbo_vendedor))

        Dim dt As DataTable = sql.ejecutar_sp("SP_parametros_INSERT")
        Return True
    End Function

    Function actualizar() As Boolean
        Dim sql As New cls_db
        sql.parametros.Add("codigo_anterior", pk)
        sql.parametros.Add("codigo_nuevo", txt_codigo.Text)
        sql.parametros.Add("descripcion", txt_descripcion.Text)
        sql.parametros.Add("valor", txt_valor.Text)


        sql.ejecutar_sp("SP_parametros_UPDATE")
        Return True

    End Function



    <System.Web.Services.WebMethod(EnableSession:=True)> Public Shared Function eliminar(ByVal id As String) As String
        Dim sql As New cls_db
        sql.parametros.Add("codigo", id)
        sql.ejecutar_sp("SP_parametros_DELETE")

        Return "true"


    End Function


    '<System.Web.Services.WebMethod()> Public Shared Function existe_codigo(ByVal codigo As String, objid As String) As String
    '    Dim sql As New cls_db
    '    Dim mydt As DataTable
    '    Dim parametros As New Dictionary(Of String, Object)

    '    parametros.Add("codigo", codigo)
    '    mydt = sql.ejecutar_sp("SP_parametros_Consul", parametros)

    '    If mydt.Rows.Count = 0 Then
    '        Return "0"
    '    Else
    '        Return "1"
    '    End If



    'End Function




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




