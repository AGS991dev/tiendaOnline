﻿<%@ Page Language="VB" AutoEventWireup="false" MasterPageFile="~/master.master" CodeFile="c_movimientos.aspx.vb" Inherits="c_movimientos" %>

<asp:Content runat="server" ContentPlaceHolderID="contenido_nav">
    <a href="supervisor_index.aspx" class="breadcrumb">INICIO</a>
</asp:Content>

<asp:Content runat="server" ContentPlaceHolderID="contenido_body">

    <form id="grilla" runat="server">
         <asp:ScriptManager runat="server" ID="ScriptManager_grilla"></asp:ScriptManager>
                    <asp:button runat='server' ID='btn_refresh'  style="display:none" text="refresh"/>
        <div class="container-lg">

            <h1 class="center"><%=Titulo %></h1>
            <p class="center">Visualizá y Registrá movimientos</p>
            <br />
            <div class="contender_carrito" style="position: absolute; top: 17vh; right: 15vw;">
                <img src="./static/img/gasto.png" class="img_carrito bounce" style="width: 80px;">
            </div>



            <div style="display: flex; flex-wrap: wrap; box-shadow: rgba(50, 50, 93, 0.25) 0px 2px 5px -1px, rgba(0, 0, 0, 0.3) 0px 1px 3px -1px; border-radius: 3px;padding: 10px 0px;justify-content:center;; margin: auto;width: 100%;">

                    <div class="inputs_filtros_css" style="margin: 0 20px;width:110px">
                            <label for="txt_desde" class="txt_desde" style="min-width: 90px;margin: 8px;position: relative;top: 5px;">Desde:</label>
                                <asp:UpdatePanel ID="Update_txt_desde" runat="server" UpdateMode="Conditional">
                                <ContentTemplate>
                                    <asp:TextBox runat='server' ID='txt_desde'  type='date' class='form-control input-md ' MaxLength='200' AutoPostBack="true" />
                                    </ContentTemplate>
                            </asp:UpdatePanel>
                    </div>
                    <div class="inputs_filtros_css" style="margin: 0 20px;width:110px">
                            <label for="txt_hasta" class="txt_hasta" style="min-width: 90px;margin: 8px;position: relative;top: 5px;">Hasta:</label>
                                <asp:UpdatePanel ID="Update_txt_hasta" runat="server" UpdateMode="Conditional">
                                    <ContentTemplate>
                                    <asp:TextBox runat='server' ID='txt_hasta' type='date' class='form-control input-md ' MaxLength='200' AutoPostBack="true"  />
                                    </ContentTemplate>
                            </asp:UpdatePanel>
                    </div>

                    <div style="display: flex;margin:20px">
                        <asp:UpdatePanel ID="Update_lbl_total" runat="server" UpdateMode="Conditional">
                        <ContentTemplate>
                                <img src="./static/img/dinero.png" style="width: 40px;position: relative;top: 10px;"><label id="lbl_total" runat="server" style="font-size:30px;margin-left:10px;font-family: monospace;font-weight: bolder;"></label>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </div>

            </div>
            <p>Elegí el concepto para registrar tu moviemiento.</p>
            <div class="box_inputs">
                <label for="cbo_concepto" style="position: relative; top: 10px; font-size: 18px; right: 5px;">CONCEPTO</label>
                <asp:DropDownList runat='server' ID='cbo_concepto' style="margin: 0 5px;width: 130px;" type='text' />
                <asp:TextBox runat='server'  placeholder="Descripción" ID='txt_descripcion' style="min-width:200px;max-width:200px;margin: 0 5px; border: 1px grey solid; height: 50px;padding: 0 10px;" type='text'/>
                <div style="display:flex;">
                    <label for="txt_monto" style="position: relative; top: 10px; font-size: 20px;">MONTO</label>
                    <asp:TextBox runat='server' ID='txt_monto' style="margin: 0 5px;text-align: center;" type='number'/>
                    <asp:button runat='server' ID='btn_add' style="margin: 0 5px; height: 30px; position: relative; top: 15px; left: 5px;" text="➕"/>
                </div>
            </div>



            <asp:UpdatePanel ID="panel_consultas" runat="server" style="width: 80%;margin: auto;min-width: 380px;" UpdateMode="Conditional">
                <ContentTemplate>
            <% If tabla_vacia = True Then %>
            <div>
                <%= tabla %>
            </div>
            <%End if %>
                </ContentTemplate>
            </asp:UpdatePanel>
            

            <br />
            <h5>📈 Registros</h5>
            <br />
            <ASP:GridView ID ="GV_registros" runat="server" class="table" AutoGenerateColumns="false"  CellSpacing='0' style='margin: auto; box-shadow: rgb(0 0 0 / 25%) 0px 0.0625em 0.0625em, rgb(0 0 0 / 25%) 0px 0.125em 0.5em, rgb(255 255 255 / 10%) 0px 0px 0px 1px inset; }'>
            <Columns>
                                
                <ASP:BoundField DataField = "id" htmlencode="false" HeaderText="ID" />
                <ASP:BoundField DataField = "concepto" htmlencode="false" HeaderText="Concepto 🧾" />
                <ASP:BoundField DataField = "descripcion" htmlencode="false" HeaderText="Descripcion" />
                <ASP:BoundField DataField = "fecha" htmlencode="false" HeaderText="Fecha 📆" />
                <ASP:BoundField DataField = "operacion" htmlencode="false" HeaderText="Operacion" />
                <ASP:BoundField DataField = "monto" htmlencode="false" HeaderText="Monto 💲" />

                </Columns>
                </asp:GridView>
        </div>
        
    </form>
    <br /><br /><br /><br />
    <style>

        .box_inputs {
            display: flex;
            justify-content: start;
            flex-wrap: wrap;
            gap: 15px;
            border-radius: 3px;
            padding: 5px 0px 0px 20px;
        }
        .S{
            color:#29357d
        }
        .R{
            color:#db5461
        }
        td:nth-child(1) {
            display:none;
        }
        th:nth-child(1){
            display:none;
        }
        td:nth-child(2) {
        }
        th:nth-child(2){
            text-align:center;
        }
        td:nth-child(3) {
            text-align:center;
        }
        th:nth-child(3){
            text-align:center;
        }
        td:nth-child(4) {
            text-align:center;
        }
        th:nth-child(4){
            text-align:center;
        }
        td:nth-child(5) {
            text-align:center;
        }
        th:nth-child(5){
            text-align:center;
        }
        td:nth-child(6) {
            text-align:center;
        }
        th:nth-child(6){
            text-align:center;
        }
        @media screen and (max-width: 601px) { /*MENOR DE 601 PX*/
        td:nth-child(1) {
            display:none;
        }
        th:nth-child(1){
            display:none;
        }
        td:nth-child(3) {
            display:none;
        }
        th:nth-child(3){
            display:none;
        }
        td:nth-child(5) {
            display:none;
        }
        th:nth-child(5){
            display:none;
        }

        td:nth-child(6) {
            text-align:center;
        }
        th:nth-child(6){
            text-align:center;
        }
    </style>
</asp:Content>


<asp:Content runat="server" ContentPlaceHolderID="contenido_js">
    <script type="text/javascript">
        $('document').ready(function () {
            refresh()
            on_postback_end(refresh)
        })
        function refresh() {

        $('#<%=txt_desde.ClientID%>').change(function () {
            $('#<%=btn_refresh.ClientID%>').click()
        })
        $('#<%=txt_hasta.ClientID%>').change(function () {
            $('#<%=btn_refresh.ClientID%>').click()
        })
        }
    </script>
</asp:Content>