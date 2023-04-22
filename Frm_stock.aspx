<%@ Page Language="VB" AutoEventWireup="false" MasterPageFile="~/master.master" CodeFile="Frm_stock.aspx.vb" Inherits="Frm_stock" %>


<asp:Content runat="server" ContentPlaceHolderID="contenido_nav">
    <a href="supervisor_index.aspx" class="breadcrumb">INICIO</a>
    <a href="Grilla_stock.aspx" class="breadcrumb">Stock</a>
    <a href="#!" class="breadcrumb">Nuevo Producto</a>
</asp:Content>

<asp:Content runat="server" ContentPlaceHolderID="contenido_body">

    <br /><br />
    <div class="container">
        <div class="card">
        <div class="fadeInLeftBig" style="display:flex; padding:20px;justify-content:center">
            <img src="./static/img/checklist.png" width="70px"/>
            <p class="center-align" style="margin: 20px 20px;">Nuevo Producto </p>
        </div>
            <div class="card-content" style="background: white">
            <form runat="server" class="form-horizontal">
                <asp:ScriptManager runat="server"></asp:ScriptManager>



                <div class="row">
                   <div class="col s6 ">
                    <div class="input-field ">
                        <asp:DropDownList ID="cbo_categoria" runat="server"></asp:DropDownList>
                        <label for="cbo_categoria">Categoría</label>
                    </div>
                    <div class="input-field ">
                        <p style="color:grey"">CANTIDAD</p>
                        <asp:TextBox ID="txt_cantidad" runat="server" type="number"></asp:TextBox>
                    </div>
                    <div class="input-field ">
                        <asp:TextBox ID="txt_nombre" runat="server"></asp:TextBox>
                        <label for="txt_nombre">Nombre</label>
                    </div>
                    <div class="input-field ">
                        <asp:TextBox ID="txt_descripcion" runat="server"></asp:TextBox>
                        <label for="txt_descripcion">Descripcion</label>
                    </div>
                    <div class="input-field" style="display: flex;width: 98%;">
                        <asp:TextBox ID="txt_codigo_barra" runat="server"></asp:TextBox>
                        <label for="txt_codigo_barra">Código de Barras</label>
                    </div>
                    <div class="input-field ">
                        <asp:TextBox ID="txt_precio" runat="server"></asp:TextBox>
                        <label for="txt_precio">Precio</label>
                    </div>

                   </div>

                    <div class="col s6 ">

                    <div class="input-field ">
                        <asp:TextBox ID="txt_tamaño" runat="server"></asp:TextBox>
                        <label for="txt_tamaño">Tamaño</label>
                    </div>
                    <div class="input-field ">
                        <asp:TextBox ID="txt_color" runat="server"></asp:TextBox>
                        <label for="txt_color">Color</label>
                    </div>
                    <div class="input-field ">
                        <asp:TextBox ID="txt_ruta_imagen1" runat="server"></asp:TextBox>
                        <label for="txt_ruta_imagen1">Ruta Imagen 1</label>
                    </div>
                    <div class="input-field ">
                        <asp:TextBox ID="txt_ruta_imagen2" runat="server"></asp:TextBox>
                        <label for="txt_ruta_imagen2">Ruta Imagen 2</label>
                    </div>
                    <div class="input-field ">
                        <asp:TextBox ID="txt_ruta_imagen3" runat="server"></asp:TextBox>
                        <label for="txt_ruta_imagen3">Ruta Imagen 3</label>
                    </div>
                   </div>
                </div>
                
                <div class="center-align" style="margin-bottom: 50px; margin-top: 20px;">
                    <asp:Button ID="btn_save" runat="server" Text="Guardar" CssClass="btn"  onclientclick="return validar_formulario()"  />
                </div>

            </form>
            </div>
        </div>
    </div>
    <br />

</asp:Content>

<asp:Content runat="server" ContentPlaceHolderID="contenido_js">
    <script type="text/javascript">
        function validar_formulario() {
            var nombre = $("#contenido_body_txt_nombre").val();
            var descripcion = $("#contenido_body_txt_descripcion").val();
            var codigo_barra = $("#contenido_body_txt_codigo_barra").val();
            var cantidad = $("#contenido_body_txt_cantidad").val();
            var categoria = $("#contenido_body_txt_categoria").val();
            var precio = $("#contenido_body_txt_precio").val();
            var tamaño = $("#contenido_body_txt_tamaño").val();
            var color = $("#contenido_body_txt_color").val();
            var ruta_imagen = $("#contenido_body_txt_ruta_imagen").val();

            if (nombre == "") {
                show_alert("Formulario Incompleto", "Ingrese un nombre del producto.", "warning");
                return false;
            }
            if (descripcion == "") {
                show_alert("Formulario Incompleto", "Ingrese una descripcion del producto.", "warning");
                return false;
            }
            if (codigo_barra == "") {
                show_alert("Formulario Incompleto", "Ingrese un codigo para el producto producto.", "warning");
                return false;
            }
            if (cantidad == "") {
                show_alert("Formulario Incompleto", "Ingrese una Cantidad del producto.", "warning");
                return false;
            }
            if (categoria == "") {
                show_alert("Formulario Incompleto", "Ingrese una categoria del producto.", "warning");
                return false;
            }
            if (precio == "") {
                show_alert("Formulario Incompleto", "Ingrese un PRECIO del producto.", "warning");
                return false;
            }
            if (tamaño == "") {
                show_alert("Formulario Incompleto", "Ingrese un tamaño del producto.", "warning");
                return false;
            }
            //if (color == "") {
            //    show_alert("Formulario Incompleto", "Ingrese un nombre del producto.", "warning");
            //    return false;
            //}
            //if (ruta_imagen == "") {
            //    show_alert("Formulario Incompleto", "Ingrese un nombre del producto.", "warning");
            //    return false;
            //}
        }
</script>
</asp:Content>
