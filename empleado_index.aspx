<%@ Page Language="VB" AutoEventWireup="false" MasterPageFile="~/master.master" CodeFile="empleado_index.aspx.vb" Inherits="empleado_index" %>

<asp:Content runat="server" ContentPlaceHolderID="contenido_nav">
    <%If cls_security.usuario_actual.es_supervisor = True Then %>
        <a href="supervisor_index.aspx" class="breadcrumb"><i style="font-size: 40px;margin-right: 10px;" class="material-icons">apps</i> Panel Supervisor</a>
    <% Else %>
    <a href="empleado_index.aspx" class="breadcrumb">Inicio</a>
    <% End If %>
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="contenido_body">


    <% If Not IsNothing(Session("usuario_actual")) And cls_security.usuario_actual.logo <> "" Then  %>
         <div style="display:flex;justify-content:center">
            <div class="logo_empresas zoomIn" style="background:url(<%=cls_security.usuario_actual.logo %>);background-size: cover;float: right;background-position: center;"></div>
         </div>
    <%Else %>
    <h4 style="margin: 30px 20px ; text-align: center;"><%=cls_security.usuario_actual.razon_social%></h4>
    <%End If%>


  <h1 class="center-align " style="margin:10px" >Bienvenido <%= cls_security.usuario_actual.nombre %> <%= cls_security.usuario_actual.apellido %></h1>  

  <form id="form" runat="server">
  <div class="container" style="margin-top: 10px">


          <div style="margin: 20px auto; text-align:center;">
              <%If entrego_autorizacion = "NO" Then%>
              <div class="card red">
                      <div class="card-content white-text">
                        <span class="card-title">Autorización pendiente</span>
                        <p class="white-text">Aún no entregó la declaración jurada para autorizar su firma electrónica.</p>
                      </div>
                      <div class="card-action">
                          <% If certificado_id = 0 Then %>
                        <p class="white-text tooltipped" data-position='bottom' data-tooltip="Ha sido enviado un email a su casilla de correo para generar su certificado" style="position: relative;left: 10px;" >Debés Generar Tu Certificado</p>
                              <% else %>
                        <a class="white-text" style="position: relative;left: 10px;" href="imprimir.aspx?reporte=autorizacion&pk=<%=certificado_id%>">Imprimir Autorizacion</a>
                          <% End If %>
                      </div>
               </div>
              <%else%>
            <a href="Frm_ver_certificado_empleado.aspx?id=<%= certificado_id %>" class="btn">Ver Certificado</a>
              <%End If %>
          </div>



   <div class="row">
    <div class="">
      <ul class="tabs">
        <li class="tab col m6"><a  class="active" href="#tab_doc_s_firma">Mis Documentos Sin Firmar</a></li>
        <li class="tab col m6"><a href="#tab_doc_firmado">Firmados</a></li>
      </ul><br />
    </div>
       
    <div id="tab_doc_s_firma" >
        <% If docs_sin_firmar_row = 0 Then%><!--Si no hay rows mostrar template de card materialize-->
        <div class="docs_sin_firmar_template"><%= docs_sin_firmar_template %></div>
        <%Else %>
                        <asp:GridView ID="GV_docs_sin_firma" runat="server" AutoGenerateColumns="false" class="striped" CellSpacing='0' Width='100%'>
                            <Columns>
                                <asp:BoundField DataField="id" HeaderText="ID" />
                                <asp:BoundField DataField="lote" HeaderText="Lote" />
                                <asp:BoundField DataField="concepto" HeaderText="Concepto" />
                                <asp:BoundField DataField="observaciones" HeaderText="observaciones" />
                                <asp:BoundField DataField="mes" HeaderText="Mes" />
                                <asp:BoundField DataField="año" HeaderText="Año" />
                                <asp:TemplateField HeaderText="Acciones">
                                    <ItemTemplate>
                                        <span class='btn-ver waves-effect waves-light btn-small tooltipped card_color' data-position='top' data-tooltip='VER' ><i class='material-icons'>remove_red_eye</i></span>
                                        <!--<asp:Button ID="btn_firmar" runat="server" Text="Firmar" CssClass="btn" />-->
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                         </asp:GridView>
                <br />
        <% End If%>
        </div>  
        <!--frm_previsualizar_pdf.aspx/-->
        <!--%= docs_sin_firmar %>-->
    <div id="tab_doc_firmado" class="striped">
        <% If docs_firmados_row = 0 Then%><!--Si no hay rows mostrar template de card materialize-->
        <div class="docs_firmados_template"><%= docs_firmados_template %></div>
        <%Else %>
                         <asp:GridView ID="GV_docs_con_firma" runat="server" AutoGenerateColumns="false" class="striped" CellSpacing='0' Width='100%'>
                            <Columns>
                                <asp:BoundField DataField="id" HeaderText="ID" />
                                <asp:BoundField DataField="lote" HeaderText="Lote" />
                                <asp:BoundField DataField="concepto" HeaderText="Concepto" />
                                <asp:BoundField DataField="observaciones" HeaderText="observaciones" />
                                <asp:BoundField DataField="mes" HeaderText="Mes" />
                                <asp:BoundField DataField="año" HeaderText="Año" />
                                <asp:BoundField DataField="Firmado_el_día" HeaderText="Fecha del Firmado" />
                                <asp:TemplateField HeaderText="Acciones">
                                    <ItemTemplate>
                                        <span class='btn-ver waves-effect waves-light btn-small tooltipped card_color' data-position='top' data-tooltip='VER' ><i class='material-icons'>remove_red_eye</i></span>
                                        <!--<asp:Button ID="btn_firmar" runat="server" Text="Firmar" CssClass="btn" />-->
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                         </asp:GridView>
        <% End If%>

    </div>

    </div>
  </div>

    </form>
    <br />

        <style>
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

    <script type="text/javascript" src="static/js/main.js"></script>
 </asp:Content>

    <asp:Content runat="server" ContentPlaceHolderID="contenido_js">

    <script type="text/javascript">
        $(document).ready(function () {

            sessionStorage.setItem('loteID', null)//para hacer el boton de atras en el documento

            var toast_denegado = "<%= Session("toast_denegado") %>"
            <% Session("toast_denegado") = ""%>
            //console.log(toast_denegado)
            if (toast_denegado != "") {
            procesar_toast(toast_denegado, "error")
            }


            $('.tabs').tabs();//Hacen funcionar las Tabs

            
            $('.btn-ver').click(function () {
                var id_btn_ver = this.parentElement.parentElement.children[0].textContent
                //alert(id_btn_ver)
                window.location.href = "frm_previsualizar_pdf.aspx?id=" + id_btn_ver;
            });//al click en ver visualizar





            $('td:nth-child(1)').hide()//
            $('th:nth-child(1)').hide()//borro primera columna

           $(".card-panel").hide();

           //css_empresa_li()

        });//cierra document ready

        

        //function btn_empresa(obj) {
        //var empresa_id = $(obj).attr("empresa_id")
        //console.log(empresa_id)
        //var result;
        //var cuilSinGuiones = <%= cls_security.usuario_actual.cuil%>
        //$.ajax({//me fijo si ya existe este cuil
        //type: "POST",
        //url: "empleado_index.aspx/recargar_usuario",
        //data: '{cuil: "' + cuilSinGuiones + '", empresa_id: "' + empresa_id + '" }',
        //async: false,
        //contentType: "application/json; charset=utf-8",
        //dataType: "json",
        //success: function (response) {
        //result = response.d;
        //if (result == 0) {
        //show_alert("Hubo un Problema al cargar la Empresa seleccionada", "Vuelve a intentar.", "warning");
        //return false
        //}
        //}
        //});
        //window.location.href = "/empleado_index.aspx";
        //return result == 1;
        //}

    </script>

</asp:Content>
    
