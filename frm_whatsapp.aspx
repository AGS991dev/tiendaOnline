<%@ Page Language="VB" AutoEventWireup="false" MasterPageFile="~/master.master" CodeFile="frm_whatsapp.aspx.vb" Inherits="frm_whatsapp" %>

<asp:Content runat="server" ContentPlaceHolderID="contenido_nav">
    <a href="supervisor_index.aspx" class="breadcrumb">INICIO</a>
    <a href="grilla_whatsapp.aspx" class="breadcrumb">Grilla Whatsapp</a>
    <a href="#!" class="breadcrumb">Formulario</a>
</asp:Content>

<asp:Content runat="server" ContentPlaceHolderID="contenido_body">

    <h1 class="center-align"><%=titulo %> </h1>

    <div class="form-container">
        <div class="form-card">

            <form runat="server" class="form-horizontal" autocomplete="off">
                <asp:ScriptManager runat="server"></asp:ScriptManager>

                <div class="input-field ">
                    <asp:TextBox ID="txt_descripcion" runat="server"></asp:TextBox>
                    <label for="txt_descripcion" style="position: relative;">Numero de <b>Whatsapp</b> donde llegarán los mensajes de la <b>Tienda Online</b></label>
                </div>


                
                <div class="center-align" style="margin-bottom: 50px; margin-top: 20px;">
                    <asp:Button ID="btn_save" runat="server" Text="Guardar" CssClass="btn"  onclientclick="return validar()"  />
                </div>

            </form>
        </div>
    </div>


</asp:Content>

<asp:Content runat="server" ContentPlaceHolderID="contenido_js">
    <script type="text/javascript">


        function validar() {
            var categoria_desc = $("#contenido_body_txt_descripcion").val();

            if (categoria_desc == "") {
                show_alert("Formulario incompleto", "Ingrese una Razón Social.", "warning");
                return false;
            }
        }


<%--        function existe_usuario() {

            var codigo = $('#<%=txt_descripcion.ClientID%>').val();
            var result;
            $.ajax({
                type: "POST",
                url: "Frm_Usuarios.aspx/existe_codigo",
                data: '{codigo: "' + codigo + '", objid: "<%=pk %>" }',
                async: false,
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    result = response.d;
                }
            });

            return result == 1;

        }--%>






    </script>


</asp:Content>
