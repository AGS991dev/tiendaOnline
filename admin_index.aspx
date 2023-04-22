<%@ Page Language="VB" AutoEventWireup="false" MasterPageFile="~/master.master" CodeFile="admin_index.aspx.vb" Inherits="admin_index" %>

<asp:Content runat="server" ContentPlaceHolderID="contenido_body">


    <% If Not IsNothing(Session("usuario_actual")) And cls_security.usuario_actual.logo <> "" Then  %>
         <div style="display:flex;justify-content:center">
            <div class="logo_empresas" style="background:url(<%=cls_security.usuario_actual.logo %>);background-size: cover;float: right;background-position: center;margin: 15px;"></div>
         </div>
    <%Else %>
    <h4 style="margin: 30px 20px ; text-align: center;"><%=cls_security.usuario_actual.razon_social%></h4>
    <%End If%>

    <div class="container" >



        <div class="row">
            <div class="col m10 l8 offset-l2 offset-m1 s12 ">


            <div class="col m4 s6 ">
                <a href="./Grilla_Empresas.aspx">
                    <div class="card-panel card-menu center white-text hoverable">
                          <i class="medium material-icons i_supervisor_index">business</i>

                        <p>Empresas</p>
                    </div>
                </a>
            </div>


            <div class="col m4 s6" >
                <a class="btn_usuarios">
                    <div class="card-panel card-menu center white-text hoverable">
                        <i class="i_supervisor_index medium material-icons">supervisor_account</i>

                        <p>Usuarios</p>
                    </div>
                </a>
            </div>

            <div class="col m4 s6">
                <a href="./Grilla_parametros.aspx">
                    <div class="card-panel card-menu center white-text hoverable">
                        <i class="i_supervisor_index medium material-icons">perm_data_setting</i>

                        <p>Parámetros</p>
                    </div>
                </a>
            </div>

            
            </div>

        </div>

    </div>
    <br />

<style>
        .logo_empresas{
                position: relative;
                top: 5px;
                width: 125px;
                height: 125px;
                border-radius: 3px;
        }
        .btn_usuarios{
            cursor:pointer;
        }
</style>

    <script type="text/javascript" src="static/js/main.js"></script>

    <script>
        $('.btn_usuarios').click(function () {
            loading()
            window.location.href = "Grilla_Usuarios.aspx"
        })
        function loading() {
            $('#loading').modal({ dismissible: false });
            $('#loading').modal('open');
        }
    </script>

</asp:Content>
    
