Imports Microsoft.VisualBasic
Imports System.Data

Public Class cls_security

    Public Const PERFIL_ADMIN As Integer = 1
    Public Const PERFIL_SUPERVISOR As Integer = 2
    Public Const PERFIL_EMPLEADO As Integer = 3

    Public Shared ReadOnly Property PAGINAS_HABILITADAS() As List(Of String)
        Get

            If usuario_actual.perfil.codigo = PERFIL_ADMIN Then Return ADMIN_PAGINAS
            If usuario_actual.perfil.codigo = PERFIL_SUPERVISOR Then Return SUPERVISOR_PAGINAS
            If usuario_actual.perfil.codigo = PERFIL_EMPLEADO Then Return EMPLEADO_PAGINAS

            Return New List(Of String)
        End Get
    End Property



    Public Shared ReadOnly Property ADMIN_PAGINAS As List(Of String)
        Get
            Dim paginas As New List(Of String)
            paginas.Add("admin_index.aspx".ToLower)
            paginas.Add("supervisor_index.aspx".ToLower)
            paginas.Add("Grilla_Empresas.aspx".ToLower)
            paginas.Add("Frm_Empresas.aspx".ToLower)
            paginas.Add("Frm_empleados.aspx".ToLower)
            paginas.Add("Grilla_Usuarios.aspx".ToLower)
            paginas.Add("Frm_Usuarios.aspx".ToLower)
            paginas.Add("Grilla_parametros.aspx".ToLower)
            paginas.Add("Frm_parametros.aspx".ToLower)
            paginas.Add("access_recovery.aspx".ToLower)
            paginas.Add("store.aspx".ToLower)

            Return paginas
        End Get

    End Property

    Public Shared ReadOnly Property SUPERVISOR_PAGINAS As List(Of String)
        Get
            Dim paginas As New List(Of String)
            paginas.Add("supervisor_index.aspx".ToLower)
            paginas.Add("empleado_index.aspx".ToLower)
            paginas.Add("Grilla_Empleados.aspx".ToLower)
            paginas.Add("Grilla_stock.aspx".ToLower)
            paginas.Add("grilla_ranking.aspx".ToLower)
            paginas.Add("Grilla_caja.aspx".ToLower)
            paginas.Add("Grilla_consulta.aspx".ToLower)
            paginas.Add("Grilla_categorias.aspx".ToLower)
            paginas.Add("Grilla_whatsapp.aspx".ToLower)
            paginas.Add("Grilla_pedidos.aspx".ToLower)
            paginas.Add("Frm_empleados.aspx".ToLower)
            paginas.Add("Frm_categorias.aspx".ToLower)
            paginas.Add("Frm_whatsapp.aspx".ToLower)
            paginas.Add("Frm_stock.aspx".ToLower)
            paginas.Add("access_recovery.aspx".ToLower)
            paginas.Add("c_ticket.aspx".ToLower)
            paginas.Add("c_pedido_lista.aspx".ToLower)
            paginas.Add("c_movimientos.aspx".ToLower)
            paginas.Add("store.aspx".ToLower)
            Return paginas
        End Get

    End Property

    Public Shared ReadOnly Property EMPLEADO_PAGINAS As List(Of String)
        Get
            Dim paginas As New List(Of String)
            paginas.Add("login.aspx".ToLower)
            paginas.Add("empleado_index.aspx".ToLower)
            paginas.Add("store.aspx".ToLower)

            Return paginas
        End Get

    End Property


    Public Shared ReadOnly Property usuario_actual As cls_usuario
        Get
            Return CType(System.Web.HttpContext.Current.Session("usuario_actual"), cls_usuario)
        End Get
    End Property


    '*********** SUBCLASES
    Public Class cls_usuario

        Public id As Integer = 0
        Public cuil As String
        Public logo As String
        Public razon_social As String
        Public nombre As String
        Public apellido As String
        Public pass As String 'encriptada
        Public perfil As cls_perfil
        Public empresa_id As Integer
        Public empresa_cuil As String
        Public debe_generar_pass As Integer
        Public debe_generar_certificado As Integer
        Public certificado_vigente_id As Integer
        Public legajo As String

        Public fecha_registro As DateTime

        Sub New(cuil As String)
            _cargar_usuario(cuil)
        End Sub


        Private Sub _cargar_usuario(cuil As String)

            Dim sql As New cls_db
            Dim dt As System.Data.DataTable
            Dim usuarios As System.Data.DataTable

            sql.parametros.Add("cuil", cuil)
            usuarios = sql.ejecutar_sp("SP_cargar_usuario_Consul")
            'dt = sql.ejecutar_sp("SP_UsuariosLogin_Consul")

            If usuarios.Rows.Count > 0 Then
                Dim dr As DataRow = usuarios.Rows(0)
                Me.id = dr("id")
                Me.cuil = cuil
                Me.logo = dr("logo").ToString
                Me.razon_social = dr("razon_social").ToString
                Me.nombre = dr("nombre").ToString
                Me.apellido = dr("apellido").ToString
                Me.legajo = dr("legajo").ToString
                Me.pass = dr("pass").ToString
                Me.perfil = New cls_perfil(dr("perfil_codigo"))
                Me.empresa_id = IIf(IsDBNull(dr("empresa_id")), Nothing, dr("empresa_id"))
                Me.empresa_cuil = IIf(IsDBNull(dr("empresa_cuil")), Nothing, dr("empresa_cuil"))
                Me.fecha_registro = IIf(IsDBNull(dr("fecha_registro")), Nothing, dr("fecha_registro"))

                If dr("debe_generar_pass") Is DBNull.Value Or dr("debe_generar_pass") = True Then
                    Me.debe_generar_pass = 1
                Else
                    If dr("debe_generar_pass") = False Then
                        Me.debe_generar_pass = 0
                    End If
                End If

                'Me.debe_generar_pass = IIf(IsDBNull(dr("debe_generar_pass")), Nothing, dr("debe_generar_pass"))

                Me.debe_generar_certificado = IIf(IsDBNull(dr("debe_generar_certificado")), Nothing, dr("debe_generar_certificado"))
                    Me.certificado_vigente_id = IIf(IsDBNull(dr("certificado_vigente_id")), Nothing, dr("certificado_vigente_id"))
                End If

        End Sub
        Public Sub _recargar_usuario(cuil As String, empresa_id As Integer)

            Dim sql As New cls_db
            Dim dt As System.Data.DataTable
            Dim usuarios As System.Data.DataTable

            sql.parametros.Add("cuil", cuil)
            sql.parametros.Add("empresa_id", empresa_id)
            usuarios = sql.ejecutar_sp("SP_recargar_usuario_Consul")

            If usuarios.Rows.Count > 0 Then
                Dim dr As DataRow = usuarios.Rows(0)
                Me.id = dr("id")
                Me.cuil = cuil
                Me.logo = dr("logo").ToString
                Me.razon_social = dr("razon_social").ToString
                Me.nombre = dr("nombre").ToString
                Me.apellido = dr("apellido").ToString
                Me.legajo = dr("legajo").ToString
                Me.pass = dr("pass").ToString
                Me.perfil = New cls_perfil(dr("perfil_codigo"))
                Me.empresa_id = IIf(IsDBNull(dr("empresa_id")), Nothing, dr("empresa_id"))
                Me.empresa_cuil = IIf(IsDBNull(dr("empresa_cuil")), Nothing, dr("empresa_cuil"))
                Me.fecha_registro = IIf(IsDBNull(dr("fecha_registro")), Nothing, dr("fecha_registro"))

                If dr("debe_generar_pass") Is DBNull.Value Or dr("debe_generar_pass") = True Then
                    Me.debe_generar_pass = 1
                Else
                    If dr("debe_generar_pass") = False Then
                        Me.debe_generar_pass = 0
                    End If
                End If

                'Me.debe_generar_pass = IIf(IsDBNull(dr("debe_generar_pass")), Nothing, dr("debe_generar_pass"))
                'Me.debe_generar_pass = IIf(IsDBNull(dr("debe_generar_pass")), 0, dr("debe_generar_pass"))

                Me.debe_generar_certificado = IIf(IsDBNull(dr("debe_generar_certificado")), Nothing, dr("debe_generar_certificado"))
                Me.certificado_vigente_id = IIf(IsDBNull(dr("certificado_vigente_id")), Nothing, dr("certificado_vigente_id"))

            End If

        End Sub

        Public Function login(pass As String) As Boolean

            If (Me.id <> 0) Then
                If pass = cls_crypto.Decrypt(Me.pass) Then
                    If Not IsNothing(Me.perfil) Then
                        System.Web.HttpContext.Current.Session("usuario_actual") = Me
                        Return True
                    End If
                End If
            End If

            Return False
        End Function



        Public ReadOnly Property es_admin() As Boolean
            Get
                Return Me.perfil.codigo = PERFIL_ADMIN
            End Get
        End Property


        Public ReadOnly Property es_supervisor() As Boolean
            Get
                Return Me.perfil.codigo = PERFIL_SUPERVISOR
            End Get
        End Property

        Public ReadOnly Property es_empleado() As Boolean
            Get
                Return Me.perfil.codigo = PERFIL_EMPLEADO
            End Get
        End Property

    End Class

    Public Class cls_perfil

        Public codigo As String
        Public descripcion As String

        Public ReadOnly Property page_index As String
            Get
                If Me.codigo = PERFIL_ADMIN Then Return "admin_index.aspx"
                If Me.codigo = PERFIL_SUPERVISOR Then Return "supervisor_index.aspx"
                If Me.codigo = PERFIL_EMPLEADO Then Return "empleado_index.aspx"

                Return "login.aspx"
            End Get

        End Property

        Sub New(codigo As String)
            _cargar_perfil(codigo)
        End Sub

        Private Sub _cargar_perfil(param_codigo As String)
            Dim sql As New cls_db
            Dim parametros As New Dictionary(Of String, Object)
            Dim dt As System.Data.DataTable
            parametros.Add("codigo", param_codigo)

            dt = sql.ejecutar_sp("SP_Perfiles_CONSUL", parametros)

            If dt.Rows.Count > 0 Then
                Dim dr As System.Data.DataRow = dt.Rows(0)
                Me.codigo = param_codigo
                Me.descripcion = dr("descripcion").ToString
            End If
        End Sub


    End Class



End Class
