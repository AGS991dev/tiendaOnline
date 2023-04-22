<%@ Page Language="VB" AutoEventWireup="false" MasterPageFile="~/master.master" CodeFile="access_recovery.aspx.vb" Inherits="access_recovery" %>

<asp:Content runat="server" ContentPlaceHolderID="contenido_css">
    <style>
        #nav_pages {
            display: none;
        }
    </style>
</asp:Content>

<asp:Content runat="server" ContentPlaceHolderID="contenido_body">
    <form runat="server" class="form-horizontal">
        <!--FORMULARIO-->
        <asp:ScriptManager runat="server"></asp:ScriptManager>

                <!--paso 1-->

                <div class="step_1"  id="step_1" runat="server">

                    <div class="container">
                        <h1 style="text-align: center">Olvidé mi contraseña</h1>
                        <p style="text-align: center">Este asistente lo guiará para reestablecer su clave de acceso. Ingresá tu cuil y hacé click en el botón Comenzar</p>


                        <div class="row">
                            <div class="col s12 m6">


                                <img src="static/img/asistente_1.png" style="width: 90%" />

                            </div>
                            <div class="col s12 m6">
                                <%-- <div class="card black white-text">
                                    <div class="card-content">
                                       
                                    </div>
                                </div>--%>
                                <br /><br /><br />
                                <div class="card">
                                    <br />
                                    <div class="input-field col s12">
                                        <asp:TextBox ID="txt_cuil" runat="server"></asp:TextBox>
                                        <label for="first_name">Cuil</label>
                                    </div>
                                    <div class="clearfix"></div>
                                    <div class="center">
                                        <asp:Button runat="server" class="btn" id="btn_comenzar" text="Comenzar" />
                                    </div>
                                    <div class="clearfix"></div>
                                    <br />
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

          <!--Paso  2-->
                        <div class="step_2" id="step_2" runat="server" visible="true">
                                <h1 style="text-align: center">Elegí una dirección de correo</h1>

                                <div class="container">
                                    <p style="text-align: center"></p>


                                    <div class="row">
                                        <div class="col s12 m6">


                                            <img src="static/img/asistente_2.png" style="width: 90%" />

                                        </div>
                                        <div class="col s12 m6">
                                            <div class="card black white-text">
                                                <div class="card-content">
                                                    ¿A qué correo electrónico queres recibir el email asistente para reestablecer tu contraseña?
                                                </div>
                                            </div>

                                            <div class="form-container">
                                                <div class="form-card">


                                                <div class="input-field col s12">
                                                    <label for="cbo_email" class="cbo_email" style="min-width: 90px;margin: 8px;position: relative;top: 5px;">Email :</label>

                                                    <asp:DropDownList runat='server' ID='cbo_email' style="margin:8px;max-width: 50%;min-width: 100px;" type='text' class='form-control input-md' MaxLength='200' />
                                                
                                                </div>


                                                    <div class="center">
                                                         <asp:Button runat="server" class="btn" id="btn_continuar" onClientClick="validar_step_2" text="Continuar" />
                                                    </div>
                                                    <br />
                                                    <br />
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                        </div>



        
    <!--Paso  3-->
            <div class="step_3" id="step_3" runat="server" visible="true">

                    <div class="container">
                        <h1 style="text-align: center">Asistente finalizado correctamente</h1>
                        <p style="text-align: center"></p>


                        <div class="row">
                            <div class="col s12 m6">


                                <img src="static/img/asistente_4.png" style="width: 90%" />

                            </div>
                            <div class="col s12 m6">
                                <%If emrpesa_id = "0" Then %>
                                <div class="card black white-text">
                                    <div class="card-content">
                                       Comunicate al correo de la empresa para solicitar restaurar tu contraseña.
                                    </div>
                                </div>
                                <% Else %>
                                 <div class="card black white-text">
                                    <div class="card-content">
                                       Completaste correctamente todos los pasos, Hemos enviado un Email Asistente a tu correo para reestablecer tu contraseña.
                                    </div>
                                 </div>
                                 <% End If %>

                                      <br />
                                        <br />

                                           <div class="center">
                                         <a href="login.aspx" class="btn">INGRESAR AL SISTEMA</a>
                                        </div>
                                               <br />
                                        <br />

                            </div>
                        </div>
                    </div>
                </div>
    </form>
    <!-- Fin Form -->


</asp:Content>

<asp:Content runat="server" ContentPlaceHolderID="contenido_js">
<script type="text/javascript">


        $('document').ready(function () {
            //$("#contenido_body_txt_cuil").mask("99-99999999-9", { "placeholder": "00-00000000-0", "positionCaretOnTab": false });
            var cleave = new Cleave('#contenido_body_txt_cuil', {
                numericOnly: true,
                blocks: [2, 8, 1],
                delimiter: '-',
                onValueChanged: function (e) {
                    //console.log(e.target) // e.target = { value: '5100-1234', rawValue: '51001234' }
                }
            });
        });



        function validar_step_2(destroyFeedback) {

            var cbo_email = $("#contenido_body_cbo_email").val();//paso 2
            
            if (cbo_email == "") {//paso 2
                show_alert("Formulario incompleto", "Debés seleccionar un email.", "warning");
                destroyFeedback(false);
                return false
            }
                       
            destroyFeedback(true);
            return true
            }// fin validar_step_2
        

    </script>
</asp:Content>
