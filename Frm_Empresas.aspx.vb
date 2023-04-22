
Imports System.Data
Imports System.Data.OleDb
Imports System.IO

Partial Class Frm_Empresas

    Inherits System.Web.UI.Page
    Public nombre_objeto As String = "empresa"
    Public pagina_grilla As String = "Grilla_Empresas.aspx"
    Public msg_err As String
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
            inicializar_controles()
            If Not es_alta Then fill_data()
        End If

    End Sub


    Private Sub btn_save_Click(sender As Object, e As EventArgs) Handles btn_save.Click
        guardar()
    End Sub

    Sub inicializar_controles()
    End Sub

    Sub fill_data()

        Dim row As DataRow = cls_db.get_id("SP_Empresas_Consul_ID", "id", pk)

        If Not IsNothing(row) Then
            txt_cuit.Text = row("cuit")
            txt_razon_social.Text = row("razon_social")
            If Not row("logo") Is DBNull.Value Then
                hi_logo.Value = row("logo")
            End If
        End If

    End Sub


    Function insertar() As Boolean
        Dim sql As New cls_db
        Dim path_logo As String

        Dim cuit As String = Replace(txt_cuit.Text, "-", "")
        sql.parametros.Add("cuil", cuit)
        sql.parametros.Add("razon_social", txt_razon_social.Text)
        sql.parametros.Add("logo", DBNull.Value)

        Dim dt As DataTable = sql.ejecutar_sp("SP_Empresas_INSERT")
        Dim empresa_id As Long = dt(0)(0)
        sql.parametros.Clear()

        If Not guardar_logo(empresa_id) Is Nothing Then
            path_logo = guardar_logo(empresa_id)
        Else
            path_logo = hi_logo.Value
        End If

        sql.parametros.Add("id", empresa_id)
        sql.parametros.Add("cuil", cuit)
        sql.parametros.Add("razon_social", txt_razon_social.Text)
        sql.parametros.Add("logo", path_logo)

        sql.ejecutar_sp("SP_Empresas_UPDATE")

        Return True
    End Function

    Function actualizar() As Boolean
        Dim sql As New cls_db
        Dim path_logo As String
        If Not guardar_logo(pk) Is Nothing Then
            path_logo = guardar_logo(pk)
        Else
            path_logo = hi_logo.Value
        End If

        Dim cuit As String = Replace(txt_cuit.Text, "-", "")
        sql.parametros.Add("id", pk)
        sql.parametros.Add("cuil", cuit)
        sql.parametros.Add("razon_social", txt_razon_social.Text)
        sql.parametros.Add("logo", path_logo)


        'sql.ejecutar_sp("SP_Empresas_UPDATE")

        Return True

    End Function
    Function guardar_logo(empresa_id As String) As String
        If (FileUpload_logo.HasFile) Then

            Try

                'Guardamos el archivo en el servidor
                'Dim stamp = CLng(DateTime.UtcNow.Subtract(New DateTime(1970, 1, 1)).TotalMilliseconds)
                Dim ext As String = Path.GetExtension(FileUpload_logo.FileName)
                Dim filename As String = Path.GetFileName(FileUpload_logo.FileName).Replace(FileUpload_logo.FileName, "empresa_" & empresa_id & ext) 'coloco stamo e id de la empresa a nombre del archivo
                Dim archivo_destino As String = Server.MapPath("~/_logos/") + filename
                Dim ruta_relativa_logos As String = "/_logos/" + filename
                If File.Exists(archivo_destino) Then
                    File.Delete(archivo_destino)
                End If

                If copiar_archivo(archivo_destino) Then
                    Return ruta_relativa_logos
                End If

            Catch ex As Exception
                msg_err = "Se produjo un error al importar el archivo: " & ex.Message
            End Try

        End If
    End Function



    Public Function copiar_archivo(aux_archivo_destino As String) As Boolean
        Try

            FileUpload_logo.SaveAs(aux_archivo_destino)
            FileUpload_logo.Dispose()

            Return True

        Catch ex As Exception
            msg_err = "Se produjo un error al copiar el archivo: " & ex.Message
            Return False
        End Try

    End Function



    <System.Web.Services.WebMethod(EnableSession:=True)> Public Shared Function eliminar(ByVal id As String) As String
        Dim sql As New cls_db
        sql.parametros.Add("id", id)
        sql.ejecutar_sp("SP_Empresas_DELETE")

        Return "true"


    End Function


    '<System.Web.Services.WebMethod()> Public Shared Function existe_codigo(ByVal codigo As String, objid As String) As String
    '    Dim sql As New cls_db
    '    Dim mydt As DataTable
    '    Dim parametros As New Dictionary(Of String, Object)

    '    parametros.Add("codigo", codigo)
    '    mydt = sql.ejecutar_sp("SP_Usuarios_Consul", parametros)

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




