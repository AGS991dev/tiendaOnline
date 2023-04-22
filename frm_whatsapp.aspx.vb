
Imports System.Data

Partial Class Frm_whatsapp
    Inherits System.Web.UI.Page

    Public nombre_objeto As String = "Whatsapp"
    Public pagina_grilla As String = "Grilla_whatsapp.aspx"

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


    Sub fill_data()

        Dim row As DataRow = cls_db.get_id("SP_whatsapp_Consul_ID", "id", pk)

        If Not IsNothing(row) Then
            txt_descripcion.Text = row("celular")
        End If

    End Sub


    Function insertar() As Boolean
        Dim sql As New cls_db

        sql.parametros.Add("celular", txt_descripcion.Text)

        'sql.parametros.Add("vendedor_codex", cls_utils.value_null(cbo_vendedor))

        Dim dt As DataTable = sql.ejecutar_sp("SP_whatsapp_INSERT")
        Return True
    End Function

    Function actualizar() As Boolean
        Dim sql As New cls_db
        sql.parametros.Add("id", pk)
        sql.parametros.Add("descripcion", txt_descripcion.Text)

        sql.ejecutar_sp("SP_whatsapp_UPDATE")
        Return True

    End Function



    <System.Web.Services.WebMethod(EnableSession:=True)> Public Shared Function eliminar(ByVal id As String) As String
        Dim sql As New cls_db
        sql.parametros.Add("id", id)


        sql.ejecutar_sp("SP_whatsapp_DELETE")

        Return "true"


    End Function


    <System.Web.Services.WebMethod()> Public Shared Function existe_codigo(ByVal codigo As String, objid As String) As String
        Dim sql As New cls_db
        Dim mydt As DataTable
        Dim parametros As New Dictionary(Of String, Object)

        parametros.Add("codigo", codigo)
        mydt = sql.ejecutar_sp("SP_whatsapp_Consul", parametros)

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
            cls_utils.redirect_msg(Response, "Grilla_whatsapp.aspx", " Celular Agregado con Éxito")

        Else
            resultado_transaccion = actualizar()
            cls_utils.redirect_msg(Response, "Grilla_whatsapp.aspx", " Celular Actualizado con Éxito")

        End If

        If resultado_transaccion = True Then
            Response.Redirect(pagina_grilla)
        End If

    End Sub


End Class




