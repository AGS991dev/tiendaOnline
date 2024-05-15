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

        <!--Paso  3-->
        <div class="step_3" id="step_3" runat="server" visible="true">

            <div class="container">
                <div style="display: flex; justify-content: center; align-items: center;">
                    <img src="static/img/mantenimiento.png" style="width: -webkit-fill-available;margin-top:100px;" />
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
            //var cleave = new Cleave('#contenido_body_txt_cuil', {
            //    numericOnly: true,
            //    blocks: [2, 8, 1],
            //    delimiter: '-',
            //    onValueChanged: function (e) {
            //        //console.log(e.target) // e.target = { value: '5100-1234', rawValue: '51001234' }
            //    }
            //});
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
