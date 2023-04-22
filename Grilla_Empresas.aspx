<%@ Page Language="VB" AutoEventWireup="false" MasterPageFile="~/master.master" CodeFile="Grilla_Empresas.aspx.vb" Inherits="Grilla_Empresas" %>

<asp:Content runat="server" ContentPlaceHolderID="contenido_nav">
    <a href="admin_index.aspx" class="breadcrumb">INICIO</a>
    <a href="frm_<%=Titulo%>.aspx" class="breadcrumb"><%=Titulo %></a>
</asp:Content>

<asp:Content runat="server" ContentPlaceHolderID="contenido_body">

    <h1 style="text-align:center"><%=Titulo %></h1>
    <div class="container">
            <a href="frm_<%=Titulo %>.aspx" class="btn-add fadeInRightBig"><i class="fas fa-plus"></i></a>

        <div >
        <form id="Form_fv_empresas" runat="server">

                                <asp:ScriptManager runat="server" ID="ScriptManager_grilla_emp"></asp:ScriptManager>

                                    <asp:UpdatePanel ID="panel_empresas" runat="server" UpdateMode="Conditional">
                                            <ContentTemplate>
                                        <!---->
                                        <ASP:GridView ID ="GV_empresas" runat="server" class="striped" AutoGenerateColumns="false"  CellSpacing='0' Width='100%'>
                                        <Columns>
                                
                                           <ASP:BoundField DataField = "id" htmlencode="false" HeaderText="ID" />

                                           <ASP:TemplateField HeaderText = "Logo" >
                                                <ItemTemplate>
                                                    <div style="width: 50px;height: 50px;background-size: cover !important;border-radius: 5px;background-position: center !important;background:url(<%#Eval("logo")%>)"></div>
                                                </ItemTemplate>
                                            </asp:TemplateField>

                                            <ASP:BoundField DataField = "razon_social" htmlencode="false" HeaderText="Razón Social" />
                                            <ASP:BoundField DataField = "cuit" htmlencode="false" HeaderText="Cuit" />
                                            <ASP:TemplateField HeaderText = "Acciones" >
                                                <ItemTemplate>
                                                    <a href='Frm_Empresas.aspx?id=<%#Eval("id")%>' ><span class='waves-effect waves-light btn-small tooltipped card_color' data-position='top' data-tooltip='Editar' ><i class='material-icons'>edit</i></a>
                                                    <span id='btn_delete' url='Grilla_Empresas.aspx' obj_id='<%#Eval("id")%>' onclick='eliminar_registro(this,"Registro Eliminado Correctamente");' ><span class='waves-effect waves-light red btn-small tooltipped' data-position='top' data-tooltip='Eliminar' ><i class='material-icons'>delete</i></span>
                                                </ItemTemplate>
                                            </asp:TemplateField>

                                        </Columns>
                                     </asp:GridView>
                                     <!---->
                                            </ContentTemplate>
                                     </asp:UpdatePanel>
                </form>
            </div>
        </div>


</asp:Content>


<asp:Content runat="server" ContentPlaceHolderID="contenido_js">
    <script type="text/javascript">
        $('document').ready(function () {
            $('td:nth-child(1)').hide()//
            $('th:nth-child(1)').hide()//borro primera columna

            //var logo = $("[data-th=Logo]")//colocamos logo en grilla
            //for (i=0;i<logo.length;i++){
            //var ruta_logo = logo[i].textContent
            //console.log(ruta_logo = logo[i].textContent)
            //$(logo[i]).html('<img src="'+ruta_logo+'" width="100px">');
            //}
        });
     </script>
</asp:Content>