<%@ Page Language="VB" AutoEventWireup="false" MasterPageFile="~/master.master"   CodeFile="Grilla_Empleados.aspx.vb" Inherits="Grilla_Empleados" %>


<asp:Content runat="server" ContentPlaceHolderID="contenido_nav">
    <a href="supervisor_index.aspx" class="breadcrumb">INICIO</a>
    <a href="frm_<%=Titulo%>.aspx" class="breadcrumb"><%=titulo %></a>
</asp:Content>

<asp:Content runat="server" ContentPlaceHolderID="contenido_body">

    <form id="grilla" runat="server">

        <div class="container-lg ">
            <a href="frm_<%=Titulo %>.aspx" class="btn-add tooltipped fadeInRightBig" data-position='top' data-tooltip='Agrega Manualmente de a un Empleado'><i class="material-icons " style="font-size: 30px;margin-right: 4px;margin-top: 11px;">person_add</i></a>

             
            <h1><%=Titulo %></h1><br />
                    <asp:ScriptManager runat="server" ID="ScriptManager1"></asp:ScriptManager>
                                        <asp:Button style="margin: 8px;position: relative;top: -2px;" ID="btn_reenviar_mail" runat="server"  CssClass="btn btn-info" Text="Reenviar Mail a Empleados en proceso" />
                    <br />
                        <div style="display:flex">
                            <div class="combos_empleados">
                            <label for="cbo_estado" class="cbo_estado" style="min-width: 90px;margin: 8px;position: relative;top: 5px;">Estado:</label>
                            <asp:DropDownList runat='server' ID='cbo_estado' style="margin:8px;max-width: 50%;min-width: 100px;" type='text' class='form-control input-md' MaxLength='200' />
                            </div>
                            <asp:Button style="margin: 20px;position: relative;top: 5px;" ID="btn_filtrar" runat="server" name="btn_filtrar" OnClientClick="modal_espere_on()" CssClass="btn btn_filtrar btn-info" Text="Actualizar" />
                        </div>
            
            <br />
            <% If not tabla Is Nothing Then %>
            
            <%  Else %>
                        <asp:UpdatePanel ID="panel_empleados" runat="server" UpdateMode="Conditional">

                                <ContentTemplate>
                            <!---->
                            <div><%= tabla %></div>
                            <ASP:GridView ID ="GV_empleados" runat="server" class="striped" AutoGenerateColumns="false"  CellSpacing='0' Width='100%'>
                            <Columns>
                                
                                <ASP:BoundField DataField = "Estado" htmlencode="false" HeaderText="Estado" />
                                <ASP:BoundField DataField = "Nombre_Y_Apellido" htmlencode="false" HeaderText="Nombre y Apellido" />
                                <ASP:BoundField DataField = "legajo" htmlencode="false" HeaderText="Legajo" />
                                <ASP:BoundField DataField = "Cuil" htmlencode="false" HeaderText="Cuil" />
                                
                                <ASP:TemplateField HeaderText = "Acciones" >
                                    <ItemTemplate>
                                        <a href='Frm_Empleados_info.aspx?id=<%#Eval("id")%>' ><span class='waves-effect waves-light btn-small tooltipped card_color' data-position='top' data-tooltip='Ver' ><i class='material-icons'>remove_red_eye</i></a>
                                        <span id='btn_delete' own_cuil='<%=cls_security.usuario_actual.cuil%>' cuil='<%#Eval("cuil")%>' url='Grilla_empleados.aspx' obj_id='<%#Eval("id")%>' onclick='eliminar_registro_conCUIL_msg(this,"Registro Eliminado Correctamente");' ><span class='waves-effect waves-light red btn-small tooltipped' data-position='top' data-tooltip='Eliminar' ><i class='material-icons'>delete</i></span>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                
                            </Columns>
                         </asp:GridView>
                         <!---->
                                </ContentTemplate>
                                         <Triggers>
                                            <asp:AsyncPostBackTrigger ControlID="btn_filtrar" EventName="Click" />
                                        </Triggers>
                            </asp:UpdatePanel>
            <%  End If %>
        </div>


    </form>


    <style>
        .btn-add{
            margin:2px;
        }
        th, td {
            text-align:center;
        }
        tr:hover{
            background: #fcfcfc;
        }
        td a{
            color: #4CAF50;
            font-weight: 700;
        }
    </style>
</asp:Content>


<asp:Content runat="server" ContentPlaceHolderID="contenido_js">
    <script type="text/javascript">

        function modal_espere_off() {
            $('#espere').modal('close');
        }

            function refresh_filter(){
            var selector = $('.striped')
            inicializar_grilla(selector);
            }
        $('document').ready(function () {
            refresh_filter();
            

            $('.modal').modal();


            var toast_denegado = "<%= Session("toast_denegado") %>"
            <% Session("toast_denegado") = ""%>
            //console.log(toast_denegado)
            if (toast_denegado != "") {
            procesar_toast(toast_denegado, "warning")
            }


            //$('td:nth-child(1)').hide()//
            //$('th:nth-child(1)').hide()//borro primera columna
        });



        function modal_espere_on() {
            $('#espere').modal({ dismissible: false });
            $('#espere').modal('open');
        }

        //$('#txt_buscar').keyup(function (e) { 
        //    e.preventDefault();
        //    var caracteres = $('#txt_buscar').val();
        //    caracteres = caracteres.toLowerCase();
        //    var td = $("td[data-th='Nombre y Apellido']")
        //    //console.log(caracteres)
        //    for (i = 0; i <= td.length - 1; i++) {
        //        var empleado = $(td[i]).attr('Nombre y Apellido')
        //        empleado = td[i].textContent
        //        empleado = empleado.toLowerCase().includes(caracteres);// reviso si coincide con los caracteres
        //        var tr = $(td[i])
        //        tr = tr[0].parentElement
        //        if (empleado == false) { // si no hay coincidencia lo escondo
        //            $(tr).hide();
        //        } else {
        //            $(tr).show(); // sino lo muestro
        //        }
        //    }/* FIN CICLO FOR */

        //});
        
     </script>
                            
</asp:Content>