<%@ Page Language="VB" AutoEventWireup="false" MasterPageFile="~/master.master" CodeFile="Contacto.aspx.vb" Inherits="Contacto" %>

<asp:Content runat="server" ContentPlaceHolderID="contenido_nav">
    <a href="supervisor_index.aspx" class="breadcrumb">INICIO</a>
    <a href="#" class="breadcrumb ACTIVE">Contacto</a>
</asp:Content>

<asp:Content runat="server" ContentPlaceHolderID="contenido_body">

    <h1 style="text-align:center">Contacto</h1>
    <p class="center">Ubicación de la tienda y datos de contacto.</p>
        <div >


        <form id="Form_fv_empresas" runat="server">

                    <asp:ScriptManager runat="server" ID="ScriptManager_grilla_emp"></asp:ScriptManager>
                    <asp:HiddenField id="hi_input" runat="server" Value="" />
                                          
                                    <div id="tab_consultas" class="container" >
                                        <div class="contender_carrito" style="position: absolute; top: 17vh; right: 17vw;">
                                            <img src="./static/img/contacto.png" class="img_carrito bounce" style="width: 80px;"/>
                                        </div><br />
                                            <!---->
                                        <div style="background: #f3f3f3; width: 100%; height: 450px; border-radius: 5px;" id="map_local"></div>
                                            <!---->
                                        <div class="control">
                                            <button id="addMarkerBtn"><img src="./static/img/pinMapColor.png" style="width: 50px;"/></button>
                                            <input type="text" id="popupText" placeholder="Agregá tu STORE al mapa con el botón / Título POPUP" style="border: none; background: white;position: relative; top: 5px;">
                                        </div>
                                        <br />
                                        <div>
                                            <p><span>Dirección: </span><span class="direccion_contacto">calle ejemplo 123</span></p>
                                            <p><span>Teléfono: </span><span class="direccion_contacto">+54 11 3265 5487</span></p>
                                        </div>
                                        <div>
                                            <p><span>Link a redes</span></p>
                                        </div>


                                    </div> <%-- fin tab--%>
       
                </form>
            </div>
        <br /><br /><br />


        </div>

    <style>
        /* Oculta la cuarta y quinta columna cuando el tamaño de la pantalla es menor a 600px (precio)*/
        @media (max-width: 600px) {
            table tr td:nth-child(5),
            table tr th:nth-child(5) {
                display: none;
            }
        }
        #map_local {
            width: 100%;
            height: 450px;
            border-radius: 5px;
        }
        .control {
            padding: 10px;
            border-radius: 5px;
            box-shadow: 0 2px 6px rgba(0, 0, 0, 0.1);
            display: flex;
            gap: 10px;
        }
        .crosshair-cursor {
            cursor: crosshair;
        }
    </style>
</asp:Content>


<asp:Content runat="server" ContentPlaceHolderID="contenido_js">
   <script>
       var map = L.map('map_local').setView([-34.6037, -58.3816], 13); // Iniciar en Buenos Aires

       L.tileLayer('https://tile.openstreetmap.org/{z}/{x}/{y}.png', {
           attribution: '&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors'
       }).addTo(map);

       var addMarker = false;
       var markers = [];

       // Agregar marcador inicial en Buenos Aires
       var initialMarker = L.marker([-34.6037, -58.3816], {
           icon: L.icon({
               iconUrl: 'static/img/pinMapColor.png',
               shadowUrl: 'static/img/marker-shadow.png',
               iconSize: [65, 65],
               shadowSize: [65, 41],
               iconAnchor: [41, 41],
               shadowAnchor: [41, 41],
               popupAnchor: [1, -34]
           })
       }).addTo(map).bindPopup('Buenos Aires').openPopup();

       markers.push(initialMarker);

       // Volar al marcador inicial
       map.flyTo([-34.6037, -58.3816], 13);

       $('#addMarkerBtn').click(function () {
           addMarker = true;
           $(this).prop('disabled', true);
           $('#map_local').addClass('crosshair-cursor'); // Añadir clase para cambiar el cursor
       });

       $('#map_local').on('mouseleave', function () {
           $(this).removeClass('crosshair-cursor'); // Quitar clase cuando el mouse sale del mapa
       });

       map.on('click', function (e) {
           if (addMarker) {
               var popupText = $('#popupText').val() || 'Store Aquí';

               // Crear un icono personalizado con sombra
               var customIcon = L.icon({
                   iconUrl: 'static/img/pinMapColor.png',
                   shadowUrl: 'static/img/marker-shadow.png',
                   iconSize: [65, 65], // tamaño del icono
                   shadowSize: [65, 41], // tamaño de la sombra
                   iconAnchor: [41, 41], // punto del icono que se corresponde con la posición del marcador
                   shadowAnchor: [41, 41], // punto de la sombra que se corresponde con la posición del marcador
                   popupAnchor: [1, -34] // punto desde el cual se abrirá el popup relativo al icono
               });

               // Eliminar todos los marcadores existentes
               markers.forEach(function (marker) {
                   map.removeLayer(marker);
               });
               markers = [];

               // Agregar nuevo marcador
               var marker = L.marker(e.latlng, { icon: customIcon }).addTo(map)
                   .bindPopup(popupText)
                   .openPopup();

               markers.push(marker);

               //console.log('Coordinates:', e.latlng);
               //console.log('Popup text:', popupText);

               addMarker = false;
               $('#addMarkerBtn').prop('disabled', false);
               $('#popupText').val('');
               $('#map_local').removeClass('crosshair-cursor'); // Quitar clase cuando se coloca el marcador
           }
       });
    </script>
</asp:Content>