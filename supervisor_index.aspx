<%@ Page Language="VB" AutoEventWireup="false" MasterPageFile="~/master.master" CodeFile="supervisor_index.aspx.vb" Inherits="supervisor_index" %>


<asp:Content runat="server" ContentPlaceHolderID="contenido_nav">
    <a href="supervisor_index.aspx" class="breadcrumb">Inicio</a>
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="contenido_body">

    <% If Not IsNothing(Session("usuario_actual")) And cls_security.usuario_actual.logo <> "" Then  %>



        <div style="display:flex;justify-content:center">
            <br /><div class="logo_empresas zoomIn" style="background:url(<%=cls_security.usuario_actual.logo %>);background-size: cover;float: right;margin: 15px;background-position: center;"></div>
        </div>
    <%Else %>
    <center>
        <br/>
    <img src="./static/img/familiarmente.png" style="width: 250px;"/>
    </center>
    <br />
    <h4 style="margin: 30px 20px ; text-align: center;display:none"><%=cls_security.usuario_actual.razon_social%></h4>
    <%End If%>


     <div class="tarjetaUsuario" style="display:none">
            <p>Nombre:<b><%=cls_security.usuario_actual.perfil.descripcion %> <%=cls_security.usuario_actual.nombre %> </b></p>
        <div class="detalles" style="display:none">
            <p>ID:<b><%=cls_security.usuario_actual.id%></b></p>
            <p>Apelldio:<b><%=cls_security.usuario_actual.apellido%></b></p>
            <p>Cuit/Cuil:<b><%=cls_security.usuario_actual.cuil %></b></p>
            <p>Logo:<b><%=cls_security.usuario_actual.logo %></b></p>
            <p>Razon Social:<b><%=cls_security.usuario_actual.razon_social%></b></p>
        </div>
    </div>
   
    
    <div class="container" style="margin-top:10px">

            <div class="row">
            <div class="col m10 l8 offset-l2 offset-m1 s12">


            <div class="col m4 s6 zoom">
                <a href="./shop.aspx">
                    <div class="card-panel card-menu center white-text hoverable">
                        <img src="./static/img/supermercado.png" style="width: 60px;"/>
                       <p>Tienda Online</p>
                    </div>

                </a>
            </div>

            <div class="col m4 s6 zoom">
                <a href="./Grilla_Stock.aspx">
                    <div class="card-panel card-menu center white-text hoverable">
                       <img src="./static/img/almacen.png" style="width: 60px;"/>


                        <p>Stock</p>
                    </div>
                </a>
            </div>

            <div class="col m4 s6 zoom">
                <div style="width: 100%; position: relative; display: flex; justify-content: flex-end; right: 40px;top: -20px;">
                <a href="./Grilla_pedidos.aspx">
                    <% if pedidos_pendientes > 0 Then%>
                    <span class="badge_pendientes rubberBand"><%=pedidos_pendientes %></span>
                    <% End if %>
                </div>
                    <div class="card-panel card-menu center white-text hoverable">
                        <img src="./static/img/camion.png" style="width: 60px;"/>
                        <p>Pedidos</p>
                    </div>
                </a>
            </div>
            
            <div class="col m4 s6 zoom">
                <a href="./Grilla_caja.aspx">
                    <div class="card-panel card-menu center white-text hoverable">
                          <img src="./static/img/cash.png" style="width: 60px;"/>
                        <p>Caja</p>
                    </div>
                </a>
            </div>

            <div class="col m4 s6 zoom">
                <a href="./grilla_consulta.aspx">
                    <div class="card-panel card-menu center white-text hoverable">
                        <img src="./static/img/finanza.png" style="width: 60px;"/>
                       <p>Consultas</p>
                    </div>

                </a>
            </div>

            <div class="col m4 s6 zoom">
                <a href="./c_movimientos.aspx">
                    <div class="card-panel card-menu center white-text hoverable">
                        <img src="./static/img/gasto.png" style="width: 60px;"/>
                       <p>Movimientos</p>
                    </div>

                </a>
            </div>

            <div style="display:none" class="col m4 s6 zoom">
                <a href="./Grilla_empleados.aspx">
                    <div class="card-panel card-menu center white-text hoverable">
                        <img src="./static/img/emp.png" style="width: 60px;"/>
                       <p>Empleados</p>
                    </div>

                </a>
            </div>



            <div class="col m4 s6 zoom">
                <a href="./grilla_categorias.aspx">
                    <div class="card-panel card-menu center white-text hoverable">
                        <img src="./static/img/categorias.png" style="width: 60px;"/>
                       <p>Categorias de Productos</p>
                    </div>

                </a>
            </div>

            <div class="col m4 s6 zoom">
                <a href="./grilla_ranking.aspx">
                    <div class="card-panel card-menu center white-text hoverable">
                        <img src="./static/img/ranking.png" style="width: 60px;"/>
                       <p>MÁS VENDIDOS</p>
                    </div>

                </a>
            </div>

            <div class="col m4 s6 zoom">
                <a href="./grilla_whatsapp.aspx">
                    <div class="card-panel card-menu center white-text hoverable">
                        <img src="./static/img/wp.png" style="width: 60px;"/>
                       <p>Whatsapp</p>
                    </div>

                </a>
            </div>


            </div>
            </div>
         

    </div>
    <br />

<style>
    .badge_pendientes{
    background: #ff4f42;
    position: absolute;
    padding: 0px 18px 0px  15px;
    border-radius: 25px;
    font-size: 30px;
    box-shadow: rgb(0 0 0 / 40%) 0px 2px 4px, rgb(0 0 0 / 30%) 0px 7px 13px -3px, rgb(0 0 0 / 20%) 0px -3px 0px inset;
    color:white;
    font-family:'Bangers', cursive;
    }
    
        .logo_empresas{
                position: relative;
                top: 5px;
                width: 125px;
                height: 125px;
                border-radius: 3px;
        }
               .zoomIn {
  -webkit-animation-name: zoomIn;
  animation-name: zoomIn;
  -webkit-animation-duration: 1s;
  animation-duration: 1s;
  -webkit-animation-fill-mode: both;
  animation-fill-mode: both;
  }
  @-webkit-keyframes zoomIn {
  0% {
  opacity: 0;
  -webkit-transform: scale3d(.3, .3, .3);
  transform: scale3d(.3, .3, .3);
  }
  50% {
  opacity: 1;
  }
  }
  @keyframes zoomIn {
  0% {
  opacity: 0;
  -webkit-transform: scale3d(.3, .3, .3);
  transform: scale3d(.3, .3, .3);
  }
  50% {
  opacity: 1;
  }
  } 
</style>

    <script type="text/javascript">

        $(document).ready(function () {
            $('.tarjetaUsuario').click(function () {
                $('.detalles').toggle(500);
            });

            var legajo = '<%=cls_security.usuario_actual.legajo%>'
            if (legajo == '---') {
                $('.btn_mis_documentos').hide();
            }//si el legajo es --- no tendra documentos


        });

        $('.btn_mis_documentos').click(function () {
            
            $.ajax({
                type: "POST",
                url: "supervisor_index.aspx/mis_documentos",
                data: '{codigo: "0", objid: "0" }',
                async: false,
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    result = response.d;
                    if (result == 0) {
                        show_alert("Es necesario que Actualices tus Contraseñas con el Asistente", "Busca en tu casilla de correo un email de <%= ConfigurationManager.AppSettings("title").ToString()%>.", "warning");
                        return false
                    } else {
                        window.location.href = 'empleado_index.aspx';
                    }
                }
            });


        });
    </script>
</asp:Content>
