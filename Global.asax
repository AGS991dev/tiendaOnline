<%@ Application Language="VB" %>
<%@ Import Namespace="System.Web.Routing" %>

<script runat="server">

    Sub Application_Start(ByVal sender As Object, ByVal e As EventArgs)
        ' Code that runs on application startup
        RegisterRoutes(RouteTable.Routes)
    End Sub

    Sub Application_End(ByVal sender As Object, ByVal e As EventArgs)
        ' Code that runs on application shutdown
        ' Obtén la última excepción que ocurrió
        Dim lastError As Exception = Server.GetLastError()

        ' Loguea el error si es necesario
        ' Logger.LogError(lastError)

        ' Redirige a la página de error personalizada
        'Response.Redirect("~/access_recovery.aspx")
    End Sub

    Sub Application_Error(ByVal sender As Object, ByVal e As EventArgs)
        ' Code that runs when an unhandled error occurs
        Dim lastError As Exception = Server.GetLastError()

        ' Loguea el error si es necesario
        ' Logger.LogError(lastError)

        ' Redirige a la página de error personalizada
        cls_utils.Log("------------------- error --- " & lastError.ToString)
        Response.Redirect("~/access_recovery.aspx")
    End Sub

    Sub Session_Start(ByVal sender As Object, ByVal e As EventArgs)
        ' Code that runs when a new session is started
    End Sub

    Sub Session_End(ByVal sender As Object, ByVal e As EventArgs)
        ' Code that runs when a session ends. 
        ' Note: The Session_End event is raised only when the sessionstate mode
        ' is set to InProc in the Web.config file. If session mode is set to StateServer 
        ' or SQLServer, the event is not raised.
    End Sub

    Sub RegisterRoutes(ByVal routes As RouteCollection)

        routes.MapPageRoute("inicio", "inicio", "~/inicio.aspx")
        routes.MapPageRoute("ventas", "ventas", "~/vendedor_index.aspx")
        routes.MapPageRoute("seguridad", "seguridad", "~/supervisor_index.aspx")
        routes.MapPageRoute("deposito", "deposito", "~/deposito_index.aspx")
        routes.MapPageRoute("compras", "compras", "~/enc_compras_index.aspx")
        routes.MapPageRoute("mercaderia", "mercaderia", "~/enc_deposito_index.aspx")
    End Sub

</script>