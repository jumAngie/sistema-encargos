$(document).ready(function () {
    var txtPedi = $("#txtPedi").val();
    $.ajax({
        url: "/PedidoDetalles/CargarPedidos",
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


$(document).ready(function () {
    var txtArticulo = $("#txtArticulo").val();
    $.ajax({
        url: "/PedidoDetalles/CargarArticulos",
        method: "POST",
        dataType: "json",
        contentType: "application/json; charset=utf-8",
        data: JSON.stringify({ txtArticulo: txtArticulo }),
        success: function (data) {
            $.each(data, function (i, value) {

                $("#txtArticulo").append("<option value='" + value.art_ID + "'>" + value.art_Descripcion + "</option>")
            })
        }
    })
})



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
        url: "/PedidoDetalles/Create",
        method: "POST",
        data: { txtPedi: txtPedi, txtArticulo: txtArticulo, txtCant: txtCant },
        success: function (data) {
            window.location.reload();
        }
    })
}