<%@ Page Language="VB" AutoEventWireup="false" MasterPageFile="~/master.master" CodeFile="Frm_empleados.aspx.vb" Inherits="Frm_empleados" %>


<asp:Content runat="server" ContentPlaceHolderID="contenido_nav">
      <a href="supervisor_index.aspx" class="breadcrumb">INICIO</a>
    <a href="Grilla_Empleados.aspx" class="breadcrumb">Empleados</a>
    <a href="#!" class="breadcrumb">Formulario</a>
</asp:Content>

<asp:Content runat="server" ContentPlaceHolderID="contenido_body">

    <h1 class="center-align"><%=titulo %> </h1>
    <div style="display:flex; justify-content:center">
    </div><br />

        <div class="form-container">
        <div class="form-card">


                    <form runat="server" class="form-horizontal" autocomplete="off">
                <asp:ScriptManager runat="server"></asp:ScriptManager>
                <br />
                <div class="input-field tooltipped" data-position='top' data-tooltip='Cuil sin guiones' >
                    <asp:TextBox ID="txt_cuil" CssClass="cuil_consul" maxlength="11" runat="server"></asp:TextBox>
                    <label for="txt_cuil">Cuil</label>
                </div>

                <div class="div_fullname" >
                <br />
                    <div class="input-field ">
                        <asp:TextBox ID="txt_Nombre" runat="server"></asp:TextBox>
                        <label for="txt_Nombre">Nombre</label>
                    </div>
                    <br />
                    <div class="input-field ">
                        <asp:TextBox ID="txt_apellido" runat="server" ></asp:TextBox>
                        <label for="txt_apellido">Apellido</label>
                    </div>
                </div>
                <br />
                <div class="input-field txt_legajo">
                    <asp:TextBox ID="txt_legajo" runat="server"></asp:TextBox>
                    <label for="txt_legajo" runat="server" id="lbl_legajo">Legajo</label>
                </div>
                <br />

                <div class="input-field ">
                    <asp:TextBox ID="txt_email" runat="server"></asp:TextBox>
                    <label for="txt_email">Email</label>
                </div>

                <br />
                <br />
                 <div class="center-align" style="margin-bottom: 50px; margin-top: 20px;">
                    <a class="btn" href="Grilla_empleados.aspx">Atrás</a>
                    <asp:Button ID="btn_save" runat="server" Text="Guardar" CssClass="btn" onclientclick="return validar()"/>
                     <br />
                </div>



                </form>
              </div>

            
        </div>
    </div>

    <style>
        .acc_especiales{
            display: flex;
            justify-content: center;
            margin: -10px;
            position: relative;
            top: 20px;
        }
        .acc_esp_p{
            text-align:center;

        }
        .btn{
            margin:2px;
        }
        .div_fullname{
            justify-content:space-around
        }
    </style>

</asp:Content>

<asp:Content runat="server" ContentPlaceHolderID="contenido_js">
    <script type="text/javascript">

        $('document').ready(function () {
            //$("#contenido_body_txt_cuil").mask("99-99999999-9", { "placeholder": "00-00000000-0", "positionCaretOnTab": false });
            $('.tabs').tabs(); //tabs de materialize

            $('[tabindex]').click(function () {
                if (this.children[0].textContent != 'Admin') {
                    $('.cbo_empresa').show(250);
                } else {
                    $('.cbo_empresa').hide(250);
                }
            });
         });
        //funcion validar formulario
        function validar() {
            var nombre = $("#contenido_body_txt_Nombre").val();
            var apellido = $("#contenido_body_txt_apellido").val();
            var pass = $("#contenido_body_txt_pass").val();
            var cuil = $("#contenido_body_txt_cuil").val();
            var empresa_id = '<%= cls_security.usuario_actual.empresa_id %>'
            var cuilSinGuiones = cuil.replace("-", "")
            cuilSinGuiones = cuilSinGuiones.replace("-", "")

            var emailEmpleado = $("#contenido_body_txt_email").val();

            if (nombre == "") {
                show_alert("Formulario incompleto", "Ingrese el Nombre.", "warning");
                return false;
            }

            if (apellido == "") {
                show_alert("Formulario incompleto", "Ingrese el Apellido.", "warning");
                return false;
            }

            if (emailEmpleado == "") {
                show_alert("Formulario incompleto", "Ingrese el Email.", "warning");
                return false;
                //alert(emailEmpleado)

            } else {
                var validacion = validarEmail(emailEmpleado)
                if (validacion == false) {
                    return false
                }
            }

            if (pass == "") {
                show_alert("Formulario incompleto", "Ingrese una Contraseña.", "warning");
                return false;
            }
            if (cuilSinGuiones == "00000000000") {
                show_alert("Formulario incompleto", "Ingrese un Cuil", "warning");
                return false;
            }

            if (cuil == "") {
                show_alert("Formulario incompleto", "Ingrese un Cuil", "warning");
                return false;
            } //fin validar
        }





    </script>


</asp:Content>
