
Imports System.Data

Partial Class Frm_Categorias
    Inherits System.Web.UI.Page

    Public nombre_objeto As String = "categoría"
    Public pagina_grilla As String = "Grilla_Categorias.aspx"

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

        If pk <> "" Then
            recurso_valido(cls_security.usuario_actual.empresa_id, pk) 'tabla usuarios
        End If

        If Not IsPostBack Then
            'inicializar_controles()
            If Not es_alta Then fill_data()
        End If

    End Sub


    Private Sub btn_save_Click(sender As Object, e As EventArgs) Handles btn_save.Click
        If txt_descripcion.Text <> "" Then
            guardar()
        Else
            'no deja avanzar, mensaje pidiendo que complete datos ?
        End If
    End Sub

    'Sub inicializar_controles()
    'cls_utils.cargar_combo(cbo_perfil, "SP_Perfiles_CONSUL", "codigo", "descripcion")
    'End Sub+

    Function recurso_valido(empresa_id As Integer, id_recuros As Integer) As Boolean

        Dim sql As New cls_db
        sql.parametros.Add("empresa_id", empresa_id)
        sql.parametros.Add("id_recurso", id_recuros)


        Dim dt As DataTable = sql.ejecutar_sp("SP_validar_recurso_categoria")
        If IsNothing(dt(0)) Then
            Session("toast_denegado") = "Acesso Restringido"
            Response.Redirect(pagina_grilla)
            Return False
        End If
        If Not IsNothing(dt(0)) Then
            Return True
        End If
        'y que haga un query dinámico en la base tipo
        'select  * from tabla where campo = valor and id = id_recurso
        'entonces si existe el registro es válido, sino existe es inválido

    End Function
    Sub fill_data()

        Dim row As DataRow = cls_db.get_id("SP_Categorias_Consul_ID", "id", pk)

        If Not IsNothing(row) Then
            txt_descripcion.Text = row("descripcion")
        End If

    End Sub


    Function insertar() As Boolean
        Dim sql As New cls_db

        sql.parametros.Add("descripcion", txt_descripcion.Text)

        'sql.parametros.Add("vendedor_codex", cls_utils.value_null(cbo_vendedor))

        Dim dt As DataTable = sql.ejecutar_sp("SP_Categorias_INSERT")
        Return True
    End Function

    Function actualizar() As Boolean
        Dim sql As New cls_db
        sql.parametros.Add("id", pk)

        sql.ejecutar_sp("SP_Categorias_UPDATE")
        Return True

    End Function



    <System.Web.Services.WebMethod(EnableSession:=True)> Public Shared Function eliminar(ByVal id As String) As String
        Dim sql As New cls_db
        sql.parametros.Add("id", id)

        sql.ejecutar_sp("SP_Categorias_DELETE")

        Return "true"


    End Function


    <System.Web.Services.WebMethod()> Public Shared Function existe_codigo(ByVal codigo As String, objid As String) As String
        Dim sql As New cls_db
        Dim mydt As DataTable
        Dim parametros As New Dictionary(Of String, Object)

        parametros.Add("codigo", codigo)
        mydt = sql.ejecutar_sp("SP_Categorias_Consul", parametros)

        If mydt.Rows.Count = 0 Then
            Return "0"
        Else
            Return "1"
        End If
        'sin utilizar


    End Function




    Sub guardar()

        Dim resultado_transaccion As Boolean

        If es_alta Then
            resultado_transaccion = insertar()
            cls_utils.redirect_msg(Response, "Grilla_Categorias.aspx", " Categoría Agregada Con Éxito")

        Else
            resultado_transaccion = actualizar()
            cls_utils.redirect_msg(Response, "Grilla_Categorias.aspx", " Categoría Actualizada Con Éxito")

        End If

        If resultado_transaccion = True Then
            Response.Redirect(pagina_grilla)
        End If

    End Sub


End Class




