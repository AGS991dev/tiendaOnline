Imports System.Data
Imports System.DataClient
Imports System.Web.Services
Imports Newtonsoft.Json
Partial Class Contacto
    Inherits System.Web.UI.Page

    Public tabla As String
    Public tabla_vacia As Boolean = False
    Public sp As String = "SP_CONTACTO"
    Public formulario As String = "Contacto.aspx"
    Public Titulo As String = "Contacto"
    Public Ubicaciones As New List(Of DataRow)

    Public Shared Property JsonConvert As Object
    'Public categorias As New List(Of String)


    Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            'inicializar_variables()
            inicializar_controles()
            'llenar_grilla() 
            'filldata()
        End If
    End Sub
    Sub inicializar_controles()
        Dim sql As New cls_db
        Dim dt As DataTable = sql.ejecutar_sp("SP_ContactoInfo_SELECT")
        For Each row As DataRow In dt.Rows
            Ubicaciones.Add(row)
        Next
    End Sub
    ' Método Web para insertar un registro
    <WebMethod(EnableSession:=True)>
    Public Shared Function InsertarContacto(ByVal Nombre_tienda As String, ByVal Direccion As String, ByVal Telefono As String, ByVal SocialMediaLink As String, ByVal Coordenadas As String, ByVal Popup_title As String) As String
        Try
            Dim sql As New cls_db
            sql.parametros.Add("@Nombre_tienda", Nombre_tienda)
            sql.parametros.Add("@Direccion", Direccion)
            sql.parametros.Add("@Telefono", Telefono)
            sql.parametros.Add("@SocialMediaLink", If(String.IsNullOrEmpty(SocialMediaLink), DBNull.Value, SocialMediaLink))
            sql.parametros.Add("@Coordenadas", If(String.IsNullOrEmpty(Coordenadas), DBNull.Value, Coordenadas))
            sql.parametros.Add("@Popup_title", If(String.IsNullOrEmpty(Popup_title), DBNull.Value, Popup_title))

            sql.ejecutar_sp("SP_ContactoInfo_INSERT", sql.parametros)

            Return "Registro insertado correctamente."
        Catch ex As Exception
            Return "Error: " & ex.Message
        End Try
    End Function
    <WebMethod(EnableSession:=True)>
    Public Shared Function ObtenerContactos() As String
        Try
            Dim sql As New cls_db
            Dim dt As DataTable = sql.ejecutar_sp("SP_ContactoInfo_SELECT", sql.parametros)

            ' Convertir DataTable a JSON
            Dim json As String = JsonConvert.SerializeObject(dt)

            Return json
        Catch ex As Exception
            Return "Error: " & ex.Message
        End Try
    End Function

    ' Método Web para actualizar un registro
    <WebMethod(EnableSession:=True)>
    Public Shared Function ActualizarContacto(ByVal ID As Integer, ByVal Nombre_tienda As String, ByVal Direccion As String, ByVal Telefono As String, ByVal SocialMediaLink As String, ByVal Coordenadas As String, ByVal Popup_title As String) As String
        Try
            Dim sql As New cls_db
            sql.parametros.Add("@ID", ID)
            sql.parametros.Add("@Nombre_tienda", Nombre_tienda)
            sql.parametros.Add("@Direccion", Direccion)
            sql.parametros.Add("@Telefono", Telefono)
            sql.parametros.Add("@SocialMediaLink", If(String.IsNullOrEmpty(SocialMediaLink), DBNull.Value, SocialMediaLink))
            sql.parametros.Add("@Coordenadas", If(String.IsNullOrEmpty(Coordenadas), DBNull.Value, Coordenadas))
            sql.parametros.Add("@Popup_title", If(String.IsNullOrEmpty(Popup_title), DBNull.Value, Popup_title))

            sql.ejecutar_sp("SP_ContactoInfo_UPDATE", sql.parametros)

            Return "Registro actualizado correctamente."
        Catch ex As Exception
            Return "Error: " & ex.Message
        End Try
    End Function

    ' Método Web para eliminar un registro
    <WebMethod(EnableSession:=True)>
    Public Shared Function EliminarContacto(ByVal ID As Integer) As String
        Try
            Dim sql As New cls_db
            sql.parametros.Add("@ID", ID)

            sql.ejecutar_sp("SP_ContactoInfo_DELETE", sql.parametros)

            Return "Registro eliminado correctamente."
        Catch ex As Exception
            Return "Error: " & ex.Message
        End Try
    End Function

    ' Método Web para obtener un registro por ID
    <WebMethod(EnableSession:=True)>
    Public Shared Function ObtenerContactoPorId(ByVal ID As Integer) As String
        Try
            Dim sql As New cls_db
            sql.parametros.Add("@ID", ID)

            Dim dt As DataTable = sql.ejecutar_sp("SP_ContactoInfo_SELECT_ById", sql.parametros)

            ' Verificar si se encontró un registro
            If dt.Rows.Count > 0 Then
                ' Convertir el primer registro a JSON
                Dim json As String = JsonConvert.SerializeObject(dt.Rows(0))
                Return json
            Else
                Return "No se encontró el registro."
            End If
        Catch ex As Exception
            Return "Error: " & ex.Message
        End Try
    End Function
End Class

