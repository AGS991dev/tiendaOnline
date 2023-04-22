<%@ Page Language="VB" AutoEventWireup="false" MasterPageFile="~/master.master" CodeFile="Frm_parametros.aspx.vb" Inherits="Frm_parametros" %>


<asp:Content runat="server" ContentPlaceHolderID="contenido_nav">
    <a href="admin_index.aspx" class="breadcrumb">INICIO</a>
    <a href="Grilla_parametros.aspx" class="breadcrumb">Parametros</a>
    <a href="#!" class="breadcrumb">Formulario</a>
</asp:Content>

<asp:Content runat="server" ContentPlaceHolderID="contenido_body">

    <h1 class="center-align"><%=titulo %> </h1>

    <div class="container">
        <div class="card">
            <div class="card-content" style="background: white">
            <form runat="server" class="form-horizontal">
                <asp:ScriptManager runat="server"></asp:ScriptManager>

                <div class="input-field ">
                    <asp:TextBox ID="txt_codigo" ReadOnly="true" runat="server"></asp:TextBox>
                    <label for="txt_codigo">Código</label>
                </div>
                <br />

                <div class="input-field ">
                    <asp:TextBox ID="txt_descripcion" ReadOnly="true"  runat="server"></asp:TextBox>
                    <label for="txt_descripcion">Descripción</label>
                </div>
                <br />

                <div class="input-field ">
                    <asp:TextBox ID="txt_valor" runat="server"></asp:TextBox>
                    <label for="txt_valor">Valor</label>
                </div>

                
                <div class="center-align" style="margin-bottom: 50px; margin-top: 20px;">
                    <asp:Button ID="btn_save" runat="server" Text="Guardar" CssClass="btn"    />
                </div>

            </form>
                </div>
        </div>
    </div>


</asp:Content>

<asp:Content runat="server" ContentPlaceHolderID="contenido_js">
    <script type="text/javascript">
        //function validar() { } onclientclick="return validar()"
</script>
</asp:Content>
