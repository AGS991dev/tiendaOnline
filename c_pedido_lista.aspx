<%@ Page Language="VB" AutoEventWireup="false" MasterPageFile="~/master.master" CodeFile="c_pedido_lista.aspx.vb" Inherits="c_pedido_lista" %>

<asp:Content runat="server" ContentPlaceHolderID="contenido_nav">
    <a href="supervisor_index.aspx" class="breadcrumb">INICIO</a>
    <a href="Grilla_pedidos.aspx" class="breadcrumb">PEDIDOS</a>
    <a href="#" class="breadcrumb"><%=Titulo %></a>
</asp:Content>

<asp:Content runat="server" ContentPlaceHolderID="contenido_body">
    <br />
    <center>
        <p style="font-size: 35px;"> PEDIDO <%=pk %></p>
        <p style="font-size:20px"><b><%=cantidad %></b> Artículos</p>
        <p style="font-size:20px">Total pedido <b>$<%=precio_total%>.00</b></p>
    </center>
        
    <br />
    <div class="container">

        <div style="box-shadow: rgba(0, 0, 0, 0.18) 0px 2px 4px;margin:2vw;padding:2vw">
        <form id="Form_fv_empresas" runat="server">

                                <asp:ScriptManager runat="server" ID="ScriptManager_grilla_pedido"></asp:ScriptManager>

                                    <asp:UpdatePanel ID="panel_pedido" runat="server" UpdateMode="Conditional">
                                            <ContentTemplate>
                                        <!---->


                                     <!---->
                                        <ASP:GridView ID ="GV_pedido" runat="server" class="striped" AutoGenerateColumns="false"  CellSpacing='0' Width='100%'>
                                        <Columns>

                                           <ASP:TemplateField HeaderText = "Articulo" >
                                                <ItemTemplate>
                                                    <div  style="width: 300px;">
                                                          <div class="card tarjeta"">
                                                            <div class="card-image waves-effect waves-block waves-light">
                                                                <div class="owl-carousel owl-theme">
                                                                    <img class="activator" style="max-height:350px;" src="<%#Eval("ruta_imagen")%>">
                                                                    <img class="activator" style="max-height:350px;" src="<%#Eval("ruta_imagen_2")%>">
                                                                    <img class="activator" style="max-height:350px;" src="<%#Eval("ruta_imagen_3")%>">
                                                                </div>
                                                            </div>

                                                            <div class="card-content">
                                                              <p><b><%#Eval("cantidad")%> Unidades.</b></p>
                                                              <span class="card-title activator grey-text text-darken-4"><%#Eval("nombre")%></span>
                                                              <p><%#Eval("categoria")%></p>
                                                            </div>
                                                              <div class="card-action" style="display: flex;justify-content: space-around;">
                                                                  <span style="font-family:Bangers;font-size:40px;position: relative;right: 15px;">$<%#Eval("precio")%>.00</span>
                                                              </div>

                                                          </div>
                                                    </div>
                                                    
                                                    
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
    <style>
        tbody{
            display:flex;
            flex-wrap:wrap;
        }
        .tarjeta{
            box-shadow:none !important;
        }
        @media screen and (max-width: 601px) {
            body{
            }
            .tarjeta {
                box-shadow: none !important;
                position:relative;
                left:25%;
            }
        }
    </style>

</asp:Content>


<asp:Content runat="server" ContentPlaceHolderID="contenido_js">
    <script type="text/javascript">
        $('document').ready(function () {

            var selector = $('.striped')
            inicializar_grilla(selector)

            $(".owl-carousel").owlCarousel({
                nav: false,
                slideBy: 1,
                items: 1,
                loop: true,
                autoplay: true,
                autoplayTimeout: 7000,
                autoplayHoverPause: true
            });
            //$('td:nth-child(1)').hide()//
            //$('th:nth-child(1)').hide()//borro primera columna

            //var logo = $("[data-th=Logo]")//colocamos logo en grilla
            //for (i=0;i<logo.length;i++){
            //var ruta_logo = logo[i].textContent
            //console.log(ruta_logo = logo[i].textContent)
            //$(logo[i]).html('<img src="'+ruta_logo+'" width="100px">');
            //}
        });
     </script>
</asp:Content>