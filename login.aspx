<%@ Page Language="VB" AutoEventWireup="false" MasterPageFile="~/master.master" CodeFile="login.aspx.vb" Inherits="login" %>



<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="contenido_body">


    <div class="container">

        <form runat="server" id="form_login" autocomplete="off">

            <div class="row" style="margin-top: 100px">

                <div class="col m6 s12">

                    <div class="form-card zoomInUp" style="border-radius:2px">
                        <div class="center-align">
                            <h3>Bienvenido/a</h3>

                        </div>
                    <div class="input-field col s12">
                        <asp:TextBox ID="txt_usuario" runat="server" type="tel" maxlength="11"></asp:TextBox>
                        <label for="txt_usuario">Código</label>
                    </div>

                        <div class="input-field col s12">
                            <asp:TextBox TextMode="Password" ID="txt_pass" runat="server"></asp:TextBox>
                            <label for="txt_pass">Password</label>
                        </div>

                        <div class="center-align col s12" style="margin-bottom: 50px; margin-top: 20px;">
                            <asp:Button ID="btn_aceptar" runat="server" Text="Ingresar" CssClass="btn" />
                        </div>

                        <%If show_alert_error.Value = "true" Then%>
                        <div class="row center-align">
                            <div class="col s12">
                                <div class="card-panel red lighten-1">
                                    <span class="white-text">Los datos ingresados son incorrectos. Por favor verifique el nombre de usuario y la contraseña y vuelva a intentarlo</span>
                                </div>

                            </div>
                        </div>
                        <%End If%>
                        <%If show_alert_pass.Value = "true" Then%>
                        <div class="row center-align">
                            <div class="col s12">
                                <div class="card-panel orange lighten-1">
                                    <span class="white-text">Debés Restaurar tu Contraseña, Por favor revisá en tu casilla de correo un Email de <b><%=Title %></b> con instrucciones de como hacerlo</span>
                                </div>

                            </div>
                        </div>
                        <%End If%>
                        <div class="center">
                        <!--<a href="access_recovery.aspx" class="access_recovery">Olvidé mi contrseña.</a>-->
                        </div>
                    
                    </div>
                    
                </div>
                <div class="col m6 s12">
                    <div class="animated flip" style="display:flex; height:422px; justify-content:center; align-content:center; align-items:center; flex-direction:column">


                            <% If Session("system_name") = "firma_nativa" Then %>
                            <img src="static/img/familiarmente.png" style="max-width: 80%" alt="FirmaNativa" />
                            <% End If %>
                    </div>
                        

                </div>

            </div>


            <asp:HiddenField runat="server" ID="show_alert_error" Value="false" />
            <asp:HiddenField runat="server" ID="show_alert_pass" Value="false" />

        </form>
                                        

    </div>
<br />

    <style>
                  .zoomInDown {
  -webkit-animation-name: zoomInDown;
  animation-name: zoomInDown;
  -webkit-animation-duration: 1s;
  animation-duration: 1s;
  -webkit-animation-fill-mode: both;
  animation-fill-mode: both;
  }
  @-webkit-keyframes zoomInDown {
  0% {
  opacity: 0;
  -webkit-transform: scale3d(.1, .1, .1) translate3d(0, -1000px, 0);
  transform: scale3d(.1, .1, .1) translate3d(0, -1000px, 0);
  -webkit-animation-timing-function: cubic-bezier(0.550, 0.055, 0.675, 0.190);
  animation-timing-function: cubic-bezier(0.550, 0.055, 0.675, 0.190);
  }
  60% {
  opacity: 1;
  -webkit-transform: scale3d(.475, .475, .475) translate3d(0, 60px, 0);
  transform: scale3d(.475, .475, .475) translate3d(0, 60px, 0);
  -webkit-animation-timing-function: cubic-bezier(0.175, 0.885, 0.320, 1);
  animation-timing-function: cubic-bezier(0.175, 0.885, 0.320, 1);
  }
  }
  @keyframes zoomInDown {
  0% {
  opacity: 0;
  -webkit-transform: scale3d(.1, .1, .1) translate3d(0, -1000px, 0);
  transform: scale3d(.1, .1, .1) translate3d(0, -1000px, 0);
  -webkit-animation-timing-function: cubic-bezier(0.550, 0.055, 0.675, 0.190);
  animation-timing-function: cubic-bezier(0.550, 0.055, 0.675, 0.190);
  }
  60% {
  opacity: 1;
  -webkit-transform: scale3d(.475, .475, .475) translate3d(0, 60px, 0);
  transform: scale3d(.475, .475, .475) translate3d(0, 60px, 0);
  -webkit-animation-timing-function: cubic-bezier(0.175, 0.885, 0.320, 1);
  animation-timing-function: cubic-bezier(0.175, 0.885, 0.320, 1);
  }
  } 

         .zoomInUp {
  -webkit-animation-name: zoomInUp;
  animation-name: zoomInUp;
  -webkit-animation-duration: 1s;
  animation-duration: 1s;
  -webkit-animation-fill-mode: both;
  animation-fill-mode: both;
  }
  @-webkit-keyframes zoomInUp {
  0% {
  opacity: 0;
  -webkit-transform: scale3d(.1, .1, .1) translate3d(0, 1000px, 0);
  transform: scale3d(.1, .1, .1) translate3d(0, 1000px, 0);
  -webkit-animation-timing-function: cubic-bezier(0.550, 0.055, 0.675, 0.190);
  animation-timing-function: cubic-bezier(0.550, 0.055, 0.675, 0.190);
  }
  60% {
  opacity: 1;
  -webkit-transform: scale3d(.475, .475, .475) translate3d(0, -60px, 0);
  transform: scale3d(.475, .475, .475) translate3d(0, -60px, 0);
  -webkit-animation-timing-function: cubic-bezier(0.175, 0.885, 0.320, 1);
  animation-timing-function: cubic-bezier(0.175, 0.885, 0.320, 1);
  }
  }
  @keyframes zoomInUp {
  0% {
  opacity: 0;
  -webkit-transform: scale3d(.1, .1, .1) translate3d(0, 1000px, 0);
  transform: scale3d(.1, .1, .1) translate3d(0, 1000px, 0);
  -webkit-animation-timing-function: cubic-bezier(0.550, 0.055, 0.675, 0.190);
  animation-timing-function: cubic-bezier(0.550, 0.055, 0.675, 0.190);
  }
  60% {
  opacity: 1;
  -webkit-transform: scale3d(.475, .475, .475) translate3d(0, -60px, 0);
  transform: scale3d(.475, .475, .475) translate3d(0, -60px, 0);
  -webkit-animation-timing-function: cubic-bezier(0.175, 0.885, 0.320, 1);
  animation-timing-function: cubic-bezier(0.175, 0.885, 0.320, 1);
  }
  } 
    </style>


</asp:Content>

<asp:Content runat="server" ContentPlaceHolderID="contenido_js">
    <script type="text/javascript">

        
       // var num = 999995

       // var arrSecuencia = []
        
        //function cuenta(num) {
        //    if (num % 2 == 0) {// ES PAR
        //        var num = num / 2
        //        return num
        //    }
        //    else {// ES IMPAR
        //        var num = 3 * num + 1
        //        return num
        //    }
        //}


        $('document').ready(function () {




            //$("#contenido_body_txt_usuario").mask("99-99999999-9", { "placeholder": "00-00000000-0", "positionCaretOnTab": false });
        });


            //for (i = num; i != 1; i = num) {
            //    num = cuenta(num)
            //    arrSecuencia.push(num)

            //}
            //console.log(arrSecuencia)
            //console.log(arrSecuencia.length)



     </script>
</asp:Content>
