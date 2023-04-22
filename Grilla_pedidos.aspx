<%@ Page Language="VB" AutoEventWireup="false" MasterPageFile="~/master.master" CodeFile="Grilla_pedidos.aspx.vb" Inherits="Grilla_pedidos" %>

<asp:Content runat="server" ContentPlaceHolderID="contenido_nav">
    <a href="supervisor_index.aspx" class="breadcrumb">INICIO</a>
    <a href="frm_<%=Titulo%>.aspx" class="breadcrumb"><%=Titulo %></a>
</asp:Content>

<asp:Content runat="server" ContentPlaceHolderID="contenido_body">
    <br />
    <center>
    <div class="contenedor_icon_pedido" style="display: flex; justify-content: center;">
        <img src="./static/img/price-tag.png" class="bounce" style="width: 100px;margin-right:10px"/>
        <h1 style="text-align:center"><%=Titulo %></h1>
    </div>
    </center>

    <div class="container">
        <br />
        <div >
        <form id="Form_fv_empresas" runat="server">
            <center>
            <h1>Aquí verás los pedidos realizados a través de la web</h1>
            <h6>Los productos pedidos solo se descuentan del <b>Stock</b> si el <b>Status</b> es <b>ENTREGADO</b>.</h6>
            </center>


                                <asp:ScriptManager runat="server" ID="ScriptManager_grilla_pedidos"></asp:ScriptManager>

                                    <asp:UpdatePanel ID="panel_pedidos" runat="server" UpdateMode="Conditional">
                                            <ContentTemplate>
                                        <!---->
                                        <ASP:GridView ID ="GV_pedidos" runat="server" AutoGenerateColumns="false"  CellSpacing='0' Width='100%'>
                                        <Columns>
                                
                                            <ASP:TemplateField HeaderText = "Pedidos" >
                                                <ItemTemplate>
                                                      <div class="card" style="display:flex;width:230px;height: 285px;text-align:left;z-index:1">
                                                        <div class="card-content">
                                                          <a href='c_pedido_lista.aspx?id=<%#Eval("id")%>' style="display: flex; flex-direction: column; text-align: center; position: absolute;left: 25%;">
                                                              <span class="activator grey-text text-darken-4" style="display:flex;"><span><img src="./static/img/pedido.png"style="width: 30px; position: relative;  left: -10px;"/></span> <p style="font-size: 22px;">Pedido <%#Eval("id")%></p> </span><br />
                                                              <span class="activator grey-text text-darken-4" style="display:flex;"><span><img src="./static/img/calendar.png"style="width: 30px; position: relative; left: -10px;"/></span> <p style="font-size: 18px;"><%#Eval("fecha")%></p></span>
                                                              <span class="activator grey-text text-darken-4" style="display:flex;"><span><img src="./static/img/pedido_desc.png"style="width: 30px; position: relative;  left: -10px;"/></span> <p style="font-size: 20px;"><%#Eval("Cantidad Total")%> Artículos</p> </span>
                                                              <span class="activator grey-text text-darken-4" style="display:flex;"><span><img src="./static/img/money.png"style="width: 30px; position: relative;  left: -10px;"/></span> <b style="font-size: 20px;">$<%#Eval("monto")%>.00</b> </span><br />
                                                          </a>
                                                          <span pedido="<%#Eval("id")%>" class="pendiente activator grey-text text-darken-4 <%#Eval("s")%>" style="box-shadow: rgb(0 0 0 / 15%) 1.95px 1.95px 2.6px; padding: 10px; border-radius: 3px; position: relative; left: 46%; bottom: -210px;"><%#Eval("status")%></span>
                                                        </div>
                                                       </div>
                                                       </a>
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
        .activator {
            margin-bottom:5px;
        }
        span[dire=" 0"]{
            display:none;
        }
        tbody{
            background: #dcdcdc5c;
            display:flex;
            justify-content:center;
            flex-wrap:wrap;
        }
        .P{/*PENDIENTE*/
            background:#ff000054;
        }
        .E{/*ENTREGADO*/
            background:#7ec0023b;
        }
        .A{/*EN PROCESO*/
            background:#ffd40033;
        }
        .pendiente{
            cursor:pointer;
        }
        /*.swal2-cancel{
            background:blue !important;
        }*/
        .swal2-styled.swal2-confirm{
            background:#4caf50 !important;
        }


    </style>
</asp:Content>


<asp:Content runat="server" ContentPlaceHolderID="contenido_js">
    <script type="text/javascript">
        $('document').ready(function () {
            var selector = $('#contenido_body_GV_pedidos')
            inicializar_grilla(selector)
            //$('td:nth-child(1)').hide()//
            //$('th:nth-child(1)').hide()//borro primera columna

            //var logo = $("[data-th=Logo]")//colocamos logo en grilla
            //for (i=0;i<logo.length;i++){
            //var ruta_logo = logo[i].textContent
            //console.log(ruta_logo = logo[i].textContent)
            //$(logo[i]).html('<img src="'+ruta_logo+'" width="100px">');
            //}
            $('.P').click(function () {
                var obj = this
                mostrar_ventana_para_cambiar_status_del_pedido(obj)
            })
            $('.A').click(function () {
                var obj = this
                mostrar_ventana_para_cambiar_status_del_pedido2(obj) //el 2 quita un boton
            })
            $('.E').click(function () {
                var obj = this
                Swal.fire('Este pedido ya fue entregado')
            })

            function mostrar_ventana_para_cambiar_status_del_pedido(obj) {
                var pedido = $(obj).attr('pedido')
                Swal.fire({
                    title: '¿En qué estado está este pedido?',
                    showDenyButton: true,
                    showCancelButton: true,
                    confirmButtonText: 'Entregado',
                    cancelButtonText: 'Salir',
                    denyButtonText: `En Proceso`,
                }).then((result) => {
                    /* Read more about isConfirmed, isDenied below */
                    if (result.isConfirmed) {//entregado
                        ir_al_back_actualizar_pedido_entregado(pedido)
                        Swal.fire('¡Pedido cobrado!', 'Stock descontado', 'success')
                        $(obj).css('background', '#7ec0023b')
                        $(obj).html('<b>ENTREGADO</b>')
                        $(obj).removeClass('P')
                        $(obj).addClass('E')
                    } else if (result.isDenied) {//en proceso
                        ir_al_back_actualizar_pedido_enproceso(pedido)
                        $(obj).css('background', '#ffd40033')
                        $(obj).html('<b>EN PROCESO</b>')
                        $(obj).removeClass('P')
                        $(obj).addClass('A')
                        Swal.fire('¡Preparando Pedido!', '', 'info')
                    }
                })
            };
            
            function mostrar_ventana_para_cambiar_status_del_pedido2(obj) {
                var pedido = $(obj).attr('pedido')
                Swal.fire({
                    title: '¿Fue entregado el pedido?',
                    showCancelButton: true,
                    confirmButtonText: 'SI',
                    cancelButtonText: 'NO'
                }).then((result) => {
                    /* Read more about isConfirmed, isDenied below */
                    if (result.isConfirmed) {//entregado
                        ir_al_back_actualizar_pedido_entregado(pedido)
                        $(obj).css('background', '#7ec0023b')
                        $(obj).html('<b>ENTREGADO</b>')
                        $(obj).removeClass('A')
                        $(obj).addClass('E')
                        Swal.fire('¡Pedido cobrado, Stock descontado!', '', 'success')
                    } 
                })
            };

            function ir_al_back_actualizar_pedido_entregado(pedido) {
                $.ajax({
                    type: "POST",
                    url: "grilla_pedidos.aspx/actualizar_pedido_entregado",
                    data: '{pedido: "' + pedido + '"}',
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (response) {
                        console.log('Pedido Entregado')
                    }
                });
            }

            function ir_al_back_actualizar_pedido_enproceso(pedido) {
                $.ajax({
                    type: "POST",
                    url: "grilla_pedidos.aspx/actualizar_pedido_enproceso",
                    data: '{pedido: "' + pedido + '"}',
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (response) {
                        console.log('Pedido En Proceso')
                    }
                });
            }

        });

     </script>
</asp:Content>