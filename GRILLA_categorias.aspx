<%@ Page Language="VB" AutoEventWireup="false" MasterPageFile="~/master.master" CodeFile="GRILLA_categorias.aspx.vb" Inherits="GRILLA_categorias" %>

<asp:Content runat="server" ContentPlaceHolderID="contenido_nav">
    <a href="supervisor_index.aspx" class="breadcrumb">INICIO</a>
    <a href="frm_categorias.aspx" class="breadcrumb"><%=Titulo %></a>
</asp:Content>

<asp:Content runat="server" ContentPlaceHolderID="contenido_body">

    <form id="grilla" runat="server">

        <div class="container-lg">

            <a href="frm_categorias.aspx" class="btn-add" style="position: relative; top: 20px;"><i class="fas fa-plus"></i></a><br />
            <h1><%=Titulo %></h1>
            <h5>Las Categorías aquí agregadas estarán disponibles al momento de agregar un Producto desde el <b><a href="frm_Stock.aspx#txt_categoria">Almacén</a></b></h5><br />

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