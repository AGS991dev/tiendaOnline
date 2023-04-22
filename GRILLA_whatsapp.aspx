<%@ Page Language="VB" AutoEventWireup="false" MasterPageFile="~/master.master" CodeFile="GRILLA_whatsapp.aspx.vb" Inherits="GRILLA_whatsapp" %>

<asp:Content runat="server" ContentPlaceHolderID="contenido_nav">
    <a href="supervisor_index.aspx" class="breadcrumb">INICIO</a>
    <a href="frm_whatsapp.aspx" class="breadcrumb"><%=Titulo %></a>
</asp:Content>

<asp:Content runat="server" ContentPlaceHolderID="contenido_body">

    <form id="grilla" runat="server">

        <div class="container-lg">

            
            <h1><%=Titulo %></h1>
            <h5>El número de telefono aquí guardado es donde se reciben los Pedidos de la Tienda Online</h5><br />
            <%= tabla%>
        </div>

    </form>

</asp:Content>


<asp:Content runat="server" ContentPlaceHolderID="contenido_js">
    <script type="text/javascript">
        $('td:nth-child(1)').hide()//
        $('th:nth-child(1)').hide()//borro primera columna
     </script>
</asp:Content>