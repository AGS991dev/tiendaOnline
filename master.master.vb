Imports System.Data

Partial Class master
    Inherits System.Web.UI.MasterPage
    Public title_name As String = ConfigurationManager.AppSettings("title").ToString() '"FirmaNativa" 'San Antonio 'para cambiar titulo
    Public system_name As String = ConfigurationManager.AppSettings("system_name").ToString() '"firma_nativa" ' esta variable cambia la estetica de la pagina , firma_nativa, san_antonio
    Public archivo_main_css As String = ConfigurationManager.AppSettings("main_style").ToString()
    Public page_name As String
    Public page_name_full As String
    Public empresas_de_empleados_flag As Boolean = False
    Public empresas_de_empleados As New List(Of String)
    Public empresa_btn_id As New List(Of String)
    Public index_empresa_empleado As Integer
    Public badgeCount As New List(Of String)
    Public perfil As Integer
    Public numero_whatsapp As String


    ReadOnly Property pk As String
        Get
            If IsNothing(Request.Params("pk")) Then
                Return ""
            End If
            Return Request.Params("pk")
        End Get
    End Property

    ReadOnly Property es_alta As Boolean
        Get
            Return (pk = "")
        End Get
    End Property

    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load

        inicializar_variables()

        If Request.Url.ToString.Contains("shop.aspx") Then
            btn_menu_mobile.Visible = True
        Else
            btn_menu_desktop.visible = True
        End If

        Session("system_name") = system_name ' esta variable cambia la estetica de la pagina
        page_name = Me.contenido_body.Page.GetType().Name.ToLower.Replace("_aspx", ".aspx")

        'SI ESTOY EN PAGINA Asistente
        If page_name = "asistente.aspx" Then
            Exit Sub
        End If
        If page_name = "access_recovery.aspx" Then
            Exit Sub
        End If
        'SI YA ESTOY EN PAGINA LOGIN OMITO
        If page_name = "login.aspx" Then

            Return
        End If
        If page_name = "shop.aspx" Then

            Return
        End If


        'SI EL USUARIO NO ESTA LOGUEADO, SE REDIRECCIONA
        If IsNothing(Session("usuario_actual")) Then
            Response.Redirect("login.aspx")
            Exit Sub
        End If
        'SI ESTÁ LOGUEADO, VERIFICAMOS QUE TIENE ACCESO A LA PÁGINA
        If Not cls_security.PAGINAS_HABILITADAS.Contains(page_name) Then
            Response.Redirect("login.aspx")
            Exit Sub
        End If
        'If cls_security.usuario_actual.es_empleado Then
        'empresas_de_empleado() 'Si se loguea correctame se verifica si trabaja para mas de una empresa

        'End If


    End Sub

    Sub inicializar_variables()
        Dim sql As New cls_db
        Dim dt As DataTable = sql.ejecutar_sp("SP_WHATSAPP_CONSUL")
        numero_whatsapp = dt(0)(1)
    End Sub


    Public Function empresas_de_empleado() As Boolean
        perfil = cls_security.usuario_actual.perfil.codigo
        'Dim url As String = HttpContext.Current.Request.Url.AbsoluteUri
        'If url.Contains("empleado_index") Then
        'End If

        Dim sql As New cls_db
        Dim dt As DataTable
        Dim dt_sin_firma As DataTable
        Dim cuil As String = cls_security.usuario_actual.cuil
        Dim empresa_id As String = cls_security.usuario_actual.empresa_id

        sql.parametros.Add("cuil", cuil)
        dt = sql.ejecutar_sp("SP_Usuarios_en_empresas")
        'cls_utils.Log("SP_Usuarios_en_empresas dt.Rows.Count " & dt.Rows.Count)

        If dt.Rows.Count > 1 Then
            empresas_de_empleados_flag = True
            index_empresa_empleado = dt.Rows.Count
            'cls_utils.Log("index_empresa_empleado" & dt.Rows(0).ToString)

        End If
        'sql.parametros.Add("empresa_id", empresa_id)

        'dt_sin_firma = sql.ejecutar_sp("SP_Docs_sin_firmar_GRILLA")

        'For Each row In dt.Rows ' este for carga variables
        '    Dim empresa As String = row.itemArray(3).ToString
        '    Dim emp_id As String = row.itemArray(10).ToString

        '    empresas_de_empleados.Add(empresa)
        '    'cls_utils.Log(empresa)
        '    empresa_btn_id.Add(emp_id)
        '    'cls_utils.Log(emp_id)

        'Next

        'For Each empresa_id_cargadas In empresa_btn_id 'este for completa el badgeCount
        '    sql.parametros.Clear()
        '    sql.parametros.Add("cuil", cuil)
        '    sql.parametros.Add("empresa_id", empresa_id_cargadas)
        '    dt_sin_firma = sql.ejecutar_sp("SP_Docs_sin_firmar_GRILLA")
        '    'cls_utils.Log("dt_sin_firma.Rows.Count " & dt_sin_firma.Rows.Count)
        '    badgeCount.Add(dt_sin_firma.Rows.Count)
        'Next
        Return True
    End Function


End Class
