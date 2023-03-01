$(document).ready(function () {
    var txtPedi = $("#txtPedi").val();
    $.ajax({
        url: "/PedidosDetalles/CargarPedidos",
        method: "POST",
        dataType: "json",
        contentType: "application/json; charset=utf-8",
        data: JSON.stringify({ txtPedi: txtPedi }),
        success: function (data) {
            $.each(data, function (i, value) {

                $("#txtPedi").append("<option value='" + value.pedi_ID + "'>" + value.pedi_Code + "</option>")
            })
        }
    })
})


// articulos
//$(document).ready(function () {
//    var dep_ID = $("#dep_ID").val();
//    $.ajax({
//        url: "/PedidosDetalles/",
//        method: "POST",
//        dataType: "json",
//        contentType: "application/json; charset=utf-8",
//        data: JSON.stringify({ dep_ID: dep_ID }),
//        success: function (data) {
//            $.each(data, function (i, value) {

//                $("#dep_ID").append("<option value='" + value.depto_ID + "'>" + value.depto_Descripcion + "</option>")
//            })
//        }
//    })
//})



$(function () {
    $('#btnCancelar').click(function () {
        $('#Detalles').modal('hide');
    });
});

$(function () {
    $('.btn-primary').click(function () {
        $('#Detalles').modal('show');
    });
});

function Insertar() {
    var txtPedi = $("#txtPedi").val()
    var txtArticulo = $("#txtArticulo").val()
    var txtCant = $("#txtCant").val()
    $.ajax({
        url: "/PedidosDetalles/Create",
        method: "POST",
        data: { txtPedi: txtPedi, txtArticulo: txtArticulo, txtCant: txtCant },
        success: function (data) {
            window.location.reload();
        }
    })
}