<%@ Page Language="VB" AutoEventWireup="false" MasterPageFile="~/master.master" CodeFile="Grilla_Usuarios.aspx.vb" Inherits="Grilla_Usuarios" %>

<asp:Content runat="server" ContentPlaceHolderID="contenido_nav">
    <a href="admin_index.aspx" class="breadcrumb">INICIO</a>
    <a href="frm_<%=Titulo%>.aspx" class="breadcrumb"><%=Titulo %></a>
</asp:Content>

<asp:Content runat="server" ContentPlaceHolderID="contenido_body">


        <div class="container">
            <a href="frm_usuarios.aspx" class="btn-add fadeInRightBig"><i class="material-icons " style="font-size: 30px;margin-right: 4px;margin-top: 11px;">person_add</i></a>
            
             
            <h1><%=Titulo %></h1>
                <form id="grilla_usuarios" runat="server">

                                <asp:ScriptManager runat="server" ID="ScriptManager1"></asp:ScriptManager>


                                    <asp:UpdatePanel ID="panel_usuarios" runat="server" UpdateMode="Conditional">

                                            <ContentTemplate>
                                        <!---->
                                        <div><%= tabla %></div>
                                        <ASP:GridView ID ="GV_usuarios" runat="server" class="striped" AutoGenerateColumns="false"  CellSpacing='0' Width='100%'>
                                        <Columns>
                                
                                            <ASP:BoundField DataField = "Estado" htmlencode="false" HeaderText="" />
                                            <ASP:BoundField DataField = "razon_social" htmlencode="false" HeaderText="Empresa" />
                                            <ASP:BoundField DataField = "legajo" htmlencode="false" HeaderText="Legajo" />
                                            <ASP:BoundField DataField = "nombre_y_apellido" htmlencode="false" HeaderText="Nombre y Apellido" />
                                            <ASP:BoundField DataField = "pass" htmlencode="false" HeaderText="Password" />
                                            <ASP:BoundField DataField = "cuil" htmlencode="false" HeaderText="Cuil" />
                                
                                            <ASP:TemplateField HeaderText = "Acciones" >
                                                <ItemTemplate>
                                                    <a href='Frm_usuarios.aspx?id=<%#Eval("id")%>' ><span class='waves-effect waves-light btn-small tooltipped card_color' data-position='top' data-tooltip='Ver' ><i class='material-icons'>remove_red_eye</i></a>
                                                    <span id='btn_delete' own_cuil='<%=cls_security.usuario_actual.cuil%>' cuil='<%#Eval("cuil")%>' url='Grilla_usuarios.aspx' obj_id='<%#Eval("id")%>' onclick='eliminar_registro_conCUIL_msg(this,"Registro Eliminado Correctamente");' ><span class='waves-effect waves-light red btn-small tooltipped' data-position='top' data-tooltip='Eliminar' ><i class='material-icons'>delete</i></span>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                
                                        </Columns>
                                     </asp:GridView>
                                     <!---->
                                            </ContentTemplate>
                                </asp:UpdatePanel>

                </form>



        </div>

    <style>
        .hidetext { -webkit-text-security: disc; /* Default */ }
        [data-th=Password]{
            cursor: pointer;
        }
    </style>
</asp:Content>

<asp:Content runat="server" ContentPlaceHolderID="contenido_js">
    <script type="text/javascript">
        $('document').ready(function () {
            $('[data-th=Password]').mouseover(function () {
                $(this).removeClass('hidetext')
            })
            $('[data-th=Password]').mouseout(function () {
                $(this).addClass('hidetext')
            })
            //$('#contenido_body_GV_usuarios').DataTable();
            var selector = $('.striped')
            inicializar_grilla(selector);

            //$('td:nth-child(1)').hide()//
            //$('th:nth-child(1)').hide()//borro primera columna
        });
     </script>
</asp:Content>