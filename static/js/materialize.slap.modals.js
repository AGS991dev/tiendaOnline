
_current_callback = null;


$(document).ready(function () {
    $('#slap-modal').modal();
    $('#slap-modal-print').modal();
    $("#slap-modal-loading").modal({'dismissible':false});
});

function slap_confirm(text, callback) {
    _current_callback = callback
    
    $("#slap-modal-btn-cancelar").show();
    $("#slap-modal-text").html(text)
    $('#slap-modal').modal('open');
    
}

function slap_alert(text) {
    _current_callback = null

    $("#slap-modal-btn-cancelar").hide();
    $("#slap-modal-text").html(text)
    $('#slap-modal').modal('open');

}

function slap_loading_show(text) {
    $("#slap-modal-loading-text").html(text)
    $("#slap-modal-loading").modal('open')
}

function slap_loading_hide() {
    $("#slap-modal-loading").modal('close')
}


function slap_modal_aceptar() {
    if (_current_callback != null) _current_callback()
    $('#slap-modal').modal('close');
}


function slap_print() {
    $('#slap-modal-print').modal('open');

}