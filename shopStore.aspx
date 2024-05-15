<%@ Page Language="VB" AutoEventWireup="false" MasterPageFile="~/master.master" CodeFile="shopStore.aspx.vb" Inherits="shopStore" %>



<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="contenido_body">

    <div class="">
        <br />
        <form runat="server" id="form_login" autocomplete="off">

            <asp:ScriptManager runat="server" ID="ScriptManager_grilla_shop"></asp:ScriptManager>
            <asp:HiddenField ID="hi_input" runat="server" Value="" />

            <br />
            <div style="display: flex; justify-content: center; gap: 10px">
                <img class="tada logo_inicio" src="./static/img/mercadoshop.png" style="width: 25vw" />
            </div>
            <br />
            <br />
            <center>
                <h5 title="Podés ultimar los detalles de la compra directamente por Whatsapp" style="margin: 0 40px;">Agregá productos al carrito y enviá el whatsapp a la tienda con un solo <a href="#enviar_whatsapp" style="text-decoration: none">CLICK</a></h5>
            </center>
            <br />
            <br />
            <div style="display: flex; justify-content: flex-start; flex-wrap: wrap; margin: 0 10px; padding: 10px 0px 0px 10px;; width: 100%; background: #29357d1a; border-radius: 5px 5px 0px 0px;">
                <span>Filtrá por categorías:</span>
            </div>
            <div style="    display: flex;     justify-content: flex-start;     flex-wrap: wrap;     margin: 0 0px 20px 10px;     padding: 5px;     width: 100%;     background: #29357d1a;     border-radius: 0px 0px 5px 5px; }">
                <%For Each categoria As String In categorias%>
                <span style="margin: 10px" class="btn btn_categoria_buscar" cat="<%=categoria%>"><%=categoria%></span>
                <%Next%>
            </div>
            <div class="row">
                <div class="col_table" style="margin: 0 10px">

                    <div id="tab_buscar">

                        <div style="display: none">
                            <div class="combos_categorias">
                                <label for="cbo_categoria" class="cbo_estado" style="min-width: 90px; margin: 8px; position: relative; top: 5px;">Categoria</label>
                                <asp:DropDownList runat='server' ID='cbo_categoria' Style="margin: 8px; max-width: 50%; min-width: 100px;" type='text' class='form-control input-md' MaxLength='200' />
                            </div>
                            <asp:Button Style="margin: 20px; position: relative; top: 5px;" ID="btn_filtrar" runat="server" name="btn_filtrar" OnClientClick="modal_espere_on()" CssClass="btn btn_filtrar btn-info" Text="Buscar" />
                        </div>

                        <asp:UpdatePanel ID="panel_shop" runat="server" UpdateMode="Conditional">
                            <ContentTemplate>
                                <!--class="striped"-->
                                <asp:GridView ID="GV_shopStore" runat="server"  class="stripedShopStore" AutoGenerateColumns="false" CellSpacing='0' Width='100%'>
                                    <Columns>
                                        <asp:TemplateField HeaderText="Productos">
                                            <ItemTemplate>
                                                <div style="box-shadow: rgba(50, 50, 105, 0.15) 0px 2px 5px 0px, rgba(0, 0, 0, 0.05) 0px 1px 1px 0px; margin: 1px; padding: 0 4px;">
                                                    <div style="width: 170px; height: 260px;"> <%--  class="img_producto" --%>
                                                        <div>
                                                            <div style="text-align: center;">
                                                                <img src="<%#Eval("ruta_imagen")%>" width="150" height="150" alt="">
                                                                <%--<img style="max-height: 200px;" class="activator img_producto" src="<%#Eval("ruta_imagen_2")%>" descripcion="<%#Eval("descripcion")%>" id="<%#Eval("id")%>" nombre="<%#Eval("nombre")%>" precio="<%#Eval("precio")%>" categoria="<%#Eval("categoria")%>" /><img style="max-height: 200px;" class="activator img_producto" src="<%#Eval("ruta_imagen_3")%>" descripcion="<%#Eval("descripcion")%>" id="<%#Eval("id")%>" nombre="<%#Eval("nombre")%>" precio="<%#Eval("precio")%>" categoria="<%#Eval("categoria")%>" />--%>
                                                            </div>
                                                            <div>
                                                                <a href="#"><%#Eval("nombre")%> <b><%#Eval("categoria")%></b></a>
                                                                <div>
                                                                    <span>Envío gratis</span>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div>
                                                        <!-- BOTON AGREGAR MAS Y PRECIO -->
                                                        
                                                        <span id='btn_comprar' url='Grilla_carrito.aspx'
                                                            obj_id='<%#Eval("id")%>'
                                                            img="<%#Eval("ruta_imagen")%>"
                                                            art_id="<%#Eval("id")%>"
                                                            precio="<%#Eval("precio")%>"
                                                            class="btn_mas_shopStore"
                                                            onclick='agregar_al_carrito_busqueda(this,"Producto agregado Correctamente");'>
                                                            <span style="color: white; padding: 5px 10px; background: #29357d; position: absolute; left: -8px; font-family: cursive; font-size: large;"><b>$</b> <%#Eval("precio")%>.00</span>
                                                            <span class='tooltipped' data-position='right' data-tooltip='Agregar'>
                                                                <!-- IMAGEN MAS -->
                                                                <img class="zoom css_cesta lazy" src="./static/img/cesta4.png" style="width: 35px;" />
                                                            </span>
                                                        </span>
                                                    </div>
                                                </div>

                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                </asp:GridView>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </div>

                </div>


            </div>


            <audio class="pip">
                <source src="static/audio/pip.mp3" type="audio/mp3">
            </audio>

            <audio class="click">
                <source src="static/audio/click.mp3" type="audio/mp3">
            </audio>

            <audio class="monedas">
                <source src="static/audio/monedas.mp3" type="audio/mp3">
            </audio>

            <audio class="cbo">
                <source src="static/audio/cbo.mp3" type="audio/mp3">
            </audio>


        </form>


    </div>
    <br />

    <style>
        .btn_menu_mobile nav ul a:hover {
           border-radius: 5px !important;
           background: #e9eaf2 !important;
        }
        .btn_mas_shopStore {
            display: flex;
            justify-content: end;
            position: relative;
            right: 5px;
            bottom: 5px;
        }

        .popup_big {
            width: 60vw !important;
        }

        .swal2-popup {
            width: 60vw !important;
        }

        .btn_categoria_buscar {
            background: #29357d !important;
            min-width: 170px;
            cursor: pointer;
            box-shadow: rgba(0, 0, 0, 0.4) 0px 2px 4px, rgba(0, 0, 0, 0.3) 0px 7px 13px -3px, rgba(0, 0, 0, 0.2) 0px -3px 0px inset;
        }

            .btn_categoria_buscar:hover {
                background: #394589 !important;
                box-shadow: rgba(0, 0, 0, 0.16) 0px 3px 6px, rgba(0, 0, 0, 0.23) 0px 3px 6px;
            }

        .menu-fixed {
            z-index: 2;
            position: fixed;
            top: 3em;
        }

        .striped tbody {
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
            background: #f8f8f8;
            padding: 30px 0;
        }

        #nav_pages {
            display: none; /*SUB NAV de MASTER DESACTIVADA */
        }

        .center_cestas {
            display: flex;
            justify-content: center;
            flex-direction: column-reverse;
            text-align: center;
        }

        #btn_comprar {
            cursor: pointer;
        }

        .css_cesta:hover {
            transform: scale(1.3);
        }

        .articulos_card:hover {
            cursor: pointer;
        }

        .owl-stage {
            transform: scale(1.2);
        }

        .breadcrumb:before {
            display: none;
        }

        .phone td:nth-child(1) {
            display: none
        }

        .phone th:nth-child(1) {
            display: none;
        }

        .chat {
            width: 100%;
            height: 350px;
            padding: 15px;
            overflow: auto;
        }

        .textoEnviado {
            position: relative;
            top: 0px;
            width: fit-content;
            left: 0px;
            background: #dcf8c6;
            border-radius: 25px;
            box-shadow: 2px 2px 2px;
            padding-right: 15px;
            padding-left: 15px;
        }

        .css_precio:hover {
            -webkit-animation-name: rubberBand;
            animation-name: rubberBand;
            -webkit-animation-duration: 1s;
            animation-duration: 1s;
            -webkit-animation-fill-mode: both;
            animation-fill-mode: both;
        }

        @-webkit-keyframes rubberBand {
            0% {
                -webkit-transform: scale3d(1, 1, 1);
                transform: scale3d(1, 1, 1);
            }

            30% {
                -webkit-transform: scale3d(1.25, 0.75, 1);
                transform: scale3d(1.25, 0.75, 1);
            }

            40% {
                -webkit-transform: scale3d(0.75, 1.25, 1);
                transform: scale3d(0.75, 1.25, 1);
            }

            50% {
                -webkit-transform: scale3d(1.15, 0.85, 1);
                transform: scale3d(1.15, 0.85, 1);
            }

            65% {
                -webkit-transform: scale3d(.95, 1.05, 1);
                transform: scale3d(.95, 1.05, 1);
            }

            75% {
                -webkit-transform: scale3d(1.05, .95, 1);
                transform: scale3d(1.05, .95, 1);
            }

            100% {
                -webkit-transform: scale3d(1, 1, 1);
                transform: scale3d(1, 1, 1);
            }
        }

        @keyframes rubberBand {
            0% {
                -webkit-transform: scale3d(1, 1, 1);
                transform: scale3d(1, 1, 1);
            }

            30% {
                -webkit-transform: scale3d(1.25, 0.75, 1);
                transform: scale3d(1.25, 0.75, 1);
            }

            40% {
                -webkit-transform: scale3d(0.75, 1.25, 1);
                transform: scale3d(0.75, 1.25, 1);
            }

            50% {
                -webkit-transform: scale3d(1.15, 0.85, 1);
                transform: scale3d(1.15, 0.85, 1);
            }

            65% {
                -webkit-transform: scale3d(.95, 1.05, 1);
                transform: scale3d(.95, 1.05, 1);
            }

            75% {
                -webkit-transform: scale3d(1.05, .95, 1);
                transform: scale3d(1.05, .95, 1);
            }

            100% {
                -webkit-transform: scale3d(1, 1, 1);
                transform: scale3d(1, 1, 1);
            }
        }



        .img_carrito:hover {
            cursor: none;
            animation: shake 0.82s cubic-bezier(.36,.07,.19,.97) both;
            transform: translate3d(0, 0, 0);
            backface-visibility: hidden;
            perspective: 1000px;
        }

        @keyframes shake {
            10%, 90% {
                transform: translate3d(-1px, 0, 0);
            }

            20%, 80% {
                transform: translate3d(2px, 0, 0);
            }

            30%, 50%, 70% {
                transform: translate3d(-4px, 0, 0);
            }

            40%, 60% {
                transform: translate3d(4px, 0, 0);
            }
        }

        .cantidad_cesta {
        }

            .cantidad_cesta:hover {
                transform: scale(1.2);
                cursor: none;
            }

        .grid-container {
            display: flex;
            flex-wrap: wrap;
            gap: 15px;
            padding: 10px;
            overflow: auto;
        }

        .compartir_store {
            cursor: pointer;
        }


        @media screen and (max-width: 600px) {
            .logo_inicio {
                width: 70vw !important;
                margin-top: 50px;
            }

            .articulos_card {
                width: 100% !important;
            }

            .btn_categoria_buscar {
                width: 200px;
                margin: 5px auto !important;
                cursor: pointer;
            }

                .btn_categoria_buscar:hover {
                    background: #18b8fd !important;
                    width: 200px;
                    margin: 5px auto !important;
                    box-shadow: rgba(0, 0, 0, 0.16) 0px 3px 6px, rgba(0, 0, 0, 0.23) 0px 3px 6px;
                }

            .swal2-popup {
                width: 95vw !important;
                margin: auto;
            }

            .swal2-image {
                height: 500px !important;
            }
        }

        .owl-stage-outer {
        }

        .owl-carousel:hover {
            -webkit-animation-name: pulse;
            animation-name: pulse;
            -webkit-animation-duration: 1s;
            animation-duration: 1s;
            -webkit-animation-fill-mode: both;
            animation-fill-mode: both;
        }

        @-webkit-keyframes tada {
            0% {
                -webkit-transform: scale3d(1, 1, 1);
                transform: scale3d(1, 1, 1);
            }

            10%, 20% {
                -webkit-transform: scale3d(.9, .9, .9) rotate3d(0, 0, 1, -3deg);
                transform: scale3d(.9, .9, .9) rotate3d(0, 0, 1, -3deg);
            }

            30%, 50%, 70%, 90% {
                -webkit-transform: scale3d(1.1, 1.1, 1.1) rotate3d(0, 0, 1, 3deg);
                transform: scale3d(1.1, 1.1, 1.1) rotate3d(0, 0, 1, 3deg);
            }

            40%, 60%, 80% {
                -webkit-transform: scale3d(1.1, 1.1, 1.1) rotate3d(0, 0, 1, -3deg);
                transform: scale3d(1.1, 1.1, 1.1) rotate3d(0, 0, 1, -3deg);
            }

            100% {
                -webkit-transform: scale3d(1, 1, 1);
                transform: scale3d(1, 1, 1);
            }
        }

        @keyframes tada {
            0% {
                -webkit-transform: scale3d(1, 1, 1);
                transform: scale3d(1, 1, 1);
            }

            10%, 20% {
                -webkit-transform: scale3d(.9, .9, .9) rotate3d(0, 0, 1, -3deg);
                transform: scale3d(.9, .9, .9) rotate3d(0, 0, 1, -3deg);
            }

            30%, 50%, 70%, 90% {
                -webkit-transform: scale3d(1.1, 1.1, 1.1) rotate3d(0, 0, 1, 3deg);
                transform: scale3d(1.1, 1.1, 1.1) rotate3d(0, 0, 1, 3deg);
            }

            40%, 60%, 80% {
                -webkit-transform: scale3d(1.1, 1.1, 1.1) rotate3d(0, 0, 1, -3deg);
                transform: scale3d(1.1, 1.1, 1.1) rotate3d(0, 0, 1, -3deg);
            }

            100% {
                -webkit-transform: scale3d(1, 1, 1);
                transform: scale3d(1, 1, 1);
            }
        }

        .sorting_1 {
            background-color: #f8f8f8;
            display: flex !important;
            justify-content: center;
        }


        @-webkit-keyframes shaker {
            0% {
                -webkit-transform: translate(2px, 0);
            }

            50% {
                -webkit-transform: translate(-2px, 0);
            }

            100% {
                -webkit-transform: translate(2px, 0);
            }
        }

        .shake {
            -webkit-animation-name: shaker;
            -webkit-animation-duration: 0.2s;
            -webkit-transform-origin: 50% 50%;
            -webkit-animation-timing-function: linear;
        }
        /*th,td{
    padding: 0px 5px 0px 0px !important;
}*/
        .td_virtual_phone {
        }

        .fila_table {
            height: 70px !important;
            display: flex;
            align-items: center;
            border-bottom: ridge;
        }

        .enviar_whatsapp {
            position: relative;
            height: 95px;
            border-radius: 80px;
            width: 95px;
            top: 25px;
            box-shadow: rgb(0 0 0 / 40%) 0px 2px 4px, rgb(0 0 0 / 30%) 0px 7px 13px -3px, rgb(0 0 0 / 20%) 0px -3px 0px inset;
            background: white;
            margin: auto;
        }

            .enviar_whatsapp:hover {
                transform: scale(1.05);
                box-shadow: rgba(0, 0, 0, 0.09) 0px 2px 1px, rgba(0, 0, 0, 0.09) 0px 4px 2px, rgba(0, 0, 0, 0.09) 0px 8px 4px, rgba(0, 0, 0, 0.09) 0px 16px 8px, rgba(0, 0, 0, 0.09) 0px 32px 16px;
            }


        .input_cant_tel_virtual:hover {
            transform: scale(1.05)
        }

        .flecha_arriba {
            cursor: pointer
        }

        .flecha_arriba {
            transform: scale(1.05)
        }

        .flecha_abajo {
            cursor: pointer
        }

            .flecha_abajo:hover {
                transform: scale(1.05)
            }
    </style>

</asp:Content>

<asp:Content runat="server" ContentPlaceHolderID="contenido_js">
    <script type="text/javascript">


        function phone_fixed() {
            var width_screen
            var altura = $('.phone_contender').offset().top;
            altura = altura + 1
            $(window).on('scroll', function () {
                width_screen = $(screen.width)
                if ($(window).scrollTop() > altura && width_screen[0] > 600) {
                    $('.phone_contender').addClass('menu-fixed');
                    $('.phone_contender').removeClass('flipInY');
                    $('.phone_contender').addClass('pulse');
                } else {
                    $('.phone_contender').removeClass('menu-fixed');
                    $('.phone_contender').removeClass('pulse');
                }
            });
        }

        function flecha_arriba(obj) {
            var tag = $(obj).parent().parent().children()
            var val = tag[1].value
            var suma = parseInt(val) + 1
            $(tag[1]).val(suma).change()
        }
        function flecha_abajo(obj) {
            var tag = $(obj).parent().parent().children()
            var val = tag[1].value
            var resta = parseInt(val) - 1
            if (resta == 0) {
                resta = 1
            }
            $(tag[1]).val(resta).change()
        }

        //btn_menu_mobile
        $('document').ready(function () {


            //phone_fixed()
            $('.img_open').hide();
            $('.footer').show();
            $('.phone').show();

            //'setInterval(mover_cartelito, 15000)
            //$("div").find("li").css("z-index", 2147483647).remove();

            function mover_cartelito() {
                $('.img_open').addClass("swing");
                var delay = setTimeout(function () {
                    $(".swing").removeClass("swing");
                }, 3000)
            }

            $(".owl-carousel").owlCarousel({
                nav: false,
                slideBy: 1,
                items: 1,
                loop: true,
                autoplay: true,
                autoplayTimeout: 7000,
                autoplayHoverPause: true
            });

            $('.img_producto').click(function () {

                var img = this
                //var popup = $(img).closest(".swal2-popup")
                //console.log(popup[0])
                //$(popup).addClass('popup_big')

                var img_nombre = $(img).attr("nombre")
                var img_desc = $(img).attr("descripcion")
                var img_preio = $(img).attr("precio")
                var img_categoria = $(img).attr("categoria")
                var img_src = $(img).attr("src")
                show_image(img_nombre, "Incluye: " + img_desc, img_src)
            })


            $('.card_producto').click(function () {
                var obj = this
                //console.log(obj)
                var id = $(obj).attr("id")
                var nombre = $(obj).attr("nombre")
                var categoria = $(obj).attr("categoria")
                var descripcion = $(obj).attr("descripcion")
                var precio = $(obj).attr("precio")
                var img1 = $(obj).attr("img1")
                var img2 = $(obj).attr("img2")
                var img3 = $(obj).attr("img3")

            })

            sessionStorage.clear()


            $('.grid-container').show(350)
            $('.tabs').tabs();

            var selector = $('.stripedShopStore')
            inicializar_grilla(selector);



            $('.compartir_store').click(function () {
                compartir_tienda_por_wpp("https://w340207.ferozo.com/projectos/shopStore.aspx")
            })


            $('.agregar_al_carrito').click(function () {
                var _articulo = this.parentElement.parentElement.parentElement
                //console.log(_articulo)
                var art_id = $(_articulo).attr("art_id")
                var precio = $(_articulo).attr("precio")
                var img = $(_articulo).attr("img")
                var articulo = {
                    articulo: art_id,
                    cantidad: 1,
                    precio: precio,
                    img: img
                }
                var carrito = sessionStorage.getItem("carrito")
                if (carrito == null || carrito == "null" || carrito == "") {
                    carrito = []
                } else {
                    carrito = JSON.parse(carrito)
                }
                carrito.push(articulo)

                dibujar_articulos_en_telefono_virtual(carrito)
                sessionStorage.carrito = JSON.stringify(carrito)
                calcular_total()
                //vaciar_inputs()
                //$('#contenido_body_cbo_buscador_articulos').val("-1").change()
                $('.click').prop("volume", 0.3);
                $(".click")[0].play();
            })


            $('.enviar_whatsapp').click(function () {
                var carrito = sessionStorage.getItem("carrito")
                carrito = JSON.parse(carrito)
                if (carrito == null || carrito == "null" || carrito == "") {
                    show_alert("Tu carrito de pedidos esta vacío", "Agregá productos al carrito", "error")
                    return false
                }
                Swal.fire({
                    title: '<strong>Completá tu pedido</strong>',
                    html: celular_interfaz,
                    showCloseButton: false,
                    showCancelButton: true,
                    focusConfirm: false,
                    confirmButtonText: 'Enviar Pedido',
                    cancelButtonText: 'Cancelar',
                }).then((result) => {
                    if (result.isConfirmed) {
                        //VARIABLES DE POPUP
                        var info_pedido = []
                        var nombre_cliente = $('.class_txt_nombre').val()
                        var celular = $('.class_txt_celular').val()
                        var calle = $('.class_txt_calle').val()
                        var calle_numero = $('.class_txt_calle_numero').val()
                        var lever = $('.lever').val()

                        //PREGUNTA DATOS DE CONTACTO EN POPUP
                        if (lever == "domicilio") {
                            if (nombre_cliente == "" || celular == "" || calle == "" || calle_numero == "") {
                                Swal.fire('¡Pedido Incompleto!', 'Completá los campos vacios.', 'error')
                                return false
                            }
                        }
                        if (lever == "local") {
                            if (nombre_cliente == "" || celular == "") {
                                Swal.fire('¡Pedido Incompleto!', 'Completá los campos vacios.', 'error')
                                return false
                            }
                        }
                        //CARGA RESPUESTAS EN INFO PEDIDO
                        info_pedido.push(nombre_cliente)
                        info_pedido.push(celular)
                        info_pedido.push(calle)
                        info_pedido.push(calle_numero)
                        //REGISTA COMPRA/PEDIDO
                        registrar_pedido(carrito, info_pedido)
                        
                    } else if (result.isDenied) {
                        Swal.fire('No se realizo el pedido', '', 'warning')
                    } else if (result.dismiss == 'cancel') {
                        Swal.fire('Cancelado', '', 'success')
                    }
                    //aca termino el swal

                })

            })

            //jueves18   
            $(".btn_categoria_buscar").click(function () {
                var obj = this
                var categoria_a_buscar = $(obj).attr("cat")
                $('input[type="search"]').val(categoria_a_buscar).keyup();
            })
            // Wrapea las cajas de los productos en la table
            $('#contenido_body_GV_shopStore tbody').css({
                'display': 'flex',
                'flex-wrap': 'wrap',
                'margin-left': '10px',
                'justify-content': 'space-around',

            });


            // Cargar las imágenes visibles al cargar la página
            lazyLoad();

            // Cargar imágenes al hacer scroll
            $(window).scroll(function () {
                lazyLoad();
            });
        });// fin doc ready

        function reiniciar_phone_para_nuevas_compras() {
            sessionStorage.setItem("carrito", null)
            $('.cantidad_cesta').html(0)
            $('.total').text('$0');
            $('td[tot]').attr('tot', 0)
            $('td[tot]').html("$0")
        }

        function agregar_al_carrito_busqueda(datos) {
            var _articulo = datos
            var art_id = $(_articulo).attr("art_id")
            var precio = $(_articulo).attr("precio")
            var img = $(_articulo).attr("img")

            var articulo = {
                articulo: art_id,
                cantidad: 1,
                precio: precio,
                img: img
            }
            var carrito = sessionStorage.getItem("carrito")
            if (carrito == null || carrito == "null" || carrito == "") {
                carrito = []
            } else {
                carrito = JSON.parse(carrito)
            }
            // si el articulo ya existe en el changuito
            
            if (si_ya_existe_el_articulo_en_el_carrito(carrito, articulo) == false) {
                return
            }

            //
            carrito.push(articulo)//meto el articulo en el carrito
            dibujar_articulos_en_telefono_virtual(carrito)
            sessionStorage.carrito = JSON.stringify(carrito)
            calcular_total()
            //vaciar_inputs()
            //$('#contenido_body_cbo_buscador_articulos').val("-1").change()
            $('.click').prop("volume", 0.3);
            $(".click")[0].play();
            animaciones_al_agregar_producto()
            guardar_en_articulos_visitados(art_id)
        }

        function guardar_en_articulos_visitados(art_id) {
            $.ajax({
                type: "POST",
                url: "shopStore.aspx/articulo_visitado",
                data: '{art_id: "' + art_id + '" }',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {}
            });
        }

        function si_ya_existe_el_articulo_en_el_carrito(carrito, articulo) {
            var art_id
            for (i = 0; i <= carrito.length; i++) {
                if (carrito[i]) {
                    //console.log("comparacion: ",articulo.articulo, carrito[i].articulo)
                    if (articulo.articulo == carrito[i].articulo) {

                        console.log("este articulo ya esta en el carrito")
                        art_id = articulo.articulo
                        //const index = carrito.find(art_id);
                        //console.log("index: ",index)
                        sumar_producto_existente_al_carrito(carrito, articulo.articulo)
                        //calcular_total()
                        $('.click').prop("volume", 0.3);
                        $(".click")[0].play();
                        dibujar_articulos_en_telefono_virtual(carrito)
                        animaciones_al_agregar_producto()
                        return false
                    }
                }
            }

        }

        function sumar_producto_existente_al_carrito(carrito, art_id) {
            var indice = carrito.findIndex(articulo => articulo.articulo === art_id);
            var cantidad_del_articulo = carrito[indice].cantidad
            carrito[indice].cantidad = cantidad_del_articulo + 1
            sessionStorage.carrito = JSON.stringify(carrito)
            calcular_total_celular()
            return true
        }


        function modificar_cantidad_al_carrito(carrito, art_id, cantidad) {
            var indice = carrito.findIndex(articulo => articulo.articulo === art_id);
            carrito[indice].cantidad = parseInt(cantidad)
            sessionStorage.carrito = JSON.stringify(carrito)
            calcular_total_celular()
            return true
        }



        function animaciones_al_agregar_producto() {
            $('.img_carrito').addClass("tada");
            var delay = setTimeout(function () {
                $(".tada").removeClass("tada");
            }, 1000)

            $('.phone').addClass("pulse");
            var delay = setTimeout(function () {
                $(".pulse").removeClass("pulse");
            }, 1000)

            $('.phone_productos').addClass("zoomIn");
            var delay = setTimeout(function () {
                $(".zoomIn").removeClass("zoomIn");
            }, 1000)

            $('.cantidad_cesta_nav').addClass("flipInX");
            var delay = setTimeout(function () {
                $(".flipInX").removeClass("flipInX");
            }, 1000)


            $('.img_wp').addClass("rubberBand");
            var delay = setTimeout(function () {
                $(".rubberBand").removeClass("rubberBand");
            }, 1000)
        }
        function calcular_total() {
            var carrito = sessionStorage.getItem("carrito")
            carrito = JSON.parse(carrito)
            //console.log(carrito.length, carrito)
            var total = 0
            for (i = 0; i < carrito.length; i++) {
                total = total + (parseInt(carrito[i].precio) * parseInt(carrito[i].cantidad))
            }
            $('.total').html('$' + total + '.00')
        }

        function donde_retira() {
            $('.txt_calle').toggle(500)
            $('.txt_calle_numero').toggle(500)
            $('.lever').val("domicilio")

        }


        function enviar_whatsapp(msg) {
            var msgEnChat = ""
            msg = msg.split(" ").join("%20");
            //console.log(msg);
            var href = 'https://api.whatsapp.com/send?phone=54' +<%=numero_whatsapp%>+'&text='
            href = href + msg;
            //console.log(href)
            $('#whatsappMsg').attr('href', href);
            $('.waMsg').val('');
            $("<p class='textoEnviado'>" + msgEnChat + "</p>").appendTo(".chat");
            var a = document.createElement('a');
            a.target = '_blank';
            a.href = href;
            a.click();
        }

        function compartir_tienda_por_wpp(msg) {
            var msgEnChat = ""
            msg = msg.split(" ").join("%20");
            console.log(msg);
            var href = 'https://api.whatsapp.com/send?text='
            href = href + msg;
            console.log(href)
            $('#whatsappMsg').attr('href', href);
            $('.waMsg').val('');
            $("<p class='textoEnviado'>" + msgEnChat + "</p>").appendTo(".chat");
            var a = document.createElement('a');
            a.target = '_blank';
            a.href = href;
            a.click();
            //settimeout(location.href = 'shop.aspx',5000)
        }



        function vaciar_carrito() {
            Swal.fire({
                title: '¿Querés vaciar el carrito?',
                showDenyButton: true,
                showCancelButton: false,
                confirmButtonText: 'SI',
                denyButtonText: `NO`,
                confirmButtonColor: 'black',
            }).then((result) => {
                /* Read more about isConfirmed, isDenied below */
                if (result.isConfirmed) {
                    $('.tbody_refresh').html("")
                    var carrito = []
                    sessionStorage.carrito = JSON.stringify(carrito)
                    $('td[sub]').attr('sub', 0)
                    $('td[tot]').attr('tot', 0)
                    $('td[sub]').html("$0")
                    $('td[tot]').html("$0")
                    $('.cantidad_cesta').html(0)
                    $('.cbo').prop("volume", 0.3);
                    $(".cbo")[0].play();
                    return true
                } else if (result.isDenied) {
                    return false
                }
            })
        }



        function dibujar_articulos_en_telefono_virtual(carrito) { //TDs DIBUJADOS ACA
            cantidad_cesta(carrito)
            //console.log(carrito.length, carrito)
            $('.tbody_refresh').html("")
            for (i = 0; i < carrito.length; i++) {
                //console.log("dibujando..."+i, carrito[i])
                $('.tbody_refresh').append("<tr class='fila_table'><td class='td_virtual_phone'>" + carrito[i].articulo + "</td><td style='width: 70px;' class='td_virtual_phone'><div style='display:flex;'><div class='flechas' style='display: flex; flex-direction: column; position: relative; left: -5px; top: -1px;'><img class='flecha_arriba' onclick='flecha_arriba(this)' style='filter: grayscale(1);width:25px;transform: rotateZ(90deg);margin:3px 0' src='static/img/arrow.png' /><img class='flecha_abajo' onclick='flecha_abajo(this)' style='filter: grayscale(1);width:25px;transform: rotateZ(270deg)' src='static/img/arrow.png' /></div><input style='border-bottom: 0px; width: 60px; font-size: 30px; text-align: center; font-family: bangers; position: relative; top: 7px; color: #383838; left: -10px; cursor:pointer' type='number' art_id='" + carrito[i].articulo + "' precio_unitario='" + carrito[i].precio + "' onChange='telefono_virtual_actualizar_precio_respecto_a_cantidad(this)' value='" + carrito[i].cantidad + "' readOnly/></div></td><td class='articulo_de_telefono_virtual td_virtual_phone' art_id='" + carrito[i].articulo + "' precio_unitario='" + carrito[i].precio + "'img='" + carrito[i].img + "' cantidad='" + carrito[i].cantidad + "' onclick='quitar_producto_de_celular(this)'><img class='img_producto_telefono_virtual' src='" + carrito[i].img + "' class='table_ruta_imagen' id='txt_ruta_imagen'/></td><td class='td_virtual_phone'><span style='color: #383838; position: relative; font-size: 20px; font-weight: 500; }'>$" + carrito[i].precio + ".00</span></td></tr>")
            }
        }
        




        function telefono_virtual_actualizar_precio_respecto_a_cantidad(obj) {
            var input_cantidad = obj
            var cantidad = $(input_cantidad).val()
            var precio_unitario = $(input_cantidad).attr("precio_unitario")
            var art_id = $(input_cantidad).attr("art_id")

            var carrito = sessionStorage.getItem("carrito")
            carrito = JSON.parse(carrito)

            modificar_cantidad_al_carrito(carrito, art_id, cantidad)
            $('.click').prop("volume", 0.3);
            $(".click")[0].play();
            dibujar_articulos_en_telefono_virtual(carrito)
            animaciones_al_agregar_producto()

        }

        function registrar_pedido(carrito, info_pedido) {

            var articulos = []
            var monto = 0
            var suma
            var res
            for (i = 0; i < carrito.length; i++) {
                articulos.push(carrito[i].articulo)
                articulos.push(carrito[i].cantidad)
                suma = carrito[i].precio * carrito[i].cantidad
                monto = monto + suma
            }
            articulos.push(info_pedido[0])// le sumo el monto al final del array para registrar la compra
            articulos.push(info_pedido[1])// le sumo el monto al final del array para registrar la compra
            articulos.push(info_pedido[2])// le sumo el monto al final del array para registrar la compra
            articulos.push(info_pedido[3])// le sumo el monto al final del array para registrar la compra
            articulos.push(monto)// le sumo el monto al final del array para registrar la compra
            //console.log("articulos", articulos)
            articulos = articulos.toString()

            //console.log(articulos)
            $.ajax({
                type: "POST",
                url: "shopStore.aspx/registrar_pedido",
                data: '{articulos: "' + articulos + '" }',
                async: false,
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    if (response) {
                        if (response.d) {
                            var redaccion = []
                            //console.log("QQQ", response.d)
                            redaccion = response.d.split("|")
                            //console.log(redaccion)
                            enviar_whatsapp(redaccion[1])

                            $('.monedas').prop("volume", 0.3);
                            $(".monedas")[0].play();
                            $('.tbody_refresh').html("")
                            var carrito = []
                            sessionStorage.carrito = JSON.stringify(carrito)
                            procesar_toast("Venta n°" + redaccion[0] + " registrada", "success")
                            reiniciar_phone_para_nuevas_compras()
                            show_alert_confirmCompra()
                        }
                        return false
                    }
                }
            });
        }


        var celular_interfaz = `
            <br/>
            <div class="css_swal_container">
              <div class ="switch">
                <label style="display:flex;justify-content: center;">
                  <div style="display: flex; flex-direction: column; align-items: center;">
                  <img src="./static/img/local.png" width="50px">
                  <span>Retiro en el Local</span>
                  </div>
                  <input type="checkbox" class="lever" value="local" onChange="donde_retira(this)">
                  <span class ="lever" style="position: relative; top: 20px; left: -10px;"></span>
                  <div style="display: flex; flex-direction: column; align-items: center;">
                  <img src="./static/img/domicilio.png" width="50px">
                  <span>Pedido a domicilio</span>
                  </div>

                </label>

            </div>

            <br/>
            <br/>

            <div>
                <div style="display:flex; flex-wrap:wrap;justify-content:space-around;width: 200px;margin: auto; ">
                    <div class ="txt_calle" style="display:none">
                    <label for="txt_calle">Calle: </label>
                    <input type="text" id="txt_calle" class ="class_txt_calle"/>
                    </div>
                    <div class ="txt_calle_numero" style="display:none">
                    <label for="txt_calle_numero">Número: </label>
                    <input type="number" id="txt_calle_numero" class ="class_txt_calle_numero"/>
                    </div>
                    <div class ="txt_celular">
                    <label for="txt_celular">Celular: </label>
                    <input type="number" id="txt_celular" class ="class_txt_celular"/>
                    </div>
                    <div class ="txt_nombre">
                    <label for="txt_nombre">Nombre: </label>
                    <input type="text" id="txt_nombre" class ="class_txt_nombre"/>
                    </div>
                 </div>
            </div>
            </div>
            <br/>
            `


    </script>
</asp:Content>
