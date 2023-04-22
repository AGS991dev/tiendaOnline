<%@ Page Language="VB" AutoEventWireup="false" MasterPageFile="~/master.master" CodeFile="shop.aspx.vb" Inherits="shop" %>



<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="contenido_body">


    <div class="">
        <br />
        <form runat="server" id="form_login" autocomplete="off">

             <asp:ScriptManager runat="server" ID="ScriptManager_grilla_shop"></asp:ScriptManager>
                <asp:HiddenField id="hi_input" runat="server" Value="" />

            <br />
            <div style="display:flex;justify-content:center;gap:10px">
                <img class="tada logo_inicio" src="./static/img/familiarmente.png" style="width:25vw"/>
            </div>
            <br />
            <br />
                <center>
                    <h5 title="Podés ultimar los detalles de la compra directamente por Whatsapp" style="margin:0 40px;">Agregá productos al carrito y enviá el whatsapp a la tienda con un solo <a href="#enviar_whatsapp" style="text-decoration:none">CLICK</a></h5>
                </center>
            <br />
            <br />
            <div style="display:flex;justify-content:flex-start;flex-wrap:wrap;margin:10px;padding:15px;width:100%">
            <%For Each categoria As String In categorias%>
                    <span style="margin:10px" class="btn btn_categoria_buscar" cat="<%=categoria%>"><%=categoria%></span>
            <%Next%>
            </div>
            <div class="row">
                <div class="col s12 m9 col_table">

                <div id="tab_buscar" >
                
                        <div style="display:none">
                            <div class="combos_empleados">
                            <label for="cbo_estado" class="cbo_estado" style="min-width: 90px;margin: 8px;position: relative;top: 5px;">Producto</label>
                            <asp:DropDownList runat='server' ID='cbo_estado' style="margin:8px;max-width: 50%;min-width: 100px;" type='text' class='form-control input-md' MaxLength='200' />
                            </div>
                            <asp:Button style="margin: 20px;position: relative;top: 5px;" ID="btn_filtrar" runat="server" name="btn_filtrar" OnClientClick="modal_espere_on()" CssClass="btn btn_filtrar btn-info" Text="Buscar" />
                        </div>

                                    <asp:UpdatePanel ID="panel_shop" runat="server" UpdateMode="Conditional">
                                            <ContentTemplate>
                                        <!---->
                                        <ASP:GridView ID ="GV_shop" runat="server" class="striped" AutoGenerateColumns="false"  CellSpacing='0' Width='100%'>
                                        <Columns>
                                           <ASP:TemplateField HeaderText = "Articulos" >
                                                <ItemTemplate>
                                                    <div  style="width: 350px;">
                                                          <div class="card card_producto" style="box-shadow:none !important;margin:10px;" descripcion="<%#Eval("descripcion")%>"  id="<%#Eval("id")%>" nombre="<%#Eval("nombre")%>" precio="<%#Eval("precio")%>" categoria="<%#Eval("categoria")%>"  img1="<%#Eval("ruta_imagen")%>" img2="<%#Eval("ruta_imagen_2")%>" img3="<%#Eval("ruta_imagen_3")%>">
                                                            <div class="card-image waves-effect waves-block waves-light">
                                                                <div class="owl-carousel owl-theme">
                                                                    <img  style="max-height:350px;" class="activator img_producto"  src="<%#Eval("ruta_imagen")%>" descripcion="<%#Eval("descripcion")%>"  id="<%#Eval("id")%>" nombre="<%#Eval("nombre")%>" precio="<%#Eval("precio")%>" categoria="<%#Eval("categoria")%>" />
                                                                    <img  style="max-height:350px;" class="activator img_producto" src="<%#Eval("ruta_imagen_2")%>" descripcion="<%#Eval("descripcion")%>"  id="<%#Eval("id")%>" nombre="<%#Eval("nombre")%>" precio="<%#Eval("precio")%>" categoria="<%#Eval("categoria")%>" />
                                                                    <img  style="max-height:350px;" class="activator img_producto" src="<%#Eval("ruta_imagen_3")%>" descripcion="<%#Eval("descripcion")%>"  id="<%#Eval("id")%>" nombre="<%#Eval("nombre")%>" precio="<%#Eval("precio")%>" categoria="<%#Eval("categoria")%>" />
                                                                </div>
                                                            </div>

                                                            <div class="card-content">
                                                              <span class="card-title activator grey-text text-darken-4"><%#Eval("nombre")%></span>
                                                              <p><%#Eval("categoria")%></p>
                                                            </div>
                                                              <div class="card-action" style="display: flex;justify-content: space-evenly;">
                                                                <span style="font-family:Bangers;font-size:40px">$<%#Eval("precio")%>.00</span>
                                                                <span id='btn_comprar' url='Grilla_carrito.aspx' obj_id='<%#Eval("id")%>' img="<%#Eval("ruta_imagen")%>" art_id="<%#Eval("id")%>" precio="<%#Eval("precio")%>"  onclick='agregar_al_carrito_busqueda(this,"Producto agregado Correctamente");' ><span class='tooltipped' data-position='right' data-tooltip='Agregar' ><img class="zoom css_cesta" src="./static/img/cesta2.png" style="width:55px"/></span>
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
                </div>

                </div>



                <div class="col s12 m3 col_table phone_table" style="display:flex;justify-content:center">

                    
                    <div style="display: flex; flex-direction: column;align-items: center;" class="flipInY phone_contender" >
                        <div class="center_cesta_padre">
                            <div class="center_cestas">
                              <div class="phone_productos" style="display:flex;justify-content:center;position:relative;left:-10px"><span class="cantidad_cesta " style="font-family: 'Bangers', cursive; font-size: 25px; color: black;margin-right:15px">0</span><span style="color: black; font-size: 20px; font-family: 'Bangers', cursive;padding-top: 3px;"> Productos</span></div>
                                <img src="./static/img/shopping-cart.png" class="img_carrito" style="width: 80px;"/>
                            </div>
                        </div>

                         <div class="phone" style="width:290px;">
                          <p style="text-align:center" ><img width="30px" src="./static/img/wp.png" alt=""> <span style="position: relative; top: -10px; left: 5px;">Pedí por WhatsApp</span></p>
                          <!--  -->
                          <div class="bg-secondary mb-3" style="padding: 8px;border-radius: 20px;background: #fff;box-shadow: rgba(0, 0, 0, 0.25) 0px 54px 55px, rgba(0, 0, 0, 0.12) 0px -12px 30px, rgba(0, 0, 0, 0.12) 0px 4px 6px, rgba(0, 0, 0, 0.17) 0px 12px 13px, rgba(0, 0, 0, 0.09) 0px -3px 5px;">
                            <div class="col-12 row ml-1 pt-2 pb-1" style="position: relative; border-top-left-radius: 15px; border-top-right-radius: 15px; background: #ededed; margin: 0 0px; padding-left: 15px;">
                              <div class="col-3"><img width="45px" src="images/navbar.jpeg" alt="" style="border-radius: 50px;"></div>
                              <img style="width: 100px; position: relative; top: -10px; border-radius: 15px;"  src="./static/img/FAMILIARMENTE.png" alt=""><span style="position: relative; top: -20px; left: 10px;">GONZALO LOPEZ</span>
                            </div>
                            <div class="waChat ">
                              <div class="chat">

                                  <table class="table_telefono_virtual">
                                    <thead class="thead">

                                    </thead>
                                    <tbody class="tbody tbody_refresh">

                                    </tbody>
                                    </table>

                              </div>
                            </div>
                                <div style="text-align: center;">
                                    <span style="font-size: 25px; padding: 5px 0px 0px 0px; color: #222; right: 15px; position: relative;font-family: bangers;">Total: </span><span class="total" tot="0" style="color: #222;font-size: 35px;font-family: bangers;">$0</span>
                                </div>
                          </div>
                          <!---->
                          <div id="enviar_whatsapp" class="enviar_whatsapp tooltipped"  data-position='bottom' data-tooltip='Enviar Whatsapp con pedido' ><img src="static/img/send.png" style="position: relative; width: 55px; top: 20px; left: 24px;"/></div>
                          <p style="text-align: center; position: relative; top: 25px; font-weight: 600;">ENVIAR</p>
                        </div>

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
        .popup_big{
            width: 60vw !important;
        }
        .swal2-popup {
            width: 60vw !important;
        }
        .btn_categoria_buscar{
            min-width:170px;
            cursor:pointer;
            box-shadow: rgba(0, 0, 0, 0.4) 0px 2px 4px, rgba(0, 0, 0, 0.3) 0px 7px 13px -3px, rgba(0, 0, 0, 0.2) 0px -3px 0px inset;
        }
        .btn_categoria_buscar:hover{
            background: #18b8fd !important;
            box-shadow: rgba(0, 0, 0, 0.16) 0px 3px 6px, rgba(0, 0, 0, 0.23) 0px 3px 6px;
        }
        .menu-fixed {
            z-index: 2;
            position: fixed;
            top: 3em;
        }
        .striped tbody{
             display: flex;
             flex-wrap: wrap;
             justify-content: center;
             background: #f8f8f8;
             padding: 30px 0;

        }
        #nav_pages{
            display:none; /*SUB NAV de MASTER DESACTIVADA */ 
        }
        .center_cestas{
        display: flex;
        justify-content: center;
        flex-direction: column-reverse;
        text-align: center;
        }
    #btn_comprar{
        cursor:pointer;
        position:relative;
        top:5px;
    }
    .css_cesta:hover{
        transform: scale(1.3);
    }
    .articulos_card:hover{
        cursor:pointer;
  }
    .owl-stage{
        transform: scale(1.2);
    }

    .breadcrumb:before{
        display:none;
   }
    .phone td:nth-child(1){
        display:none
   }
    .phone th:nth-child(1){
        display:none;
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

.css_precio:hover{  -webkit-animation-name: rubberBand;
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

        .cantidad_cesta{

            
        }

        .cantidad_cesta:hover{
            transform: scale(1.2);
            cursor:none;
        }

        .grid-container {
          display: flex;
          flex-wrap:wrap;
          gap: 15px;
          padding: 10px;
          overflow:auto;
          }

        .compartir_store{
            cursor:pointer;
        }


        @media screen and (max-width: 600px) {
            .logo_inicio{
                width:70vw !important;
                margin-top:50px;
            }
            .articulos_card{
            width:100% !important;
            }
            .btn_categoria_buscar{
            width:200px;
            margin: 5px auto !important;
            cursor:pointer;
            }
            .btn_categoria_buscar:hover{
            background: #18b8fd !important;
            width:200px;
            margin: 5px auto !important;
            box-shadow: rgba(0, 0, 0, 0.16) 0px 3px 6px, rgba(0, 0, 0, 0.23) 0px 3px 6px;
            }
         .swal2-popup {
            width: 95vw !important;
            margin:auto;
         }
         .swal2-image{
             height: 500px !important;
         }

        }
        .owl-stage-outer{

        }
        .owl-carousel:hover{
              -webkit-animation-name: pulse ;
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

  .sorting_1{
    background-color: #f8f8f8;
    display: flex !important;
    justify-content: center;
}


@-webkit-keyframes shaker {
	0% { -webkit-transform: translate(2px, 0); }
	50% { -webkit-transform: translate(-2px, 0); }
	100% { -webkit-transform: translate(2px, 0); }
}

.shake {
	-webkit-animation-name: shaker;
	-webkit-animation-duration: 0.2s;
	-webkit-transform-origin:50% 50%;
	-webkit-animation-timing-function: linear;
}
/*th,td{
    padding: 0px 5px 0px 0px !important;
}*/
.td_virtual_phone{
}
.fila_table{
    height: 70px !important;
    display: flex;
    align-items: center;
    border-bottom: ridge;
}
.enviar_whatsapp{
    position: relative;
    height: 95px;
    border-radius: 80px;
    width: 95px;
    top: 25px;
    box-shadow: rgb(0 0 0 / 40%) 0px 2px 4px, rgb(0 0 0 / 30%) 0px 7px 13px -3px, rgb(0 0 0 / 20%) 0px -3px 0px inset;
    background: white;
    margin: auto;
}
.enviar_whatsapp:hover{
transform: scale(1.05);
box-shadow: rgba(0, 0, 0, 0.09) 0px 2px 1px, rgba(0, 0, 0, 0.09) 0px 4px 2px, rgba(0, 0, 0, 0.09) 0px 8px 4px, rgba(0, 0, 0, 0.09) 0px 16px 8px, rgba(0, 0, 0, 0.09) 0px 32px 16px;
}


.input_cant_tel_virtual:hover {
    transform: scale(1.05)
}
.flecha_arriba{
    cursor:pointer
}
.flecha_arriba{
    transform: scale(1.05)
}

.flecha_abajo{
    cursor:pointer
}
.flecha_abajo:hover{
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


            phone_fixed()
            setInterval(mover_cartelito, 15000)

            //$("div").find("li").css("z-index", 2147483647).remove();

            function mover_cartelito() {
                $('.img_open').addClass("swing");
                var delay = setTimeout(function () {
                    $(".swing").removeClass("swing");
                }, 3000)
            }

            $('.img_open').css("height","70px")
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
            //$('.articulos_card').mouseenter(function () {
            //    hover_product(this)
            //})

            //function hover_product(obj) {
            //    console.log('hover_product')
            //    //var urlimg = './static/img/carrito.png'
            //    $(obj).css('Width', '300px')
            //    $(obj).css('Width', '300px')
            //    $(obj).css('height', '300px')

                //var flechas = obj.children.childen.children[0]
                //console.log(flechas)
                //$(flechas).show()
                //$(this).click(function () {
                //    //$(obj).css('background-image', 'url("' + urlimg + '")')
                //})
            //}

            //function hover_product_leave(obj) {
            //    console.log(obj)
            //    $(obj).css('Width', '200px')
            //    $(obj).css('height', '200px')
            //    //var flechas = obj.children[0]
            //    //$(flechas).hide()
            //}

            //$('.articulos_card').mouseleave(function () {
            //    hover_product_leave(this)
            //})
           
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
                //console.log(id,nombre,categoria,precio,img1, img2, img3,descripcion)
                //AGRANDAR IMAGEN
                //Swal.fire({
                //    title: '<u><b>' + nombre + '</b></u><p>INCLUYE</p>',
                //    html: descripcion,
                //    showCloseButton: false,
                //    showCancelButton: false,
                //    confirmButtonText:
                //      '<i class="fa fa-thumbs-up"></i>',
                //    cancelButtonText:
                //      '<i class="fa fa-thumbs-down"></i>',
                //})
            })

            sessionStorage.clear()

 
            $('.grid-container').show(350)
            $('.tabs').tabs();

            var selector = $('.striped')
            inicializar_grilla(selector);



            $('.compartir_store').click(function () {
                compartir_tienda_por_wpp("http://www.storeelcape.somee.com/shop.aspx")
            })

            
            //$.ajax({
            //    type: "POST",
            //    url: "shop.aspx/articulo_consul",
            //    data: '{art_id: "' + art_id + '", cantidad: "'+ cantidad +'" }',
            //    contentType: "application/json; charset=utf-8",
            //    dataType: "json",
            //    success: function (response) {
            //    sessionStorage.msg_confirm = msg_confirm
            //    sessionStorage.icon = 'error'
            //}
            //});
            

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
                if (carrito == null) {
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
                if (carrito == null) {
                    show_alert("Tu carrito de pedidos esta vacío", "Agregá productos al carrito", "error")
                    return false
                }
                var nombre_cliente = ""// $('.class_txt_nombre').val()
                var celular = ""//$('.class_txt_celular').val()
                var calle = ""//$('.class_txt_calle').val()
                var calle_numero = ""//$('.class_txt_calle_numero').val()
                var info_pedido = []
                info_pedido.push(nombre_cliente)
                info_pedido.push(celular)
                info_pedido.push(calle)
                info_pedido.push(calle_numero)
                registrar_pedido(carrito, info_pedido)
                sessionStorage.setItem("carrito", "")
                show_alert_confirm('¡Pedido generado con éxito!', 'Haz sido reenviado a whatsapp con tu pedido adjunto ¡Haz click en enviar! Recibirás una confirmación de tu pedido por el mismo medio.', 'shop.aspx')
                return false
                //Pedido de gonzalo de no pedir datos
                Swal.fire({
                    title: '<strong>Completá tu pedido</strong>',
                    html: celular_interfaz,
                    showCloseButton: false,
                    showCancelButton: true,
                    focusConfirm: false,
                    confirmButtonText:'Enviar Pedido',
                    cancelButtonText: 'Cancelar',
                }).then((result) => {
                    /* Read more about isConfirmed, isDenied below */
                    if (result.isConfirmed) {
                        var info_pedido = []
                        var nombre_cliente = $('.class_txt_nombre').val()
                        var celular = $('.class_txt_celular').val()
                        var calle = $('.class_txt_calle').val()
                        var calle_numero = $('.class_txt_calle_numero').val()
                        var lever = $('.lever').val()
                        console.log(lever)

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

                        info_pedido.push(nombre_cliente)
                        info_pedido.push(celular)
                        info_pedido.push(calle)
                        info_pedido.push(calle_numero)

                        registrar_pedido(carrito, info_pedido)
                        sessionStorage.setItem("carrito", "")
                        show_alert_confirm('¡Pedido generado con éxito!', 'Haz sido reenviado a whatsapp con tu pedido adjunto ¡Haz click en enviar! Recibirás una confirmación de tu pedido por el mismo medio.', 'shop.aspx')
                        //calcular_total()
                                                
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



        });// fin doc ready

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
            if (carrito == null) {
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



        function animaciones_al_agregar_producto(){
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
            console.log(msg);
            var href = 'https://api.whatsapp.com/send?phone=54'+<%=numero_whatsapp%>+'&text='
            href = href + msg;
            console.log(href)
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
                    $('.tbody_refresh').append("<tr class='fila_table'><td class='td_virtual_phone'>" + carrito[i].articulo + "</td><td style='width: 70px;' class='td_virtual_phone'><div style='display:flex;'><div class='flechas' style='display: flex; flex-direction: column; position: relative; left: -5px; top: -1px;'><img class='flecha_arriba' onclick='flecha_arriba(this)' style='filter: grayscale(1);width:25px;transform: rotateZ(90deg);margin:3px 0' src='static/img/arrow.png' /><img class='flecha_abajo' onclick='flecha_abajo(this)' style='filter: grayscale(1);width:25px;transform: rotateZ(270deg)' src='static/img/arrow.png' /></div><input style='border-bottom: 0px; width: 60px; font-size: 30px; text-align: center; font-family: bangers; position: relative; top: 7px; color: #383838; left: -10px; cursor:pointer' type='number' art_id='" + carrito[i].articulo + "' precio_unitario='" + carrito[i].precio + "' onChange='telefono_virtual_actualizar_precio_respecto_a_cantidad(this)' value='" + carrito[i].cantidad + "' readOnly/></div></td><td class='articulo_de_telefono_virtual td_virtual_phone' art_id='" + carrito[i].articulo + "' precio_unitario='" + carrito[i].precio + "'img='" + carrito[i].img + "' cantidad='" + carrito[i].cantidad + "' onclick='quitar_producto_de_celular(this)'><img class='img_producto_telefono_virtual' src='" + carrito[i].img + "' style='width: 60px; height: 60px; border: 1px solid #dedede; border-radius: 20px; position: relative; top: 2px; right: 2px;' class='table_ruta_imagen' id='txt_ruta_imagen'/></td><td class='td_virtual_phone'><span style='font-size: 20px;color:#383838; font-family: bangers; padding-left: 10px;'>$" + carrito[i].precio + ".00</span></td></tr>")
                }
            }
        




        //<img src="https://i.ibb.co/4fpKpLD/p1-1.png" alt="p1-1" border="0">c
        //<img src="https://i.ibb.co/njyhCxQ/p1-2.png" alt="p1-2" border="0">
        //<img src="https://i.ibb.co/5n8rNqM/p1-3.png" alt="p1-3" border="0">

        //<img src="https://i.ibb.co/Sxmph9D/p2-1.png" alt="p2-1" border="0">
        //<img src="https://i.ibb.co/x3rxvNH/p2-2.png" alt="p2-2" border="0">
        //<img src="https://i.ibb.co/4fkHhcg/p2-3.png" alt="p2-3" border="0">

        //<img src="https://i.ibb.co/yVKQR81/p3-1.png" alt="p3-1" border="0">
        //<img src="https://i.ibb.co/Vt9JWHT/p3-2.png" alt="p3-2" border="0">
        //<img src="https://i.ibb.co/L1hqQtk/p3-3.png" alt="p3-3" border="0">
        //<img src="https://i.ibb.co/4FgDMQ4/p3-4.png" alt="p3-4" border="0">

        //<img src="https://i.ibb.co/YdM6mw8/p4-1.png" alt="p4-1" border="0">
        //<img src="https://i.ibb.co/dPsX6f4/p4-2.png" alt="p4-2" border="0">

        //<img src="https://i.ibb.co/YpT381w/p5-1.png" alt="p5-1" border="0">
        //<img src="https://i.ibb.co/Wn5hm6r/p5-2.png" alt="p5-2" border="0">
        //<img src="https://i.ibb.co/K77Wp3J/p5-3.png" alt="p5-3" border="0">

        //<img src="https://i.ibb.co/8sb22bq/p6-1.png" alt="p6-1" border="0">
        //<img src="https://i.ibb.co/qg5RnGy/p6-2.png" alt="p6-2" border="0">

        //<img src="https://i.ibb.co/qdF5BCR/p7-1.png" alt="p7-1" border="0">
        //<img src="https://i.ibb.co/pw1B7HJ/p7-2.png" alt="p7-2" border="0">
        //<img src="https://i.ibb.co/mBrGGSR/p7-3.png" alt="p7-3" border="0">



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
            console.log("articulos" , articulos)
            articulos = articulos.toString()

            //console.log(articulos)
            $.ajax({
                type: "POST",
                url: "shop.aspx/registrar_pedido",
                data: '{articulos: "' + articulos + '" }',
                async: false,
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    if (response) {
                        if (response.d) {
                            var redaccion = []
                            console.log("QQQ",response.d)
                            redaccion = response.d.split("|")
                            console.log(redaccion)
                            enviar_whatsapp(redaccion[1])

                            $('.monedas').prop("volume", 0.3);
                            $(".monedas")[0].play();
                            $('.tbody_refresh').html("")
                            var carrito = []
                            sessionStorage.carrito = JSON.stringify(carrito)
                            $('td[tot]').attr('tot', 0)
                            $('td[tot]').html("$0")
                            $('.cantidad_cesta').html(0)
                            procesar_toast("Venta n°" + redaccion[0] + " registrada", "success")
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
