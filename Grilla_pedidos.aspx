<%@ Page Language="VB" AutoEventWireup="false" MasterPageFile="~/master.master" CodeFile="Grilla_pedidos.aspx.vb" Inherits="Grilla_pedidos" %>

<asp:Content runat="server" ContentPlaceHolderID="contenido_nav">
    <a href="supervisor_index.aspx" class="breadcrumb">INICIO</a>
    <a href="#" class="breadcrumb"><%=Titulo %></a>
</asp:Content>

<asp:Content runat="server" ContentPlaceHolderID="contenido_body">
    <div class="overlay" style="display:none;"></div>

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
            <div class="info_pago" style="max-width: 350px; border: 1px solid gainsboro; border-radius: 3px; padding: 15px;display:none">
                <form class="pago_form">
                    <!-- Select para id_forma_pago -->
                    <div class="form-group">
                        <label for="cbo_id_forma_pago">Forma de Pago:</label>
                        <select id="cbo_id_forma_pago" name="id_forma_pago" class="form-control">
                            <option value="1">Efectivo</option>
                            <option value="2">Mercado Pago</option>
                            <option value="3">Tarjeta</option>
                        </select>
                    </div>
                    <!-- Select para tipo_tarjeta -->
                    <div class="form-group form-group-tarjeta">
                        <label for="cbo_tipo_tarjeta">Tipo de Tarjeta:</label>
                        <select id="cbo_tipo_tarjeta" name="tipo_tarjeta" class="form-control">
                            <option value="Visa">Visa</option>
                            <option value="AMEX">AMEX</option>
                            <option value="MasterCard">MasterCard</option>
                        </select>
                    </div>
                    <div class="form-group form-group-tarjeta" style="display:none">
                        <div class="card-container">
                            <div class="credit-card">
                                <p style="color: white; margin-left: 10px;" class="credit-card-typeName">VISA</p>
                                <div class="credit-card__number">
                                    <input type="text" id="txt_n_tarjeta" name="n_tarjeta" class="card-input" maxlength="19" placeholder="xxxx xxxx xxxx 1234" />
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Inputs para n_lote, n_terminal, n_autorizacion, n_tarjeta -->
                    <div class="form-group form-group-tarjeta" style="display:none">
                        <label for="txt_n_lote">N° Lote:</label>
                        <input type="text" id="txt_n_lote" name="txt_n_lote" class="form-control">
                    </div>
                    <div class="form-group form-group-tarjeta" style="display:none">
                        <label for="txt_n_terminal">N° Terminal:</label>
                        <input type="text" id="txt_n_terminal" name="txt_n_terminal" class="form-control">
                    </div>
                    <div class="form-group form-group-tarjeta" style="display:none">
                        <label for="txt_n_autorizacion">N° Autorización:</label>
                        <input type="text" id="txt_n_autorizacion" name="txt_n_autorizacion" class="form-control">
                    </div>
                    <div class="form-group form-group-tarjeta" style="display:none">
                        <label for="txt_n_cupon">N° Cupón:</label>
                        <input type="text" id="txt_n_cupon" name="txt_n_cupon" class="form-control">
                    </div>
                    <br />
                    <!-- Botón para ir atrás -->
                    <div style="display: flex;justify-content:end;gap: 10px;">
                        <button type="button" class="btn btn-secondary registrarCompra">Registrar Compra</button>
                        <button type="button" class="btn btn-secondary atras">Atrás</button>
                    </div>
                </form>
            </div>
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
                                            <div style="justify-content: center; display: flex; flex-wrap: wrap; margin: 0 0px 20px 10px; padding: 5px; width: 100%; background: #f2f2f2; border-radius: 0px 0px 5px 5px;">
                                                <span style="margin: 10px;background: #e1f0c4;color:black" class="btn btn_categoria_buscar" cat="ENTREGADO">ENTREGADO</span>
                                                <span style="margin: 10px;background: #fff6cc;color:black" class="btn btn_categoria_buscar" cat="EN PROCESO">EN PROCESO</span>
                                                <span style="margin: 10px;background: #ff000054;color:black" class="btn btn_categoria_buscar" cat="PENDIENTE">PENDIENTE</span>
                                            </div>
                                        <!---->
                                        <ASP:GridView ID ="GV_pedidos" runat="server" AutoGenerateColumns="false"  CellSpacing='0' Width='100%'>
                                        <Columns>
                                
                                           <ASP:TemplateField HeaderText="Pedidos">
                                                <ItemTemplate>
                                                    <div class="card" style="width: 220px; height: 250px; z-index: 1;">
                                                        <div style="margin:auto;text-align: left;">
                                                            <a href='c_pedido_lista.aspx?id=<%#Eval("id")%>' style="">
                                                                <div style="padding: 0px 5px;position: relative; top: 10px;">
                                                                    <span  style="display: flex;"><span><img src="./static/img/calendar.png" style="width: 25px;   margin: 0px 10px;"/><span style="color:black;position: relative; top: -5px;" ><%#Eval("fecha")%></span><br />
                                                                    <span  style="display: flex;"><span><img src="./static/img/man.png" style="width: 25px;margin: 0px 10px;"/><span onclick="mostrarPopup('<%#Eval("nombre_cliente")%>', '<%#Eval("celular")%>', '<%#Eval("direccion")%>'); return false;" style="color:black;position: relative; top: -5px;" id="btnVerInfo" ><%#Eval("nombre_cliente")%></span><br />
                                                                    <span  style="display: flex;"><span><img src="./static/img/pedido.png" style="width: 25px;   margin: 0px 10px;"/><span style="color:black;position: relative; top: -5px;" >Pedido <b><%#Eval("id")%></b></span><br />
                                                                    <span  style="display: flex;"><span><img src="./static/img/pedido_desc.png" style="width: 25px;margin: 0px 10px;"/></span> <p style="color:black;position: relative; top: -5px;"><%#Eval("Cantidad Total")%> Artículos</p></span>
                                                                    <span  style="display: flex;"><span><img src="./static/img/money.png" style="width: 25px;margin: 0px 10px;"/></span> <span style="color: black; font-size: 20px; position: relative; top: -5px;"><b>$<%#Eval("monto")%>.00</b></span></span><br />
                                                                </span>
                                                            </a>
                                                        </div>
                                                        <center pedido="<%#Eval("id")%>" class="pendiente <%#Eval("s")%>" style="position: relative; top: 18px;box-shadow: rgb(0 0 0 / 15%) 1.95px 1.95px 2.6px; padding: 10px; border-radius: 3px; color: black; font-size: 12px;"><%#Eval("status")%></center>
                                                    </div>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                         

                                        </Columns>
                                     </asp:GridView>
                                     <!---->
                                            </ContentTemplate>
                                     </asp:UpdatePanel>

                <audio class="monedas">
                    <source src="static/audio/monedas.mp3" type="audio/mp3">
                </audio>
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
        /* Estilo para el overlay */
        .overlay {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.5); /* Fondo semitransparente */
            z-index: 1000; /* Asegurarse de que esté sobre todo */
        }

        /* Centrar el contenedor de pago */
        .info_pago {
            position: fixed;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%); /* Centrar vertical y horizontalmente */
            background: white; /* Fondo blanco */
            z-index: 1001; /* Un nivel más alto que el overlay */
            padding: 20px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2); /* Sombra para el formulario */
        }
        .card-container {
            width: 320px;
            margin: 20px auto;
            perspective: 1000px;
        }

        .credit-card {
            width: 100%;
            height: 200px;
            border-radius: 15px;
            background: linear-gradient(135deg, #8e44ad, #c0392b);
            color: white;
            position: relative;
            box-shadow: 0px 4px 20px rgba(0, 0, 0, 0.2);
            padding: 20px;
            box-sizing: border-box;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
        }

        .credit-card__number {
            margin-top: 30px;
        }

        .card-input {
            font-size: 24px;
            background: transparent;
            color: white;
            border: none;
            width: 100%;
            letter-spacing: 2px;
            outline: none;
            padding: 10px 0;
            border-bottom: 2px solid rgba(255, 255, 255, 0.7);
            font-family: 'Courier New', Courier, monospace;
            box-sizing: border-box;
            text-align: center;
        }

        .card-input::placeholder {
            color: rgba(255, 255, 255, 0.6);
        }

        .credit-card__number input::-webkit-input-placeholder {
            color: rgba(255, 255, 255, 0.7);
        }

        .card-input:focus {
            border-bottom: 2px solid #ecf0f1;
        }
        .caret{
            display:none
        }
    </style>
</asp:Content>


<asp:Content runat="server" ContentPlaceHolderID="contenido_js">
    <script type="text/javascript">

        $('document').ready(function () {
            var selector = $('#contenido_body_GV_pedidos')
            inicializar_grilla_orderBy(selector, undefined, true, 10, "desc")
            //table.order(10, "desc").draw();
            //inicializar_grilla(selector)
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
                    confirmButtonText: 'Cobrar y Despachar',
                    cancelButtonText: 'Salir',
                    denyButtonText: `En Proceso`,
                }).then((result) => {
                    /* Read more about isConfirmed, isDenied below */
                    if (result.isConfirmed) {//entregado
                        $('.info_pago').fadeIn(250)
                        $('.overlay').fadeIn(250);

                        $('.form-group-tarjeta').hide()
                        $('.registrarCompra').click(function () {
                            ir_al_back_actualizar_pedido_entregado(pedido)
                            Swal.fire('¡Pedido cobrado!', 'Stock descontado', 'success')
                            $(obj).css('background', '#7ec0023b')
                            $(obj).html('<b>ENTREGADO</b>')
                            $(obj).removeClass('P')
                            $(obj).addClass('E')
                            $('.monedas').prop("volume", 0.3);
                            $(".monedas")[0].play();

                            $('.info_pago').fadeOut(250)
                            $('.overlay').fadeOut(250);
                            // Vaciar los campos de texto
                            $('#txt_n_lote, #txt_n_terminal, #txt_n_autorizacion, #txt_n_cupon').val('');

                            // Reiniciar los select a su primera opción
                            $('#cbo_id_forma_pago').prop('selectedIndex', 0).trigger('change');  // Reinicia el select a la primera opción
                        })
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

            $('.atras').click(function () {
                $('.info_pago').fadeOut(250)
                $('.overlay').fadeOut(250);
                // Vaciar los campos de texto
                $('#txt_n_lote, #txt_n_terminal, #txt_n_autorizacion, #txt_n_cupon').val('');

                // Reiniciar los select a su primera opción
                $('#cbo_id_forma_pago').prop('selectedIndex', 0).trigger('change');  // Reinicia el select a la primera opción

            })

            //INICIALIZAR CLEAVE
            var cleave = new Cleave('#txt_n_tarjeta', {
                creditCard: true,
                delimiter: ' ',
                onCreditCardTypeChanged: function (type) {
                    console.log(type);
                }
            });
            $('#txt_n_tarjeta').on('input', function () {
                var value = $(this).val().replace(/\s+/g, ''); // Elimina espacios

                if (value.length > 3) {
                    // Obtiene los últimos 4 dígitos
                    var lastFour = value.slice(-4);
                    // Reemplaza los primeros dígitos con 'xxxx'
                    var maskedValue = 'xxxx xxxx xxxx ' + lastFour;
                    // Asigna el valor formateado al input
                    $(this).val(maskedValue);
                }
            });


            // Escuchar el evento change del select de forma de pago
            $('#cbo_id_forma_pago').change(function () {
                var formaPagoSeleccionada = $(this).val();

                // Si selecciona Mercado Pago (valor 2) o Cupón (valor 3)
                if (formaPagoSeleccionada != "1" && formaPagoSeleccionada != "2") {
                    // Mostrar los campos de tarjeta
                    $('.form-group-tarjeta').fadeIn(250);
                } else {
                    // Si selecciona otra opción, ocultar los campos de tarjeta
                    $('.form-group-tarjeta').fadeOut(250);
                }
            });

            // Escuchar el evento change del select de forma de pago
            $('#cbo_tipo_tarjeta').change(function () {
                var nombreTarjeta = $('#cbo_tipo_tarjeta option:selected').text();
                $('.credit-card-typeName').text(nombreTarjeta)
            });

        });

    </script>
</asp:Content>