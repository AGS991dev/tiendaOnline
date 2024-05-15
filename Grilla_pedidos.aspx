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
            <!-- Definición del popup -->

            <center>
            <h1>Aquí verás los pedidos realizados a través de la web</h1>
            <h6>Los productos pedidos solo se descuentan del <b>Stock</b> si el <b>Status</b> es <b>ENTREGADO</b>.</h6>
            </center>


                                <asp:ScriptManager runat="server" ID="ScriptManager_grilla_pedidos"></asp:ScriptManager>

                                    <asp:UpdatePanel ID="panel_pedidos" runat="server" UpdateMode="Conditional">
                                            <ContentTemplate>
                                            <div style="display: flex; justify-content: flex-start; flex-wrap: wrap; margin: 0 10px; padding: 10px 0px 0px 10px;; width: 100%; background: #f2f2f2; border-radius: 5px 5px 0px 0px;">
                                                <span>Filtrá por Estado:</span>
                                            </div>
                                            <div style="display: flex;flex-wrap: wrap;margin: 0 0px 20px 10px;padding: 5px;width: 100%;background: #f2f2f2;border-radius: 0px 0px 5px 5px; }">
                                                <span style="margin: 10px;background: #e1f0c4;color:black" class="btn btn_categoria_buscar" cat="ENTREGADO">ENTREGADO</span>
                                                <span style="margin: 10px;background: #fff6cc;color:black" class="btn btn_categoria_buscar" cat="EN PROCESO">EN PROCESO</span>
                                                <span style="margin: 10px;background: #ff000054;color:black" class="btn btn_categoria_buscar" cat="PENDIENTE">PENDIENTE</span>
                                            </div>
                                        <!---->
                                        <ASP:GridView ID ="GV_pedidos" runat="server" AutoGenerateColumns="false"  CellSpacing='0' Width='100%'>
                                        <Columns>
                                
                                           <ASP:TemplateField HeaderText="Pedidos">
                                                <ItemTemplate>
                                                    <div class="card" style="display: flex; width: 220px; height: 250px; z-index: 1;">
                                                        <div class="card-content">
                                                            <a href='c_pedido_lista.aspx?id=<%#Eval("id")%>' style="display: flex; flex-direction: column; position: absolute; left: 40px; top: 10px;">
                                                                <span  style="display: flex; position: relative; left: -18px;">
                                                                    <span  style="display: flex;"><span><img src="./static/img/pedido.png" style="width: 25px; position: relative; left: -10px;"/><span style="font-size: 18px;color:black" >Pedido <b><%#Eval("id")%></b></span><br />
                                                                    <span  style="display: flex;"><span><img src="./static/img/man.png" style="width: 25px; position: relative; left: -10px;"/><span onclick="mostrarPopup('<%#Eval("nombre_cliente")%>', '<%#Eval("celular")%>', '<%#Eval("direccion")%>'); return false;" style="font-size: 18px;color:black" id="btnVerInfo" ><%#Eval("nombre_cliente")%></span><br />
                                                                    <span  style="display: flex;"><span><img src="./static/img/calendar.png" style="width: 25px; position: relative; left: -10px;"/></span> <p style="font-size: 18px;color:black"><%#Eval("fecha")%></p></span>
                                                                    <span  style="display: flex;"><span><img src="./static/img/pedido_desc.png" style="width: 25px; position: relative; left: -10px;"/></span> <p style="font-size: 18px;color:black"><%#Eval("Cantidad Total")%> Artículos</p></span>
                                                                    <span  style="display: flex; position: relative; justify-content: center; top: 10px;"><span><img src="./static/img/money.png" style="width: 35px; position: relative; left: -10px; bottom: -2px;"/></span> <span style="font-size: 20px;color:black"><b>$<%#Eval("monto")%>.00</b></span></span><br />
                                                                </span>
                                                            </a>
                                                            <span pedido="<%#Eval("id")%>" class="pendiente <%#Eval("s")%>" style="box-shadow: rgb(0 0 0 / 15%) 1.95px 1.95px 2.6px; padding: 10px; border-radius: 3px; position: relative; left: 85px; bottom: -185px; color: black;"><%#Eval("status")%></span>
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
        .activator {
            margin-bottom: 5px;
        }

        span[dire=" 0"] {
            display: none;
        }

        tbody {
            background: #dcdcdc5c;
            display: flex;
            justify-content: center;
            flex-wrap: wrap;
        }

        .P { /*PENDIENTE*/
            background: #ff000054;
        }

        .E { /*ENTREGADO*/
            background: #7ec0023b;
        }

        .A { /*EN PROCESO*/
            background: #ffd40033;
        }

        .pendiente {
            cursor: pointer;
        }
        /*.swal2-cancel{
            background:blue !important;
        }*/
        .swal2-styled.swal2-confirm {
            background: #4caf50 !important;
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
                        //console.log('Pedido En Proceso')
                    }
                });
            }

            $(".btn_categoria_buscar").click(function () {
                var obj = this
                var categoria_a_buscar = $(obj).attr("cat")
                $('input[type="search"]').val(categoria_a_buscar).keyup();
            })
        });

    </script>
</asp:Content>