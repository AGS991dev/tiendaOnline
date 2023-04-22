<%@ Page Language="VB" AutoEventWireup="false" MasterPageFile="~/master.master" CodeFile="Frm_Usuarios.aspx.vb"
    Inherits="Frm_Usuarios" %>

<asp:Content runat="server" ContentPlaceHolderID="contenido_nav">
    <a href="admin_index.aspx" class="breadcrumb">INICIO</a>
    <a href="Grilla_Usuarios.aspx" class="breadcrumb">Usuarios</a>
    <a href="#!" class="breadcrumb">Formulario</a>
</asp:Content>

<asp:Content runat="server" ContentPlaceHolderID="contenido_body">

    <h1 class="center-align"><%=titulo %> </h1>

    <div class="form-container">
        <div class="form-card">

            <form runat="server" class="form-horizontal" autocomplete="off">
                <asp:ScriptManager runat="server"></asp:ScriptManager>
                <div class="input-field tooltipped" data-position='top' data-tooltip='Cuil sin guiones' >
                    <asp:TextBox ID="txt_cuil" CssClass="cuil_consul" maxlength="11" runat="server"></asp:TextBox>
                    <label for="txt_cuil">Cuil</label>
                </div>
                <br />

                <div class="div_fullname" >
                <br />
                    <div class="input-field ">
                        <asp:TextBox ID="txt_Nombre" runat="server" ></asp:TextBox>
                        <label for="txt_Nombre">Nombre</label>
                    </div>
                    <div class="input-field ">
                        <asp:TextBox ID="txt_apellido"  runat="server" ></asp:TextBox>
                        <label for="txt_apellido">Apellido</label>
                        
                    </div>
                </div>
                <br />

                <div class="input-field txt_email">
                    <asp:TextBox ID="txt_email" runat="server"></asp:TextBox>
                    <label for="txt_email">Email</label>
                </div>
                <br />

                <div class="input-field cbo_perfil ">
                    <asp:DropDownList ID="cbo_perfil" runat="server"></asp:DropDownList>
                    <label for="cbo_perfil">Perfil</label>
                </div>
                <br>
                <span class="cbo_empresa_label" style="position: relative;top: -8px;color:#8a8a8a;">Empresa</span>
                <div class="input-field cbo_empresa">
                    <asp:DropDownList ID="cbo_empresa" runat="server"></asp:DropDownList>
                </div>
                <br />
                <div class="input-field ">
                    <label style="position:relative">
                    <asp:CheckBox ID="check_box_A"  runat="server" Checked='true' AutoPostBack="false" />
                    <asp:CheckBox ID="check_box_B" cssclass="check" runat="server" Checked='true' AutoPostBack="false" />
                    </label>
                    <span style="position: relative;top: -8px;color:#8a8a8a;">  Firmará Documentos en esta empresa</span>
                </div>
                <br>
                <div class="input-field ">
                    <asp:TextBox ID="txt_legajo" runat="server"></asp:TextBox>
                    <label for="txt_legajo">Legajo</label>
                </div>
                <br />


                
                <div class="center-align" style="margin-bottom: 50px; margin-top: 20px;">
                    <a class="btn" href="Grilla_Usuarios.aspx">Atrás</a>
                    <asp:Button ID="btn_save" runat="server" Text="Guardar" CssClass="btn" onclientclick="return validar()" />

                </div>

                <br /><br />

            </form>
        </div>
    </div>

    <style>
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

            //var a = $('.cbo_perfil');
        //console.log(a[0].children)
        //CONSULTA EMPLEADO A AFIP
       
        //funcion validar formulario
        function validar() {
            var legajo = $("#contenido_body_txt_legajo").val();
            var pass = $("#contenido_body_txt_pass").val();
            var nombre = $("#contenido_body_txt_Nombre").val();
            var apellido = $("#contenido_body_txt_apellido").val();
            var cuil = $("#contenido_body_txt_cuil").val();
            var emailEmpleado = $("#contenido_body_txt_email").val();
            var empresa_id = $("#contenido_body_cbo_empresa").val();
            var cuilSinGuiones = cuil.replace("-", "")
            cuilSinGuiones = cuilSinGuiones.replace("-", "")

            if (legajo == "") {
                show_alert("Formulario incompleto", "Ingrese el Legajo.", "warning");
                return false;
            }

            if (nombre == "") {
                show_alert("Formulario incompleto", "Ingrese el Nombre.", "warning");
                return false;
            }

            if (apellido == "") {
                show_alert("Formulario incompleto", "Ingrese el Apellido.", "warning");
                return false;
            }

            if (pass == "") {
                show_alert("Formulario incompleto", "Ingrese una Contrasña.", "warning");
                return false;
            }

            if (emailEmpleado == "") {
                show_alert("Formulario incompleto", "Ingrese el Email.", "warning");
                return false;
            } else {
                var validacion = validarEmail(emailEmpleado)
                if (validacion == false) {
                    return false
                }
            }


            if (cuilSinGuiones == "00000000000") {
                show_alert("Formulario incompleto", "Ingrese un Cuil", "warning");
                return false;
            }

            if (cuil == "") {
                show_alert("Formulario incompleto", "Ingrese un Cuil", "warning");
                return false;
            }  
        }


        $('document').ready(function () {
            
            var cbo_e = $('.cbo_empresa');
            var cbo_input_duplicado = $(cbo_e).children().children()[0]
            $(cbo_input_duplicado).hide();
            $('#contenido_body_cbo_empresa').select2();

            
            M.updateTextFields();
        });


    </script>


</asp:Content>
