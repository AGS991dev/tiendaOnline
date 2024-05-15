<%@ Page Language="VB" AutoEventWireup="false" MasterPageFile="~/master.master" CodeFile="Frm_stock.aspx.vb" Inherits="Frm_stock" %>


<asp:Content runat="server" ContentPlaceHolderID="contenido_nav">
    <a href="supervisor_index.aspx" class="breadcrumb">INICIO</a>
    <a href="Grilla_stock.aspx" class="breadcrumb">Stock</a>
    <a href="#!" class="breadcrumb">Nuevo Producto</a>
</asp:Content>

<asp:Content runat="server" ContentPlaceHolderID="contenido_body">

    <br />
    <br />
    <div class="container">
        <div class="card">
            <div class="fadeInLeftBig" style="display: flex; padding: 20px; justify-content: center">
                <img src="./static/img/delivery-box.png" width="70px" />
                <p class="center-align" style="margin: 20px 20px;">Nuevo Producto</p>
            </div>
            <div class="card-content" style="background: white">
                <form runat="server" class="form-horizontal">
                    <asp:ScriptManager runat="server"></asp:ScriptManager>

                    <div class="row">
                        <div class="input-field col m4 s12">
                            <asp:DropDownList ID="cbo_categoria" runat="server"></asp:DropDownList>
                            <label for="cbo_categoria">Categoría</label>
                        </div>
                        <div class="input-field col m4 s12">
                            <asp:TextBox ID="txt_nombre" runat="server"></asp:TextBox>
                            <label for="txt_nombre">Nombre</label>
                        </div>
                        <div class="input-field col m4 s12">
                            <asp:TextBox ID="txt_descripcion" runat="server"></asp:TextBox>
                            <label for="txt_descripcion">Descripción</label>
                        </div>
                        <div class="input-field col m4 s12">
                            <asp:TextBox ID="txt_codigo_barra" runat="server"></asp:TextBox>
                            <label for="txt_codigo_barra">Código de Barras</label>
                        </div>
                        <div class="input-field col m4 s12">
                            <asp:TextBox ID="txt_precio" runat="server"></asp:TextBox>
                            <label for="txt_precio">Precio</label>
                        </div>
                        <div class="input-field col m4 s12">
                            <asp:TextBox ID="txt_precio_costo" runat="server"></asp:TextBox>
                            <label for="txt_precio_costo">Precio Costo</label>
                        </div>
                        <div class="input-field col m4 s12">
                            <asp:TextBox ID="txt_cantidad" runat="server" type="number"></asp:TextBox>
                            <label for="txt_cantidad" style="color: grey;">Cantidad</label>
                        </div>
                        <div class="input-field col m4 s12">
                            <asp:TextBox ID="txt_tamaño" runat="server"></asp:TextBox>
                            <label for="txt_tamaño">Tamaño</label>
                        </div>
                        <div class="input-field col m4 s12">
                            <asp:TextBox ID="txt_color" runat="server"></asp:TextBox>
                            <label for="txt_color">Color</label>
                        </div>
                        <div class="input-field col m12" >
                             <div style="display: flex; flex-wrap: wrap; justify-content: space-between">
                                <div>
                                    <asp:TextBox ID="txt_ruta_imagen1" runat="server" Style="display: none"></asp:TextBox>
                                    <label for="txt_ruta_imagen1">Imagen 1</label><br /><br />
                                    <input type="file" id="imgInput1" class="imgInput1" runat="server"  style="max-width: 250px" />
                                    <div class="vista-previa-1" style="max-width: 250px;margin-top: 20px;"></div>
                                    <img id="img1" class="img1" runat="server" style="max-width: 250px" />
                                </div>

                                <div>
                                    <asp:TextBox ID="txt_ruta_imagen2" runat="server" Style="display: none"></asp:TextBox>
                                    <label for="txt_ruta_imagen2">Imagen 2</label><br /><br />
                                    <input type="file" id="imgInput2" class="imgInput2" runat="server"  style="max-width: 250px" />
                                    <div class="vista-previa-2" style="max-width: 250px;margin-top: 20px;"></div>
                                    <img id="img2" class="img2" runat="server" style="max-width: 250px" />
                                </div>
                                <div>
                                    <asp:TextBox ID="txt_ruta_imagen3" runat="server" Style="display: none"></asp:TextBox>
                                    <label for="txt_ruta_imagen3">Imagen 3</label><br /><br />
                                    <input type="file" id="imgInput3" class="imgInput3" runat="server"  style="max-width: 250px" />
                                    <div class="vista-previa-3" style="max-width: 250px;margin-top: 20px;"></div>
                                    <img id="img3" class="img3" runat="server" style="max-width: 250px" />
                                </div>
                            </div>
                        </div>
                        </div>
                    </div>

                    <div class="center-align" style="margin-bottom: 50px; margin-top: 20px;">
                        <asp:Button ID="btn_save" runat="server" Text="Guardar" CssClass="btn" OnClientClick="return validar_formulario()" />
                    </div>
                    <br />
                </form>
            </div>
        </div>
    </div>

    <br />

</asp:Content>

<asp:Content runat="server" ContentPlaceHolderID="contenido_js">
    <script type="text/javascript">
        $(document).ready(function () {
            $('.imgInput1').change(function (event) {
                if (this.files && this.files[0]) {
                    var reader = new FileReader();
                    reader.onload = function (e) {
                        // Muestra la imagen seleccionada en la vista previa
                        $(".vista-previa-1").html('<img style="max-width: 250px" src="' + e.target.result + '">');
                        $('.img1').hide();
                    }
                    reader.readAsDataURL(this.files[0]);
                }
            });
            $('.imgInput2').change(function (event) {
                if (this.files && this.files[0]) {
                    var reader = new FileReader();
                    reader.onload = function (e) {
                        // Muestra la imagen seleccionada en la vista previa
                        $(".vista-previa-2").html('<img style="max-width: 250px" src="' + e.target.result + '">');
                        $('.img2').hide();
                    }
                    reader.readAsDataURL(this.files[0]);
                }
            });
            $('.imgInput3').change(function (event) {
                if (this.files && this.files[0]) {
                    var reader = new FileReader();
                    reader.onload = function (e) {
                        // Muestra la imagen seleccionada en la vista previa
                        $(".vista-previa-3").html('<img style="max-width: 250px" src="' + e.target.result + '">');
                        $('.img3').hide();
                    }
                    reader.readAsDataURL(this.files[0]);
                }
            });

        })


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
