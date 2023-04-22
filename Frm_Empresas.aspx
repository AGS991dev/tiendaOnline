<%@ Page Language="VB" AutoEventWireup="false" MasterPageFile="~/master.master" CodeFile="Frm_Empresas.aspx.vb" Inherits="Frm_Empresas" %>


<asp:Content runat="server" ContentPlaceHolderID="contenido_nav">
    <a href="supervisor_index.aspx" class="breadcrumb">INICIO</a>
    <a href="Grilla_Empresas.aspx" class="breadcrumb">Empresas</a>
    <a href="#!" class="breadcrumb">Formulario</a>
</asp:Content>

<asp:Content runat="server" ContentPlaceHolderID="contenido_body">

    <h1 class="center-align"><%=titulo %> </h1>

    <div class="form-container">
        <div class="form-card">

            <form runat="server" class="form-horizontal">
                <asp:ScriptManager runat="server"></asp:ScriptManager>

                <div class="input-field ">
                    <asp:TextBox ID="txt_razon_social" runat="server"></asp:TextBox>
                    <label for="txt_razon_social">Razón Social</label>
                </div>
                <br />

                <div class="input-field ">
                    <asp:TextBox ID="txt_cuit" runat="server"></asp:TextBox>
                    <label for="txt_cuit">Cuit</label>
                </div>
                <br />

                <p>Seleccione el Logo de la Empresa</p>
                        <div class="fileupload_logo" data-provides="fileupload">
                        <asp:FileUpload ID="FileUpload_logo" runat="server"/></span>
                        <asp:HiddenField id="hi_logo" runat="server" Value="" />

                </div> <br />

                                
                <div class="center-align" style="margin-bottom: 50px; margin-top: 20px;">
                    <asp:Button ID="btn_save" runat="server" Text="Guardar" CssClass="btn"  onclientclick="return validar()"  />
                </div>

            </form>
        </div>
    </div>


</asp:Content>

<asp:Content runat="server" ContentPlaceHolderID="contenido_js">
    <script type="text/javascript">
        //funcion validar formulario
        function validar() {
            var razon_social = $("#contenido_body_txt_razon_social").val();
            var cuit = $("#contenido_body_txt_cuit").val();

            if (razon_social == "") {
                show_alert("Formulario Incompleto", "Ingrese una Razón Social.", "warning");
                return false;
            }
            if (cuit == 00000000000) {
                show_alert("Formulario Incompleto", "Ingrese un Cuit Válido.", "warning");
                return false;
            }
            if (cuit == "") {
                show_alert("Formulario Incompleto", "Ingrese un Cuit.", "warning");
                return false;
            } else {
                var cuitNumero = $("#contenido_body_txt_cuit").val();
                var validacion = validarCuit(cuitNumero) // <-- funcion validar cuit de main.js

                //alert(validacion)
                if (validacion == true) {
                    return true
                } else {
                    show_alert("Cuit Invalido", "Ingrese un Cuit Válido.", "warning");
                    return false
                }
            }
        }

        //mascara
        $(function () {
            $("#contenido_body_txt_cuit").mask("99-99999999-9", { "placeholder": "00-00000000-0", "positionCaretOnTab": false });
        });

    </script>


</asp:Content>

