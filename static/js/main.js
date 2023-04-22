var GRILLA_ACTUAL = null;
var GRILLA_OFF = false;
var myChart
var myChart_2

function inicializar_grilla(selector, callback, primer_columna_visible) {

    if (primer_columna_visible == undefined) primer_columna_visible = true;
    if (selector == undefined) selector = 'striped';
    if (GRILLA_OFF == true) return;
    GRILLA_ACTUAL = $(selector).dataTable({
        "language": { "url": "table_spanish.txt" },
        "columnDefs": [{ "targets": [0], "visible": primer_columna_visible, "searchable": true }],
        "info": true,
        "order": [[0, 'desc']],
        "bLengthChange": true,
        "drawCallback": function (settings) {
            var pagination = $(this).closest('.dataTables_wrapper').find('.dataTables_paginate');
            pagination.toggle(this.api().page.info().pages > 1);
        },
        "initComplete": function (settings, json) {
            slap_loading_hide();
            div = $(selector).closest("div")
            div.find("input[type='search']").focus();
            if (callback != undefined) callback();
        }
    });
}
function incializar_calendario(id) {
    var element = $('#' + id)
    new Cleave(element, {
        date: true
    });

    $(element).datepicker({
        format: 'dd/mm/yyyy',
        language: 'en',
        autoclose: true,
        todayHighlight: true
    });
}
function inicializar_grilla_asc(selector, callback, primer_columna_visible) {

    if (primer_columna_visible == undefined) primer_columna_visible = true;
    if (selector == undefined) selector = 'striped';
    if (GRILLA_OFF == true) return;
    GRILLA_ACTUAL = $(selector).dataTable({
        "language": { "url": "table_spanish.txt" },
        "columnDefs": [{ "targets": [0], "visible": primer_columna_visible, "searchable": true }],
        "info": true,
        "order": [[0, 'asc']],
        "bLengthChange": true,
        "drawCallback": function (settings) {
            var pagination = $(this).closest('.dataTables_wrapper').find('.dataTables_paginate');
            pagination.toggle(this.api().page.info().pages > 1);
        },
        "initComplete": function (settings, json) {
            slap_loading_hide();
            div = $(selector).closest("div")
            div.find("input[type='search']").focus();
            if (callback != undefined) callback();
        }
    });
}
function contador_empleados_en_excel(n){
    //console.log(n)
}
//function destroy_myChart(myChart) {
//    console.log("char", myChart)
//    if (myChart) {
//        myChart.destroy();
//    }
//}

//function refrescar_grafico_categorias(categoria, cantidad) {
//    if (myChart) {
//        myChart.destroy();
//    }
//    myChart = inicializar_grafico()
//    mostrar(myChart, categoria, cantidad)
//}

//function refrescar_grafico_categorias_circular(categoria, cantidad) {
//    if (myChart_2) {
//        myChart_2.destroy();
//    }
//    myChart_2 = inicializar_grafico_circular()
//    mostrar(myChart_2, categoria, cantidad)
//}
//const mostrar = (myChart, categoria, cantidad) => {
//    const _categorias = categoria.split(",");
//    const _cantidades = cantidad.split(",");
//    console.log(myChart)
//    for (i = 0; i < _categorias.length; i++) {
//        myChart.data['labels'].push(_categorias[i])
//        myChart.data['datasets'][0].data.push(_cantidades[i])
//        myChart.update()
//    }
//}
function inicializar_grilla2(selector, callback, primer_columna_visible) {
    //console.log(selector)
    if (primer_columna_visible == undefined) primer_columna_visible = true;
    if (selector == undefined) selector = 'striped';
    if (GRILLA_OFF == true) return;
    GRILLA_ACTUAL = $(selector).dataTable({
        "language": { "url": "table_spanish.txt" },
        "columnDefs": [{ "targets": [0], "visible": primer_columna_visible, "searchable": true }],
        "info": true,
        "bLengthChange": false,
        "drawCallback": function (settings) {
            var pagination = $(this).closest('.dataTables_wrapper').find('.dataTables_paginate');
            pagination.toggle(this.api().page.info().pages > 1);
        },
        "initComplete": function (settings, json) {
            slap_loading_hide();
            div = $(selector).closest("div")
            div.find("input[type='search']").focus();
            if (callback != undefined) callback();
        }
    });
}
function inicializar_grilla_btn_excel(selector, callback, primer_columna_visible) {
    if (primer_columna_visible == undefined) primer_columna_visible = true;
    if (selector == undefined) selector = 'striped';
    if (GRILLA_OFF == true) return;
    GRILLA_ACTUAL = $(selector).dataTable({
        "language": { "url": "table_spanish.txt" },
        "columnDefs": [{ "targets": [0], "visible": primer_columna_visible, "searchable": true }],
        "info": true,
        "order": [[0, 'desc']],
        "bLengthChange": false,
        "bAutoWidth": false,
        "dom": 'Bfrtip',
        "buttons": [
          {
              extend: 'excelHtml5',
              title: 'Resumen_Lote_x',
              titleAttr: 'Descarga un Excel con los documentos Filtrados de la tabla',
              text: '💾 Descargar Archivo Excel',
              exportOptions: {
                  columns: [1, 2, 3]
              }
          }
        ],
        "drawCallback": function (settings) {
            var pagination = $(this).closest('.dataTables_wrapper').find('.dataTables_paginate');
            pagination.toggle(this.api().page.info().pages > 1);
        },
        "initComplete": function (settings, json) {
            slap_loading_hide();
            div = $(selector).closest("div")
            div.find("input[type='search']").focus();
            if (callback != undefined) callback();
        }
    });
}

function inputnumber() {
    $('input.number').keydown(function (event) {

        if (event.shiftKey == true) {
            event.preventDefault();
        }

        if ((event.keyCode >= 48 && event.keyCode <= 57) || (event.keyCode >= 96 && event.keyCode <= 105) || event.keyCode == 8 || event.keyCode == 9 || event.keyCode == 37 || event.keyCode == 39 || event.keyCode == 46 || event.keyCode == 190 || event.keyCode == 110) {

        } else {
            event.preventDefault();
        }

        if ($(this).val().indexOf('.') !== -1 && (event.keyCode == 190 || event.keyCode == 110))
            event.preventDefault();

    });
}

function inputint() {
    $('input.int').keydown(function (event) {

        if (event.shiftKey == true) {
            event.preventDefault();
        }

        if ((event.keyCode >= 48 && event.keyCode <= 57) || (event.keyCode >= 96 && event.keyCode <= 105) || event.keyCode == 8 || event.keyCode == 9 || event.keyCode == 37 || event.keyCode == 39 || event.keyCode == 46) {

        } else {
            event.preventDefault();
        }

    });
}

function on_postback_end(EndRequestHandler){
    Sys.WebForms.PageRequestManager.getInstance().add_endRequest(EndRequestHandler);
}


function on_postback_begin(BeginRequestHandler) {
    Sys.WebForms.PageRequestManager.getInstance().add_beginRequest(BeginRequestHandler);
}


function postback_is(sender, id) {
    var sender_id = sender._postBackSettings.asyncTarget;
    if (sender_id == '') {
        sender_id = sender._postBackSettings.sourceElement.id;
    }

    return (sender_id.includes(id))

}
function refresh_filter() {
    var selector = $('.striped')
    inicializar_grilla(selector);
}

function quitar_producto_de_table(tr) {
    Swal.fire({
        title: '¿Querés quitar este producto del carrito?',
        showDenyButton: true,
        showCancelButton: false,
        confirmButtonText: 'SI',
        denyButtonText: `NO`,
        confirmButtonColor: 'black',
    }).then((result) => {
        /* Read more about isConfirmed, isDenied below */
        if (result.isConfirmed) {
            var carrito = sessionStorage.carrito
            carrito = JSON.parse(carrito)
            //console.log(carrito)
            var codigo_articulo = $(tr).attr("codigo_articulo")
            var cantidad = $(tr).attr("cantidad")
            var precio_unitario = $(tr).attr("precio_unitario")
            var articulo_clickeado = carrito.find(articulo => articulo.codigo_barra === codigo_articulo);
            var indice = carrito.findIndex(articulo => articulo.codigo_barra === codigo_articulo);
            carrito.splice(indice, 1) //quitar del carrito session storage
            sessionStorage.carrito = JSON.stringify(carrito)
            $(tr).remove()
            subtotal_y_total_RESTA(precio_unitario, cantidad)
            $('.cantidad_cesta').html(carrito.length)
            $(".cbo")[0].play();
            return true
        } else if (result.isDenied) {
            return false
        }
    })
    //carrito = JSON.parse(carrito)
    //console.log(carrito)
}

function cantidad_cesta(carrito) {
    console.log(carrito)
    var cantidad = 0
    for (i = 0; i < carrito.length; i++) {
        cantidad = cantidad + carrito[i].cantidad
    }
    if (carrito.length > 0) {
        $('.cantidad_cesta').html(cantidad)
    } else {
        $('.cantidad_cesta').html(0)
    }
}

function quitar_producto_de_celular(tr) {
    var img = $(tr).attr("img")
    Swal.fire({
        title: '¿Querés quitar este producto del pedido?',
        imageUrl: img,
        imageWidth: "",
        imageHeight: "700px",
        imageAlt: "title",
        showDenyButton: true,
        showCancelButton: false,
        confirmButtonText: 'SI',
        denyButtonText: `NO`,
        confirmButtonColor: 'black',
    }).then((result) => {
        /* Read more about isConfirmed, isDenied below */
        if (result.isConfirmed) {
            var carrito = sessionStorage.carrito
            carrito = JSON.parse(carrito)
            var art_id = $(tr).attr("art_id")
            var cantidad = $(tr).attr("cantidad")
            var articulo_clickeado = carrito.find(articulo => articulo.articulo === art_id);
            //console.log("articulo_clickeado", articulo_clickeado)
            var indice = carrito.findIndex(articulo => articulo.articulo === art_id);
            //console.log("indice ", indice, carrito[indice])
            carrito.splice(indice, 1) //quitar del carrito session storage
            sessionStorage.carrito = JSON.stringify(carrito)
            tr = $(tr).closest("tr")
            console.log(tr)
            $(tr).remove()
            calcular_total_celular()
            cantidad_cesta(carrito)
            //$(".cbo")[0].play();
            return true
        } else if (result.isDenied) {
            return false
        }
    })
    //carrito = JSON.parse(carrito)
    //console.log(carrito)
}


function calcular_total_celular() {
    var carrito = sessionStorage.getItem("carrito")
    var carrito = JSON.parse(carrito)
    var total = 0
    for (i = 0; i < carrito.length; i++) {
        total = total + (parseInt(carrito[i].precio) * parseInt(carrito[i].cantidad))
    }
    $('.total').html('$' + total + '.00')
}

function subtotal_y_total_RESTA(precio, cantidad) {

    var sub_articulos = $('td[sub]').attr('sub')
    var tot_articulos = $('td[tot]').attr('tot')
    //console.log("che",sub_articulos,tot_articulos)
    var total_fila_eliminada = (parseInt(precio) * parseInt(cantidad))
    //console.log(total_fila_eliminada)
    var subtotal = parseInt(total_fila_eliminada) - parseInt(tot_articulos)
    var total = parseInt(total_fila_eliminada) - parseInt(tot_articulos)
    //console.log(subtotal,total)
    $('td[sub]').attr('sub', subtotal)
    $('td[tot]').attr('tot', total)
    $('td[sub]').html(subtotal)
    $('td[tot]').html(total)
}


function metodo_servidor(pagina, metodo, data, callback) {

    $.ajax({
        type: "POST",
        url: pagina + ".aspx/" + metodo,
        data: data,
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (response) {
            callback(response.d)
        }
    });

}


function metodo_servidor_sync(pagina, metodo, data, callback) {

    $.ajax({
        type: "POST",
        url: pagina + ".aspx/" + metodo,
        data: data,
        async:false,
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (response) {
            callback(response.d)
        }
    });

}


function eliminar_registro(obj) {
    var id = $(obj).attr('obj_id');
    var pagina = $(obj).attr('url');
     var tr = $(obj).closest('tr');
     //console.log(obj)
   

    slap_confirm("Desea eliminar el registro seleccionado?", function () {
        $.ajax({
            type: "POST",
            url: pagina + "/eliminar",
            data: '{id: "' + id + '" }',
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (response) {
                tr.remove();
            }
        });
    });
 }

function eliminar_registro_msg(obj, msg) { //eliminar con toast
    var id = $(obj).attr('obj_id');
    var cuil = $(obj).attr('cuil');
    var cuil_format = cuil.replace('-', '');//quita 1 guion
    var cuil_format = cuil_format.replace('-', '');//quita el otro guion
    var own_cuil = $(obj).attr('own_cuil');
    var pagina = $(obj).attr('url');
    var tr = $(obj).closest('tr');
    if (own_cuil == cuil_format) {
        procesar_toast("No Puedes Eliminarte a ti Mismo", "error")
        return false
    } else {
    slap_confirm("Desea eliminar el registro seleccionado?", function () {
        $.ajax({
            type: "POST",
            url: pagina + "/eliminar",
            data: '{id: "' + id + '" }',
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (response) {
                tr.remove();
                procesar_toast(msg,"success")
            }
        });
    });

    }

}function eliminar_registro_msg(obj, msg) { //eliminar con toast
    var id = $(obj).attr('obj_id');
    var cuil = $(obj).attr('cuil');
    var cuil_format = cuil.replace('-', '');//quita 1 guion
    var cuil_format = cuil_format.replace('-', '');//quita el otro guion
    var own_cuil = $(obj).attr('own_cuil');
    var pagina = $(obj).attr('url');
    var tr = $(obj).closest('tr');
    if (own_cuil == cuil_format) {
        procesar_toast("No Puedes Eliminarte a ti Mismo", "error")
        return false
    } else {
    slap_confirm("Desea eliminar el registro seleccionado?", function () {
        $.ajax({
            type: "POST",
            url: pagina + "/eliminar",
            data: '{id: "' + id + '" }',
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (response) {
                tr.remove();
                procesar_toast(msg,"success")
            }
        });
    });

    }

}

function eliminar_registro_msg(obj, msg) { //eliminar con toast
    var id = $(obj).attr('obj_id');
    var cuil = $(obj).attr('cuil');
    var cuil_format = cuil.replace('-', '');//quita 1 guion
    var cuil_format = cuil_format.replace('-', '');//quita el otro guion
    var own_cuil = $(obj).attr('own_cuil');
    var pagina = $(obj).attr('url');
    var tr = $(obj).closest('tr');
    if (own_cuil == cuil_format) {
        procesar_toast("No Puedes Eliminarte a ti Mismo", "error")
        return false
    } else {
        slap_confirm("Desea eliminar el registro seleccionado?", function () {
            $.ajax({
                type: "POST",
                url: pagina + "/eliminar",
                data: '{id: "' + id + '" }',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    tr.remove();
                    procesar_toast(msg, "success")
                }
            });
        });

    }

}

function eliminar_registro_conCUIL_msg(obj, msg) { //eliminar con toast
    var id = $(obj).attr('obj_id');
    var cuil = $(obj).attr('cuil');
    var cuil_format = cuil.replace('-', '');//quita 1 guion
    var cuil_format = cuil_format.replace('-', '');//quita el otro guion
    var own_cuil = $(obj).attr('own_cuil');
    var pagina = $(obj).attr('url');
    var tr = $(obj).closest('tr');
    if (own_cuil == cuil_format) {
        procesar_toast("No Puedes Eliminarte a ti Mismo", "error")
        return false
    } else {
        slap_confirm("Desea eliminar el registro seleccionado?", function () {
            $.ajax({
                type: "POST",
                url: pagina + "/eliminar",
                data: '{id: "' + id + '",cuil: "' + cuil_format + '" }',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    tr.remove();
                    procesar_toast(msg, "success")
                }
            });
        });

    }

}




function eliminar_registro_obj(obj, msg) { //eliminar con objeto y con toast
    var id = obj.id_btn
    var pagina = obj.pagina
    var tr = obj.tr

    
    slap_confirm("Desea eliminar el registro seleccionado?", function () {
        $.ajax({
            type: "POST",
            url: pagina + "/eliminar",
            data: '{id: "' + id + '" }',
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (response) {
                tr.remove();
                procesar_toast(msg,"success")
            }
        });
    });
}
function procesar_toast(msg, icon) {

    
    const Toast = Swal.mixin({
        toast: true,
        position: 'top-end',
        showConfirmButton: false,
        timer: 4000,
        timerProgressBar: true,
        didOpen: (toast) => {
            toast.addEventListener('mouseenter', Swal.stopTimer)
            toast.addEventListener('mouseleave', Swal.resumeTimer)
        }
    })
    if (msg == undefined) {
        msg = "Registro Eliminado con Éxito"
    }
    Toast.fire({
        icon: icon,
        title: msg
    })
}



function find_input(id, from) {
    if (from != undefined) return from.find("input[id*='" + id + "']");
    return $("input[id*='" + id + "']")
}

function find_select(id, from) {
    if (from != undefined) return from.find("select[id*='" + id + "']");
    return $("select[id*='" + id + "']")
}

function find_span(id, from) {
    if (from != undefined) return from.find("span[id*='" + id + "']");
    return $("span[id*='" + id + "']")
}




function input_fecha(selector, validate) {

    anio_hoy = new Date().getFullYear()

    $(selector).datepicker({
        selectMonths: true, // Creates a dropdown to control month
        selectYears: 3,
        defaultDate: new Date(),
        yearRange: [anio_hoy - 3, anio_hoy + 5],
        format: 'dd/mm/yyyy',
        i18n: {
            labelMonthNext: 'Siguiente mes',
            labelMonthPrev: 'Mes anterior',
            labelMonthSelect: 'Seleccionar Mes',
            labelYearSelect: 'Seleccionar año',
            months: ['Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio', 'Julio', 'Agosto', 'Septiembre', 'Octubre', 'Noviembre', 'Diciembre'],
            monthsShort: ['Ene', 'Feb', 'Mar', 'Abr', 'May', 'Jun', 'Jul', 'Ago', 'Sep', 'Oct', 'Nov', 'Dic'],
            weekdays: ['Domingo', 'Lunes', 'Martes', 'Miércoles', 'Jueves', 'Viernes', 'Sábado'],
            weekdaysShort: ['Dom', 'Lun', 'Mar', 'Mie', 'Jue', 'Vie', 'Sab'],
            weekdaysAbbrev: ['D', 'L', 'M', 'X', 'J', 'V', 'S'],
            today: 'Hoy',
            clear: 'Borrar',
            cancel: 'Cerrar',
            done: 'Aceptar'
        },

    });

}



function input_fecha_from_now(selector, validate) {

    anio_hoy = new Date().getFullYear()

    $(selector).datepicker({
        selectMonths: true, // Creates a dropdown to control month
        selectYears: 3,
        yearRange: [anio_hoy-1, anio_hoy + 5],
        format: 'dd/mm/yyyy',
        i18n: {
            labelMonthNext: 'Siguiente mes',
            labelMonthPrev: 'Mes anterior',
            labelMonthSelect: 'Seleccionar Mes',
            labelYearSelect: 'Seleccionar año',
            months: ['Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio', 'Julio', 'Agosto', 'Septiembre', 'Octubre', 'Noviembre', 'Diciembre'],
            monthsShort: ['Ene', 'Feb', 'Mar', 'Abr', 'May', 'Jun', 'Jul', 'Ago', 'Sep', 'Oct', 'Nov', 'Dic'],
            weekdays: ['Domingo', 'Lunes', 'Martes', 'Miércoles', 'Jueves', 'Viernes', 'Sábado'],
            weekdaysShort: ['Dom', 'Lun', 'Mar', 'Mie', 'Jue', 'Vie', 'Sab'],
            weekdaysAbbrev: ['D', 'L', 'M', 'X', 'J', 'V', 'S'],
            today: 'Hoy',
            clear: 'Borrar',
            cancel: 'Cerrar',
            done: 'Aceptar'
        },

    });

}


function hora_valida(hora) {
    var isValid = /^([0-1][0-9]|2[0-3]):([0-5][0-9])$/.test(hora);
    return isValid
}

function fecha_valida(fecha) {
    return (Date.parse(fecha) != null)
}
function show_alert_confirm(title, descripcion,redirect) {
      Swal.fire({
        title: title,
        confirmButtonText: 'OK',
        text: descripcion
    }).then((result) => {
        /* Read more about isConfirmed, isDenied below */
        if (result.isConfirmed) {
            location.href = redirect
        } 
    })
}

function show_alert(titulo, mensaje, icono) {
    Swal.fire({//necesita sweetAlert
        icon: icono || "info",//info,warning,error,success
        title: titulo,
        text: mensaje,
        confirmButtonColor: 'black',
    })
}
function show_html_alert(titulo, icono, li_html) {
    Swal.fire({
        title: '<h5>'+ titulo +'</h5>',
        icon: icono,
        html: '<ul style="text-align:left">' + li_html + '</ul><footer>Podés quitar el empleado erroneo con el botón <b>eliminar</b> de acciones</footer>',
        showCloseButton: true,
        confirmButtonText:'<i class="fa fa-thumbs-up btn_atencion"></i> Entendido!',
    })
}


function show_alert_choose(titulo, mensaje, icono) {
    Swal.fire({//necesita sweetAlert
        icon: icono || "info",//info,warning,error,success
        title: titulo,
        text: mensaje,
        confirmButtonColor: 'black',
    })
}
function show_alert_redirect(title,text,path){
    Swal.fire({
        title: title,
        text: text,
        icon: 'error',
        showCancelButton: false,
        confirmButtonColor: 'black',
        confirmButtonText: 'OK'
    }).then((result) => {
        if (result.isConfirmed) {
            window.location.href = path;
        }
    })
}

function show_image(title, text, img) {
    Swal.fire({
        title: title,
        text: text,
        imageUrl: img,
        imageWidth: "",
        imageHeight: "700px",
        imageAlt: title
    })
}

function validarCuit(cuit) {
    var cuitNumero = cuit
    var cuit = cuitNumero.replace('-', '');
    var cuit = cuit.replace('-', '');

    if (cuit.length !== 11) {
        alert(cuit.length)
        return false;
    }
    var acumulado = 0;
    for (var i = 0; i < 10; i++) {
        acumulado += cuit[9 - i] * (2 + (i % 6));
        //console.log(i,cuit[9 - i],acumulado);
    }
    var verif = 11 - (acumulado % 11);
    //console.log('el ultimo numero tiene que ser ' + verif)
    if (verif === 11) {
        verif = 0;
    } else if (verif === 10) {
        verif = 1;
    }
    var digitos = cuitNumero.split('-');
    //console.log(digitos[2], verif)

    return digitos[2] == verif;
};


function validarEmail(email) {
    expr = /^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/;
    if (!expr.test(email)) {
        show_alert("Email Invalido", "Ingrese un Email Válido.", "warning");//necesita sweetAlert
        return false
    } else {
        return true
    }
};

function show_loading() {
    $("#loading").modal({
        escapeClose: false,
        clickClose: false,
        showClose: false
    });
}

function hide_loading() {
    $("#loading").modal('hide');
}


//function existe_usuario(url,name_func,codigo, pk) {
//var result;
//$.ajax({
//type: "POST",
//url: url + "/" + name_func,
//data: '{codigo: "' + codigo + '", objid: "'+pk+'" }',
//async: false,
//contentType: "application/json; charset=utf-8",
//dataType: "json",
//success: function (response) {
//result = response.d;
//}
//  });
//    return result == 1;
//}
