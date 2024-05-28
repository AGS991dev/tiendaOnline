<%@ Page Language="VB" AutoEventWireup="false" MasterPageFile="~/master.master" CodeFile="Contacto.aspx.vb" Inherits="Contacto" %>

<asp:Content runat="server" ContentPlaceHolderID="contenido_nav">
    <a href="supervisor_index.aspx" class="breadcrumb">INICIO</a>
    <a href="#" class="breadcrumb ACTIVE">Contacto</a>
</asp:Content>

<asp:Content runat="server" ContentPlaceHolderID="contenido_body">

    <h1 style="text-align: center">Contacto</h1>
    <p class="center">Ubicación de la tienda y datos de contacto.</p>
    <div>


        <form id="Form_fv_empresas" runat="server">

            <asp:ScriptManager runat="server" ID="ScriptManager_grilla_emp"></asp:ScriptManager>
            <asp:HiddenField ID="hi_input" runat="server" Value="" />

            <div id="tab_consultas" class="container">
                <div class="contender_carrito" style="position: absolute; top: 17vh; right: 17vw;">
                    <img src="./static/img/contacto.png" class="img_carrito bounce" style="width: 80px;" />
                </div>
                <br />
                <!--MAPA-->
                <div style="background: #f3f3f3; width: 100%; height: 450px; border-radius: 5px;" id="map_local">
                    <!--BOTON MARKER CONTROL-->
                    <% If cls_security.usuario_actual IsNot Nothing Then%>
                    <% If cls_security.usuario_actual.es_supervisor Then%>
                    <div class='control_1 tooltipped' data-position='left' data-tooltip='Click para agregar ubicación'>
                        <div id="addMarkerBtn">
                            <img src="./static/img/pinMapColor.png" style="width: 50px;" />
                        </div>
                    </div>
                    <div class='control_2 tooltipped' data-position='left' onclick="InsertarContacto()" data-tooltip='Guardar'>
                        <img src="./static/img/save.png" style="width: 50px;" />
                    </div>
                    <%End If%>
                    <%End If%>
                </div>
                <!--FIN MAPA-->

                <br />
                <!--Inputs-->
                <% If cls_security.usuario_actual IsNot Nothing Then%>
                <% If cls_security.usuario_actual.es_supervisor Then%>
                <div class="control-inputs">
                    <div class="form-group">
                        <label for="Nombre_tienda">Nombre de la Tienda:</label>
                        <asp:TextBox ID="Nombre_tienda" runat="server" CssClass="form-control Nombre_tienda" />
                    </div>
                    <div class="form-group">
                        <label for="Popup_title">Título del Popup:</label>
                        <asp:TextBox ID="Popup_title" runat="server" CssClass="form-control Popup_title popupText" />
                    </div>
                    <div class="form-group">
                        <label for="Direccion">Dirección:</label>
                        <asp:TextBox ID="Direccion" runat="server" CssClass="form-control Direccion" />
                    </div>
                    <div class="form-group">
                        <label for="Telefono">Teléfono:</label>
                        <asp:TextBox ID="Telefono" runat="server" CssClass="form-control Telefono" />
                    </div>
                    <div class="form-group">
                        <label for="SocialMediaLink">Link a Redes Sociales:</label>
                        <asp:TextBox ID="SocialMediaLink" runat="server" CssClass="form-control SocialMediaLink" />
                    </div>
                    <div class="form-group" style="display: none">
                        <label for="Coordenadas">Coordenadas:</label>
                        <asp:TextBox ID="Coordenadas" runat="server" CssClass="form-control Coordenadas" ReadOnly="true" />
                    </div>
                </div>
                <% End If%>
                <% End If%>
                <!--FIN Inputs-->


            </div>
            <div class="container" style="display: flex; justify-content: space-around; flex-wrap: wrap; padding: 5px; width: 100%;">
                <%For Each row In Ubicaciones%>
                <div class="contact-card" style="box-shadow: rgba(0, 0, 0, 0.1) 0px 1px 3px 0px, rgba(0, 0, 0, 0.06) 0px 1px 2px 0px; padding: 10px 40px; margin: 20px 0px;">
                    <h5 style="text-align: center; background: #abcaff; border-radius: 3px; color: white; " class="Nombre_tienda"><%= row("Nombre_tienda") %></h5>
                    <p><strong>Dirección:</strong> <span class="Direccion"><%= row("Direccion") %></span></p>
                    <p><strong>Teléfono:</strong> <span class="Telefono"><%= row("Telefono") %></span></p>
                    <% If Not IsDBNull(row("SocialMediaLink")) AndAlso row("SocialMediaLink").ToString() <> "" Then %>
                    <p><strong>Redes Sociales:</strong> <a href="<%= row("SocialMediaLink") %>"></a><span class="SocialMediaLink"><%= row("SocialMediaLink") %></span></p>
                    <p style="display:none" class="Coordenadas"><%= row("Coordenadas") %></p>
                    <p style="display:none" class="Popup_title"><%= row("Popup_title") %></p>
                    <p style="cursor:pointer" class="fly_to" onclick="fly_to('<%= row("Coordenadas") %>')"><img src="./static/img/irA.png" style="width: 40px; position: relative; top: 10px; left: -10px;" /> Ir a <%= row("Nombre_tienda") %></p>
                    <% End If %>
                </div>
                <%Next%>
            </div>
            <div style="display:none">
                <button onclick="ObtenerContactos()" class="btn btn-primary">Obtener Contactos</button>
                <button onclick="ActualizarContacto()" class="btn btn-primary">Actualizar Contacto</button>
                <button onclick="EliminarContacto()" class="btn btn-primary">Eliminar Contacto</button>
                <button onclick="ObtenerContactoPorId()" class="btn btn-primary">Obtener Contacto por ID</button>
            </div>
            <%-- fin tab--%>
        </form>
    </div>



    <br />
    <br />
    <br />


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
            position: relative; /* Ensure the map container has relative positioning */
            background: #f3f3f3;
            width: 100%;
            height: 450px;
            border-radius: 5px;
        }

        .control_1 {
            position: absolute; /* Position absolute to place it over the map */
            bottom: 24px; /* Adjust as needed */
            right: 10px; /* Adjust as needed */
            z-index: 1000; /* Ensure it has a high z-index */
            background: white;
            padding: 10px;
            border-radius: 5px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            width: 70px;
            height: 72px;
        }

        .control_2 {
            position: absolute; /* Position absolute to place it over the map */
            bottom: 105px; /* Adjust as needed */
            right: 10px; /* Adjust as needed */
            z-index: 1000; /* Ensure it has a high z-index */
            background: white;
            padding: 10px;
            border-radius: 5px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            width: 70px;
            height: 70px;
        }

        .control button {
            background: none;
            border: none;
            cursor: pointer;
        }

        .crosshair-cursor {
            cursor: crosshair;
        }
    </style>
</asp:Content>


<asp:Content runat="server" ContentPlaceHolderID="contenido_js">
    <script>
        var map
        $('document').ready(function () {
            let contactCards = [];
            // la funcion  contactCards recolecta la info de las CARDS y las guarda en el array para trasnformarlos en MARKERS
            contactCards = gatherContactCardInfo(contactCards)
            

            var addMarker = false;
            var markers = [];
            setTimeout(function () { addMarker = true }, 750)

            $('#addMarkerBtn').click(function () {
                setTimeout(function () { addMarker = true }, 250)
                $(this).prop('disabled', true);
                $('#map_local').addClass('crosshair-cursor'); // Añadir clase para cambiar el cursor
            });
            // Crear un icono personalizado con sombra
            var customIcon = L.icon({
                iconUrl: 'static/img/pinMapColor.png',
                shadowUrl: 'static/img/marker-shadow.png',
                iconSize: [65, 65], // tamaño del icono
                shadowSize: [65, 41], // tamaño de la sombra
                iconAnchor: [41, 41], // punto del icono que se corresponde con la posición del marcador
                shadowAnchor: [41, 41], // punto de la sombra que se corresponde con la posición del marcador
                popupAnchor: [-10, -34] // punto desde el cual se abrirá el popup relativo al icono
            });

            // Add markers to the map
            contactCards.forEach(function (info, index) {
                let latLng = extractLatLng(info.coordenadas);
                if (index === 0) {
                    map = L.map('map_local').setView(latLng, 15); // Iniciar en Buenos Aires
                    L.tileLayer('https://tile.openstreetmap.org/{z}/{x}/{y}.png', {
                        attribution: '&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors'
                    }).addTo(map);
                }
                let marker = L.marker(latLng, { icon: customIcon }).addTo(map);
                marker.bindPopup(`
                    <h5>${info.nombreTienda}</h5>
                    <p><strong>Dirección:</strong> ${info.direccion}</p>
                    <p><strong>Teléfono:</strong> ${info.telefono}</p>
                    <p><strong>Redes Sociales:</strong> <a href="${info.socialMediaLink}" target="_blank">${info.socialMediaLink}</a></p>
                    <p>${info.popupTitle}</p>
                               `);
            });

            map.on('click', function (e) {
                if (addMarker) {
                    var popupText = $('.Popup_title').val() || $('.Nombre_tienda').val() || "Colocá in título de POPUP";

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
                    // COLOCA LAS COORDENADAS EN EL INPUT DE GUARDADO
                    $('.Coordenadas').val(e.latlng)
                    //console.log('Coordinates:', e.latlng);
                    addMarker = false;
                    $('#addMarkerBtn').prop('disabled', false);
                    $('#popupText').val('');
                    $('#map_local').removeClass('crosshair-cursor'); // Quitar clase cuando se coloca el marcador
                }
            });///FIN MAPS
        })


        //ACIONES --------
        // Extract latitude and longitude from the coordinates string
        function extractLatLng(coordenadas) {
            let matches = coordenadas.match(/-?\d+\.\d+/g);
            return [parseFloat(matches[0]), parseFloat(matches[1])];
        }

        // Volar al marcador inicial
        function fly_to(coords) {
            var latLng = extractLatLng(coords);
            $('#map_local').focus()
            map.flyTo(latLng, 16);
        }

        function gatherContactCardInfo(contactCards) {
            // Iterate over each contact card
            $('.contact-card').each(function () {
                let card = $(this);
                let contactInfo = {
                    nombreTienda: card.find('.Nombre_tienda').text() ? card.find('.Nombre_tienda').text().trim() : "",
                    direccion: card.find('.Direccion').text() ? card.find('.Direccion').text().trim() : "",
                    telefono: card.find('.Telefono').text() ? card.find('.Telefono').text().trim() : "",
                    coordenadas: card.find('.Coordenadas').text() ? card.find('.Coordenadas').text().trim() : "",
                    popupTitle: card.find('.Popup_title').text() ? card.find('.Popup_title').text().trim() : "",
                    socialMediaLink: card.find('.SocialMediaLink').text() ? card.find('.SocialMediaLink').text().trim() : ""
                };

                // Push the contact info object into the array
                contactCards.push(contactInfo);
            });

            return contactCards;
        }

        function InsertarContacto() {
            if (!validarFormulario()) return // Si no logra validar retorna
            var Nombre_tienda = $('.Nombre_tienda').val()
            var Direccion = $('.Direccion').val()
            var Telefono = $('.Telefono').val()
            var SocialMediaLink = $('.SocialMediaLink').val()
            var Coordenadas = $('.Coordenadas').val()
            var Popup_title = $('.Popup_title').val()
            $.ajax({
                type: "POST",
                url: "Contacto.aspx/InsertarContacto",
                data: JSON.stringify({
                    Nombre_tienda: Nombre_tienda,
                    Direccion: Direccion,
                    Telefono: Telefono,
                    SocialMediaLink: SocialMediaLink,
                    Coordenadas: Coordenadas,
                    Popup_title: Popup_title
                }),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    if (response.d == "Registro insertado correctamente.") {
                        procesar_toast_time('Contacto guardado con éxito', 'success', 3000);
                        setTimeout(function () {
                            procesar_toast_time('Cargando información', 'info', 1500);
                        }, 3000);
                        setTimeout(function () {
                            window.location.href = 'contacto.aspx';
                        }, 4000);
                    }
                },
                error: function (xhr, status, error) {
                    procesar_toast('Error al enviar los datos', 'error');
                    console.warn(error);
                }

            });

        }


        function ObtenerContactos() {
            $.ajax({
                type: "POST",
                url: "Contacto.aspx/ObtenerContactos",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    var contactos = JSON.parse(response.d);

                    // Aquí puedes manejar los datos de los contactos
                    console.log(contactos);
                    // Por ejemplo, puedes iterar sobre los contactos y mostrarlos en la página
                    contactos.forEach(function (contacto) {
                        console.log(contacto.Nombre_tienda, contacto.Direccion, contacto.Telefono, contacto.SocialMediaLink, contacto.Coordenadas, contacto.Popup_title);
                    });
                },
                error: function (xhr, status, error) {
                    alert("Error: " + xhr.responseText);
                }
            });
        }

        function ActualizarContacto() {
            $.ajax({
                type: "POST",
                url: "Contacto.aspx/ActualizarContacto",
                data: JSON.stringify({
                    ID: 1,  // ID del registro que deseas actualizar
                    Nombre_tienda: "Tienda Actualizada",
                    Direccion: "Calle Actualizada 123",
                    Telefono: "+54 11 3265 5488",
                    SocialMediaLink: "https://www.example.com/updatedsocialmedia",
                    Coordenadas: "40.712776, -74.005975",
                    Popup_title: "Bienvenido a Tienda Actualizada"
                }),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    if (response.d == "Registro actualizado correctamente.") {
                        alert("Registro actualizado correctamente.");
                    } else {
                        alert(response.d);
                    }
                },
                error: function (xhr, status, error) {
                    alert("Error: " + xhr.responseText);
                }
            });

        }

        function EliminarContacto() {
            $.ajax({
                type: "POST",
                url: "Contacto.aspx/EliminarContacto",
                data: JSON.stringify({
                    ID: 1  // ID del registro que deseas eliminar
                }),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    if (response.d == "Registro eliminado correctamente.") {
                        alert("Registro eliminado correctamente.");
                    } else {
                        alert(response.d);
                    }
                },
                error: function (xhr, status, error) {
                    alert("Error: " + xhr.responseText);
                }
            });

        }

        function ObtenerContactoPorId() {
            $.ajax({
                type: "POST",
                url: "Contacto.aspx/ObtenerContactoPorId",
                data: JSON.stringify({
                    ID: 1  // ID del registro que deseas obtener
                }),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    if (response.d !== "No se encontró el registro." && !response.d.startsWith("Error: ")) {
                        var contacto = JSON.parse(response.d);
                        console.log(contacto);
                        // Aquí puedes manejar los datos del contacto
                        alert("Contacto encontrado: " + contacto.Nombre_tienda);
                    } else {
                        alert(response.d);
                    }
                },
                error: function (xhr, status, error) {
                    alert("Error: " + xhr.responseText);
                }
            });

        }

        function validarFormulario() {
            var isValid = true;

            // Validar cada campo con la clase 'form-control' y sus respectivas subclases
            $('.form-control').each(function () {
                if ($(this).val().trim() === '') {
                    var label = $(this).closest('.form-group').find('label').text();
                    label = label.replace(":", "")
                    procesar_toast('Completa el campo ' + label + ' para poder guardar', 'info');
                    $(this).closest('.form-group').find('input').focus()
                    isValid = false;
                    return false; // salir del bucle .each
                }
            });

            return isValid;
        }
    </script>
</asp:Content>
