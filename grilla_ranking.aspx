<%@ Page Language="VB" AutoEventWireup="false" MasterPageFile="~/master.master" CodeFile="grilla_ranking.aspx.vb" Inherits="grilla_ranking" %>

<asp:Content runat="server" ContentPlaceHolderID="contenido_nav">
    <a href="supervisor_index.aspx" class="breadcrumb">INICIO</a>
    <a href="#" class="breadcrumb ACTIVE">Ranking</a>
</asp:Content>

<asp:Content runat="server" ContentPlaceHolderID="contenido_body">

    <h1 style="text-align:center">RANKING</h1>
    <p class="center">Aquí verás los artículos mas vendidos ordenados por categoría</p>
        <div >


        <form id="Form_fv_empresas" runat="server">

                    <asp:ScriptManager runat="server" ID="ScriptManager_grilla_emp"></asp:ScriptManager>
                    <asp:HiddenField id="hi_input" runat="server" Value="" />
                                          
                                    <div id="tab_consultas" >
                                    <div class="contender_carrito" style="position: absolute; top: 17vh; right: 15vw;">
                                        <img src="./static/img/ranking.png" class="img_carrito bounce" style="width: 80px;"/>
                                    </div>
                                        <!---->
                                        <div style="margin:20px">
                                            <div class="card" style="min-height:70vh;padding: 30px;">
                                                    <div style="display:flex;">
                                                    <div class="contenedor_filtros" style="display: flex;margin: auto;flex-wrap: wrap;">
                                                        <div class="inputs_filtros_css" >
                                                            <label for="cbo_categoria" class="cbo_categoria" style="min-width: 90px;margin: 8px;position: relative;top: 5px;">Categoría:</label>
                                                            <div style="position:relative;top:17px">
                                                                <asp:DropDownList runat='server' ID='cbo_categoria' type='text' class='form-control input-md' style="min-width:50px;" MaxLength='200' />
                                                            </div>
                                                        </div>

                                                    <asp:UpdatePanel ID="panel_btn_filtrar" runat="server" UpdateMode="Conditional">
                                                        <ContentTemplate>
                                                            <asp:Button AutoPostBack="true" style="margin: 20px; position: relative; top: 22px; height: 34px;" ID="btn_filtrar" runat="server" name="btn_filtrar" CssClass="btn btn-primary btn_filtrar" Text="Consultar" />
                                                        </ContentTemplate>
                                                    </asp:UpdatePanel>
                                                      </div>
                                                </div>
                                                <br />
                                                    <asp:UpdatePanel ID="panel_ranking" runat="server" style="width: 50%;margin: auto;min-width: 380px;" UpdateMode="Conditional">
                                                    <ContentTemplate>
                                                       <% If tabla_vacia = True Then %>
                                                        <div>
                                                            <%= tabla %>
                                                        </div>
                                                        <%End if %>
                                                    <ASP:GridView ID ="GV_ranking" runat="server" class="table" AutoGenerateColumns="false"  CellSpacing='0' Width='100%'>
                                                        <Columns>
                                                           <ASP:BoundField DataField = "Puesto" htmlencode="false" HeaderText="PUESTO" />
                                                           <ASP:BoundField DataField = "producto" htmlencode="false" HeaderText="PRODUCTO" />
                                                           <ASP:BoundField DataField = "cantidad" htmlencode="false" HeaderText="CANTIDAD VENDIDA" />
                                                        </Columns>
                                                     </asp:GridView>
                                                     <!---->
                                                     </ContentTemplate>
                                                        <Triggers>
                                                        <asp:AsyncPostBackTrigger ControlID="btn_filtrar" EventName="Click" />
                                                        </Triggers>
                                                     </asp:UpdatePanel>
                                            </div>
                                        </div>
                                        <br />
                                        <!---->


                                    </div> <%-- fin tab--%>
            
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
        <br /><br /><br />


        </div>

    <style>
        .select2-selection select2-selection--single{
            position:relative;
            top:15px !important;
        }
        .inputs_filtros_css{
            margin: 8px 8px;
            max-width: 50%;
            min-width: 10vw;
        }

        .cantidad_cesta:hover{
            transform: scale(1.2);
            cursor:none;
        }
        #DataTables_Table_0_filter{
            display:none;
        }
        .combos_articulos{
            display: flex;
            width: 100vw;
        }
        td{
            text-align:center;
        }
        th{
            text-align:center;
        }


        .fila_table:hover{
        background: #8080801f;
        color: black;
        font-weight: 700;
        font-size: 18px;
        cursor:pointer;
        }
        .total:hover {
        background: #8080801f;
        color: black;
        font-weight: 700;
        cursor:none;
        }
        video{
            max-width:100%;
        }
        canvas.drawing, canvas.drawingBuffer {
            position: relative;
            right: 0px;
            top: -22vh;
            width: 100%;
        }
        #scanner-container{
            height:20vh;
        }
        .select-wrapper input.select-dropdown{
            display:none !important;
        }

        .img_carrito:hover {
            cursor:none;
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

    </style>
</asp:Content>


<asp:Content runat="server" ContentPlaceHolderID="contenido_js">
    <script type="text/javascript">
        $('document').ready(function () {
            
 


            function refresh_filter() {
                var selector = $('.table')
                inicializar_grilla_asc(selector);
            }
            refresh_filter()


            $('#contenido_body_cbo_buscador_articulos').select2();
            $('#contenido_body_cbo_articulo').select2();
            $('#contenido_body_cbo_categoria').select2();
            $('#contenido_body_cbo_ticket').select2();
            $('#contenido_body_cbo_buscador_articulos').change(function () {
                if (this.value != "-1") {
                    query_articulo_a_db(this.value)
                    $('.cbo').prop("volume", 0.4);
                    $(".cbo")[0].play();

                }
            })

            sessionStorage.clear()
            $('.tabs').tabs();

            //$('td:nth-child(1)').hide()//
            //$('th:nth-child(1)').hide()//borro primera columna


            $('.vaciar').click(function () {
                vaciar_carrito()
            })


            $('.escanear').click(function () {
                var codigo_barra = $('.txt_codigo').val()
                if (codigo_barra != "") {
                query_articulo_a_db(codigo_barra)
                $('#contenido_body_cbo_buscador_articulos').val("-1").change()
                $('.pip').prop("volume", 0.3);
                $(".pip")[0].play();
                }
            })

            $('.ingresar').click(function () {
                var carrito = sessionStorage.getItem("carrito")
                if (carrito == null || carrito == "" || carrito == undefined) {
                return false
                } else {
                    carrito = JSON.parse(carrito)
                    registrar_compra(carrito)
                }
                
            })
            
            $('.agregar_al_carrito').click(function () {
                var articulo = {
                    articulo: $('.txt_articulo').val(),
                    descripcion: $('.txt_descripcion').val(),
                    cantidad: $('.txt_cantidad').val(),
                    tamaño: $('.txt_tamaño').val(),
                    categoria: $('.txt_categoria').val(),
                    color: $('.txt_color').val(),
                    ruta_imagen: $('.txt_ruta_imagen').attr("src"),
                    precio: $('.txt_precio').val(),
                    codigo_barra: $('.txt_codigo_de_barra').val()
                }
                var q = $('.txt_codigo_de_barra').val()
                if (articulo.articulo == "") {
                    show_alert("No hay Artículos Escaneados", "Selecciona un artículo antes de agregarlo", "error")
                    return false
                }

                var carrito = sessionStorage.getItem("carrito")
                if (carrito == null) {
                    carrito = []
                } else {
                    carrito = JSON.parse(carrito)
                }
                carrito.push(articulo)
                
                dibujar_articulos_en_table(carrito)
                sessionStorage.carrito = JSON.stringify(carrito)
                subtotal_y_total(articulo.precio,articulo.cantidad)
                vaciar_inputs()
                $('#contenido_body_cbo_buscador_articulos').val("-1").change()
                $('.click').prop("volume", 0.3);
                $(".click")[0].play();
                $('.img_carrito').addClass("rubberBand");
                var delay = setTimeout(function () {
                    $(".rubberBand").removeClass("rubberBand");
                }, 1000)

                $('.cantidad_cesta').addClass("flipInX");
                var delay = setTimeout(function () {
                    $(".flipInX").removeClass("flipInX");
                }, 1000)

            })


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

            function query_articulo_a_db(codigo_barra) {
                $.ajax({
                    type: "POST",
                    url: "Grilla_caja.aspx/escaneo_codigo_barra",
                    data: '{codigo: "' + codigo_barra + '" }',
                    async: false,
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (response) {
                        if (response.d == "Articulo no Encontrado") {
                            show_alert(response.d, "Vuelve a colocar el codigo de barras", "error")
                            return false
                        }
                        var arr_art = response.d.split("|")
                        var articulo = {
                            articulo: arr_art[0],
                            descripcion: arr_art[1],
                            cantidad: arr_art[2],
                            tamaño: arr_art[3],
                            categoria: arr_art[4],
                            color: arr_art[5],
                            ruta_imagen: arr_art[6],
                            precio: arr_art[7],
                            codigo_barra: arr_art[8]
                        }
                        ver_articulos_en_pantalla(articulo)

                    }
                });
            }

            function registrar_compra(carrito) {
                var articulos = []
                var monto = 0
                var suma
                var res
                for (i = 0; i < carrito.length; i++) {
                    articulos.push(carrito[i].codigo_barra)
                    articulos.push(carrito[i].cantidad)
                    suma = carrito[i].precio * carrito[i].cantidad
                    monto = monto + suma
                }
                articulos.push(monto)// le sumo el monto al final del array para registrar la compra

                articulos = articulos.toString()

                //console.log(articulos)
                $.ajax({
                    type: "POST",
                    url: "Grilla_caja.aspx/registrar_compra",
                    data: '{articulos: "' + articulos + '" }',
                    async: false,
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (response) {
                        if (response) {
                            if (response.d) {
                                $('.monedas').prop("volume", 0.3);
                                $(".monedas")[0].play();
                                $('.tbody_refresh').html("")
                                var carrito = []
                                sessionStorage.carrito = JSON.stringify(carrito)
                                $('td[sub]').attr('sub', 0)
                                $('td[tot]').attr('tot', 0)
                                $('td[sub]').html("$0")
                                $('td[tot]').html("$0")
                                $('.cantidad_cesta').html(0)
                                procesar_toast("Venta n°" + response.d + " registrada", "success")
                            }
                            return false
                        }
                    }
                });
            }
            
            function subtotal_y_total(precio, cantidad) {
                var sub_articulos = $('td[sub]').attr('sub')
                var tot_articulos = $('td[tot]').attr('tot')
                //console.log(sub_articulos,tot_articulos)
                var total_escaneado = (parseInt(precio) * parseInt(cantidad))
                //console.log(total_escaneado)
                var subtotal = parseInt(tot_articulos) + parseInt(total_escaneado)
                var total = parseInt(tot_articulos) + parseInt(total_escaneado)
                //console.log(subtotal,total)
                $('td[sub]').attr('sub', subtotal)
                $('td[tot]').attr('tot', total)
                $('td[sub]').html(subtotal)
                $('td[tot]').html(total)
            }

            function ver_articulos_en_pantalla(articulo) {
                $('.txt_ruta_imagen').attr("src",articulo.ruta_imagen)
                $('.txt_articulo').val(articulo.articulo)
                $('.txt_cantidad').val(1)
                $('.txt_tamaño').val(articulo.tamaño)
                $('.txt_codigo').val(articulo.codigo_barra)
                $('.txt_precio').val(articulo.precio)

                $('.txt_descripcion').val(articulo.descripcion)
                $('.txt_color').val(articulo.color)
                $('.txt_categoria').val(articulo.categoria)
                $('.txt_codigo_de_barra').val(articulo.codigo_barra)
            }
            
            function dibujar_articulos_en_table(carrito) {
                cantidad_cesta(carrito.length)
                //console.log(carrito.length, carrito)
                $('.tbody_refresh').html("")
                for (i = 0; i < carrito.length; i++) {
                    //console.log("dibujando..."+i, carrito[i])
                    $('.tbody_refresh').append("<tr class='fila_table' precio_unitario='" + carrito[i].precio + "' cantidad='" + carrito[i].cantidad + "' codigo_articulo='" + carrito[i].codigo_barra + "' onclick='quitar_producto_de_table(this)'><td><img src='" + carrito[i].ruta_imagen + "' style='width:60px;height:60px;border: 1px solid #dedede;border-radius:5px' class='table_ruta_imagen' id='txt_ruta_imagen'/></td><td>" + carrito[i].articulo + "</td><td>" + carrito[i].cantidad + "</td><td>" + carrito[i].tamaño + "</td><td>" + carrito[i].precio + "</td><td>" + carrito[i].codigo_barra + "</td></tr>")
                }
            }
            
            function vaciar_inputs() {
                $('.txt_ruta_imagen').attr("src", "./static/img/imagen_vacia.png")
                $('.txt_articulo').val("")
                $('.txt_cantidad').val("")
                $('.txt_tamaño').val("")
                $('.txt_codigo').val("")
                $('.txt_precio').val("")

                $('.txt_descripcion').val("")
                $('.txt_color').val("")
                $('.txt_categoria').val("")
                $('.click').prop("volume", 0.3);
                $(".click")[0].play();
            }

            function cantidad_cesta(items) {
                if (items != undefined) {
                    $('.cantidad_cesta').html(items)
                }else{
                var cantidad = sessionStorage.getItem("carrito")
                cantidad = JSON.parse(cantidad)
                console.log("che",cantidad)
                //$('.cantidad_cesta').html(cantidad)
                }
            }


            //function quitar_producto_de_table(tr) {  EN MAIN.JS
       

        on_postback_end(refresh_filter)

        });
     </script>
</asp:Content>