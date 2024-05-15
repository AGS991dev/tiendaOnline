<%@ Page Language="VB" AutoEventWireup="false" MasterPageFile="~/master.master" CodeFile="Grilla_stock.aspx.vb" Inherits="Grilla_stock" %>

<asp:Content runat="server" ContentPlaceHolderID="contenido_nav">
    <a href="supervisor_index.aspx" class="breadcrumb">INICIO</a>
    <a href="frm_<%=Titulo%>.aspx" class="breadcrumb"><%=Titulo %></a>
</asp:Content>

<asp:Content runat="server" ContentPlaceHolderID="contenido_body">

    <h1 style="text-align:center">Menu de Stock</h1>
    <div class="container">
        <div class="p_botones_stock">
            <a href="frm_<%=Titulo %>.aspx" class="btn_agregar_articulo tooltipped boton_stock" data-position='bottom' data-tooltip='Agregá un nuevo artículo'><img src="static/img/delivery-box.png"/ width="50px"></a>
            <a href="grilla_categorias.aspx" class="btn_agregar_articulo tooltipped boton_stock" data-position='bottom' data-tooltip='Agregá una nueva categoría' ><img src="static/img/categorias.png"/ width="50px"></a>
        </div>
        <br />
        <div >
        <form id="Form_fv_empresas" runat="server">

                    <asp:ScriptManager runat="server" ID="ScriptManager_grilla_emp"></asp:ScriptManager>
                    <asp:HiddenField id="hi_categoria_filter" runat="server" Value="" />
                                            
                                    <div id="tab_grafico" style="padding-right: 20px;" >

                                                                                         
                                            <ul id="tabs-swipe-demo" class="tabs center">
                                            <li class="tab"><a class="active" href="#myChart-2" style="display:flex;"><img src="static/img/bar.png" style="width: 50px; padding: 5px; margin-right: 10px;" /><span>GRÁFICO BARRAS</span></a></li>
                                            <li class="tab"><a href="#grilla_imagen" style="display:flex;"><img src="static/img/imagen.png" style="width: 50px; padding: 5px; margin-right: 10px;" /><span>IMAGEN</span></a></li>
                                            <li class="tab"><a href="#grilla" style="display:flex;"><img src="static/img/mesa.png" style="width: 50px; padding: 5px; margin-right: 10px;" /><span>GRILLA</span></a></li>
                                            <li class="tab"><a href="#myChart-1" style="display:flex;"><img src="static/img/dona.png" style="width: 50px; padding: 5px; margin-right: 10px;" /><span>GRÁFICO CIRCULAR</span></a></li>
                                            </ul>
                                            <br />
                                           <div style="position:relative;">
                                               <div style="display:flex;justify-content:space-between">
                                                    <p style="margin-left:10px">FILTRÁ LOS ARTÍCULOS POR CATEGORÍAS</p>
                                                    <asp:Button ID="btn_filter" runat="server" Text="FILTRAR 🔍" CssClass="btn btn_refrescar_grafico" Style="position: relative;top: 5px;"/>
                                                </div>
                                                <br />
                                                <div class="card menu_filtro" style="padding-bottom: 10px;padding: 15px 15px;">
                                                    <br />
                                            
                                                    <div style="display:flex;justify-content: center;">
                                                        <div class="combos_articulos">
                                                                <% for index_categoria = 0 To categorias.Count - 1 %>
                                                                <% if not categorias(index_categoria) Is Nothing Then%>
                                                                <p style="margin: 0 20px;">
                                                                    <label>
                                                                    <input categoria="<%= categorias(index_categoria) %>" type="checkbox" class="filled-in" checked="checked" />
                                                                    <span><%= categorias(index_categoria) %></span>
                                                                    </label>
                                                                </p>
                                                                <% End if %>
                                                                <% Next %>
                                                        
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                                  <div id="grilla">
                                                    <asp:UpdatePanel ID="Update_grilla" runat="server" UpdateMode="Conditional">
                                                        <ContentTemplate>
                                                            <%=tabla %>
                                                        </ContentTemplate> 
                                                    </asp:UpdatePanel>
                                                  </div>
                                                   <div id="grilla_imagen">
                                                        <center>
                                                            <h4>Artírculos</h4>
                                                        </center>
                                                        <div id="tab_busqueda" >
                                                            <asp:UpdatePanel ID="panel_empresas" runat="server" UpdateMode="Conditional">
                                                                    <ContentTemplate>
                                                                <!---->
                                                                <ASP:GridView ID ="GV_empresas" runat="server" class="striped grilla_tabla" AutoGenerateColumns="false"  CellSpacing='0' Width='100%'>
                                                                <Columns>

                                                                   <ASP:TemplateField HeaderText ="" >
                                                                        <ItemTemplate>
                                                                        <div style="box-shadow: rgba(50, 50, 105, 0.15) 0px 2px 5px 0px, rgba(0, 0, 0, 0.05) 0px 1px 1px 0px; margin: 1px; padding: 0 4px;">
                                                                            <div style="width: 170px; height: 260px;"> <%--  class="img_producto" --%>
                                                                                <div>
                                                                                    <div style="text-align: center;">
                                                                                        <img src="<%#Eval("ruta_imagen")%>" width="150" class="lazy" height="150" alt="">
                                                                                        <%--<img style="max-height: 200px;" class="activator img_producto" src="<%#Eval("ruta_imagen_2")%>" descripcion="<%#Eval("descripcion")%>" id="<%#Eval("id")%>" nombre="<%#Eval("nombre")%>" precio="<%#Eval("precio")%>" categoria="<%#Eval("categoria")%>" /><img style="max-height: 200px;" class="activator img_producto" src="<%#Eval("ruta_imagen_3")%>" descripcion="<%#Eval("descripcion")%>" id="<%#Eval("id")%>" nombre="<%#Eval("nombre")%>" precio="<%#Eval("precio")%>" categoria="<%#Eval("categoria")%>" />--%>
                                                                                    </div>
                                                                                    <div>
                                                                                        <a href="#"><%#Eval("nombre")%> <b><%#Eval("categoria")%></b></a>
                                                                                        <div>
                                                                                            <span><b><%#Eval("cantidad")%> Unidades</b></span>
                                                                                            <!--<span><b><%#Eval("categoria")%></b></span>
                                                                                            <span><b><%#Eval("tamaño")%></b></span>
                                                                                            <span><b><%#Eval("color")%></b></span>-->
                                                                                        </div>
                                                                                    </div>
                                                                                </div>
                                                                            </div>
                                                                            <div>
                                                                                <!-- BOTON AGREGAR MASY PRECIO -->
                                                        
                                                                                <span id='btn_comprar' url='Grilla_carrito.aspx'
                                                                                    obj_id='<%#Eval("id")%>'
                                                                                    img="<%#Eval("ruta_imagen")%>"
                                                                                    art_id="<%#Eval("id")%>"
                                                                                    precio="<%#Eval("precio")%>"
                                                                                    class="btn_mas_shopStore lazy"
                                                                                    onclick='agregar_al_carrito_busqueda(this,"Producto agregado Correctamente");'>
                                                                                    <span style="background: #ed3446 !important; color: white; padding: 4px 10px; border-radius: 2px; position: relative; left: -10px; font-family: cursive; font-size: large; bottom: 10px;"><b>$</b> <%#Eval("precio")%>.00</span>
                                                                                    <a style="position: relative; top: -14px;background: #ed3446 !important" href='Frm_stock.aspx?id=<%#Eval("id")%>' ><span class='waves-effect waves-light btn-small tooltipped card_color' syule="padding: 0px 20px 0px 20px;height: 35px;background: #ed3446 !important;" data-position='top' data-tooltip='Editar <%#Eval("nombre")%>' ><i class='material-icons'>edit</i></a>
                                                                                </span>
                                                                            </div>
                                                                        </div>
                                                    
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>                                


                                                                </Columns>
                                                             </asp:GridView>
                                                             <!---->
                                                             </ContentTemplate>
                                                                 <Triggers>
                                                                    <asp:AsyncPostBackTrigger ControlID="btn_filter" EventName="Click"  />
                                                                </Triggers>
                                                             </asp:UpdatePanel>
                                                            </div> <%-- fin tab--%>
                                                    </div>

                                                  <div id="myChart-1">
                                                     <div class="box_myChart barras" style="width:90%;margin:auto"><br />
                                                        <canvas id="myChart"></canvas>
                                                    </div>
                                                  </div>
                                                  <div id="myChart-2">
                                                    <div class="box_myChart dona"><br />
                                                        <canvas id="myChart_2"></canvas>
                                                    </div>
                                                  </div>


                                                    
                                                  </div>
                                            </div>
                                    <br />
                                </div>  <%-- fin tab--%>
                </form>
            </div>
        <br /><br /><br />


        </div>

    <style>
        [type="checkbox"].filled-in:checked+span:not(.lever):after {
            border: 2px solid #29357d !important;
            background-color: #29357d !important;
        }
        td:nth-child(1), th:nth-child(1), td:nth-child(2), th:nth-child(2), td:nth-child(5), th:nth-child(5), td:nth-child(6), th:nth-child(6), td:nth-child(7), th:nth-child(7) {
            text-align: center;
        }

        .grilla_tabla > tbody {
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
        }

        .combos_articulos {
            display: flex;
            flex-wrap: wrap;
            width: max-content;
        }

        .boton_stock {
            box-shadow: rgb(60 64 67 / 30%) 0px 1px 2px 0px, rgb(60 64 67 / 15%) 0px 2px 6px 2px;
            width: max-content;
            padding: 10px 10px 5px 10px;
            border-radius: 6px;
            margin: 3px;
            cursor: pointer;
        }

        .p_botones_stock {
            display: flex;
            justify-content: flex-start;
        }
    </style>
    
</asp:Content>


<asp:Content runat="server" ContentPlaceHolderID="contenido_js">
    <script type="text/javascript">

        var myChart
        var myChart_2

        $('document').ready(function () {

            $('.tabs').tabs();


            var ctx = document.getElementById('myChart')
            myChart = new Chart(ctx, {
                type: 'doughnut',//'horizontalBar', 'doughnut','bar','line','radar','polarArea','bubble',
                data: {
                    datasets: [{
                        label: 'Stock de Productos',
                        backgroundColor: ["#2778c4", "#a5dc86", "#ee6e73", "#f3d95a", "#b252c3", "#FF0000", "#808080", "#000000", "#C0C0C0", "#FFFF00", "#FF00FF", "#800080", "#000080"],
                        borderColor: ['black'],
                        borderWidth: 1
                    }]
                },
                options: {
                    scales: {
                        y: {
                            beginAtZero: true
                        }
                    }
                }
            })

            var ctx_2 = document.getElementById('myChart_2')
            myChart_2 = new Chart(ctx_2, {
                type: 'bar',//'horizontalBar', 'doughnut','bar','line','radar','polarArea','bubble',
                data: {
                    datasets: [{
                        label: 'Stock de Productos',
                        backgroundColor: ["#2778c4", "#a5dc86", "#ee6e73", "#f3d95a", "#b252c3", "#FF0000", "#808080", "#000000", "#C0C0C0", "#FFFF00", "#FF00FF", "#800080", "#000080"],
                        borderColor: ['black'],
                        borderWidth: 1
                    }]
                },
                options: {
                    scales: {
                        y: {
                            beginAtZero: true
                        }
                    }
                }
            })

            var img_art_busqueda = $('.img_art_busqueda')
            for (i = 0; i < img_art_busqueda.length; i++) {
                var blob = $(img_art_busqueda[i]).attr("img")
                //console.log("img",blob)
            }
            

            const mostrar = (myChart, categoria, cantidad) => {
                const _categorias = categoria.split(",");
                const _cantidades = cantidad.split(",");
                for (i = 0; i < _categorias.length; i++) {
                    myChart.data['labels'].push(_categorias[i])
                    myChart.data['datasets'][0].data.push(_cantidades[i])
                }
                myChart.update()
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


            $('.btn_refrescar_grafico').click(function () {
                actualizar_graficos()
            })




            $('input[categoria]').change(function () {
                var filter_array = []
                var checks = $('input[categoria]')
                var hi_string = ""

                for (i = 0; i < checks.length; i++) {
                    var check = checks[i]
                    //console.log(check)
                    categoria = $(check).attr("categoria")
                    check = $(check).is(':checked')
                    if (check == true) {
                        filter_array.push(categoria)

                        if(i==0){
                            hi_string = categoria
                        } else {
                            hi_string = hi_string + "," + categoria
                            //console.log(i)
                        }
                    }
                }
                //console.log("Hi_string ->", hi_string)
                $('#<%=hi_categoria_filter.ClientID%>').val(hi_string);
            })

            inicializar_graficos()
            // Cargar las imágenes visibles al cargar la página
            lazyLoad();

            // Cargar imágenes al hacer scroll
            $(window).scroll(function () {
                lazyLoad();
            });

        on_postback_end(recargar_postback)

        });// FIN ON READY

        function inicializar_graficos() {
            $.ajax({
                type: "POST",
                url: "grilla_stock.aspx/inicializar_grafico_inicio",
                data: '{id: "1" }',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    var _data = data.d
                    _data = _data.split('/');
                    //console.log("_data", _data)
                    var _categorias = _data[0]
                    _categorias = _categorias.split(",");
                    var _cantidades = _data[1]
                    _cantidades = _cantidades.split(",");

                    for (i = 0; i < _categorias.length; i++) {
                        myChart.data['labels'].push(_categorias[i])
                        myChart.data['datasets'][0].data.push(_cantidades[i])
                        myChart_2.data['labels'].push(_categorias[i])
                        myChart_2.data['datasets'][0].data.push(_cantidades[i])
                    }
                        myChart.update()
                        myChart_2.update()
                }
            });

        }

        function vaciar_my_chart(arr) {
            for (var i = arr.length; i >= 0; i--) {
                try {
                arr.splice(i, 1);
                } catch (e) {
                }
            }
        }

        function actualizar_graficos() {
            var hi_categoria = $('#<%=hi_categoria_filter.ClientID%>').val();
                                           $.ajax({
                                               type: "POST",
                                               url: "grilla_stock.aspx/recarga_grafico",
                                               data: '{hi_categoria: "' + hi_categoria + '" }',
                                               contentType: "application/json; charset=utf-8",
                                               dataType: "json",
                                               success: function (data) {
                                                   var _data = data.d
                                                   _data = _data.split('/');
                                                   //console.log("_data", _data)
                                                   var _categorias = _data[0]
                                                   _categorias = _categorias.split(",");
                                                   var _cantidades = _data[1]
                                                   _cantidades = _cantidades.split(",");

                                                   myChart.destroy()
                                                   myChart_2.destroy()

                                                   var ctx = document.getElementById('myChart')
                                                   myChart = new Chart(ctx, {
                                                       type: 'doughnut',//'horizontalBar', 'doughnut','bar','line','radar','polarArea','bubble',
                                                       data: {
                                                           datasets: [{
                                                               label: 'Stock de Productos',
                                                               backgroundColor: ["#2778c4", "#a5dc86", "#ee6e73", "#f3d95a", "#b252c3", "#FF0000", "#808080", "#000000", "#C0C0C0", "#FFFF00", "#FF00FF", "#800080", "#000080"],
                                                               borderColor: ['black'],
                                                               borderWidth: 1
                                                           }]
                                                       },
                                                       options: {
                                                           scales: {
                                                               y: {
                                                                   beginAtZero: true
                                                               }
                                                           }
                                                       }
                                                   })

                                                   var ctx_2 = document.getElementById('myChart_2')
                                                   myChart_2 = new Chart(ctx_2, {
                                                       type: 'bar',//'horizontalBar', 'doughnut','bar','line','radar','polarArea','bubble',
                                                       data: {
                                                           datasets: [{
                                                               label: 'Stock de Productos',
                                                               backgroundColor: ["#2778c4", "#a5dc86", "#ee6e73", "#f3d95a", "#b252c3", "#FF0000", "#808080", "#000000", "#C0C0C0", "#FFFF00", "#FF00FF", "#800080", "#000080"],
                                                               borderColor: ['black'],
                                                               borderWidth: 1
                                                           }]
                                                       },
                                                       options: {
                                                           scales: {
                                                               y: {
                                                                   beginAtZero: true
                                                               }
                                                           }
                                                       }
                                                   })

                                                   for (i = 0; i < _categorias.length; i++) {
                                                       try {
                                                           myChart.data['labels'].push(_categorias[i])
                                                           myChart.data['datasets'][0].data.push(_cantidades[i])
                                                           myChart_2.data['labels'].push(_categorias[i])
                                                           myChart_2.data['datasets'][0].data.push(_cantidades[i])
                                                       } catch (e) {
                                                       }
                                                   }

                                                   myChart.update()
                                                   myChart_2.update()
                                               }
                                           });

                                       }

                                       function recargar_postback() {

                                           $(".owl-carousel").owlCarousel({
                                               nav: false,
                                               slideBy: 1,
                                               items: 1,
                                               loop: true,
                                               autoplay: true,
                                               autoplayTimeout: 7000,
                                               autoplayHoverPause: true
                                           });

                                       }

                                       function destroy_myChart(myChart) {
                                           if (myChart) {
                                               myChart.destroy();
                                           }
                                       }
                                       function refrescar_grafico_categorias(categoria, cantidad) {
                                           if (myChart) {
                                               myChart.destroy();
                                           }
                                           myChart = inicializar_grafico()
                                           mostrar(myChart, categoria, cantidad)
                                       }

                                       function refrescar_grafico_categorias_circular(categoria, cantidad) {
                                           if (myChart_2) {
                                               myChart_2.destroy();
                                           }
                                           myChart_2 = inicializar_grafico_circular()
                                           mostrar(myChart_2, categoria, cantidad)
                                       }

    </script>
</asp:Content>