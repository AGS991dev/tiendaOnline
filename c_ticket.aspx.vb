﻿Imports System.Data
Imports System.IO

Partial Class c_ticket
    Inherits System.Web.UI.Page

    Public tabla As String
    Public sp As String = "SP_ticket_GRILLA"
    Public formulario As String = "Frm_ticket.aspx"
    Public Titulo As String = "Ticket"
    Public total_text As String = ""
    Public precio_total As Integer
    Public cantidad As Integer

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

    Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            Try
                inicializar_variables()
                inicializar_controles()
                llenar_grilla()
            Catch ex As Exception
                cls_utils.redirect_msg_error(Response, "La session no pudo cargar", "info")
            End Try
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
        'Dim sql As New cls_db
        'sql.parametros.Add("id", id)
        'sql.ejecutar_sp("SP_Empresas_DELETE")
        'Return "true"
    End Function
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

    Sub llenar_grilla()

        Dim sql As New cls_db
        sql.parametros.Add("id", pk)
        Dim dt As DataTable = sql.ejecutar_sp("SP_ticket_GRILLA")
        Dim grilla As New cls_grid(dt, formulario)
        Dim row As DataRow = dt(0)
        precio_total = row("Precio Total")
        cantidad = row("Cantidad Total")

        If grilla.dt.Rows.Count > 0 Then
            GV_ticket.DataSource = dt
            GV_ticket.DataBind()
            panel_ticket.Update()

        Else
            tabla = "<br/><center><h4>No hay Resultados para esta Búsqueda</h4></center><br/>"
        End If
    End Sub


End Class

