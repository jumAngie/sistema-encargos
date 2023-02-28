$(document).ready(function () {

    var fab_ID = $("#fab_ID").val();
    $.ajax({
        url: "/Articulos/CargarFabricas",
        method: "POST",
        dataType: "json",
        contentType: "application/json; charset=utf-8",
        data: JSON.stringify({ fab_ID: fab_ID }),
        success: function (data) {
            $.each(data, function (i, value) {
                
                $("#fab_ID").append("<option value='" + value.fab_ID + "'>" + value.fab_Descripcion + "</option>")
            })
        }
    })
})


$(function () {
    $('#btnCancelar').click(function () {
        $('#Articulos').modal('hide');
    });
});

$(function () {
    $('.btn-primary').click(function () {
        $('#Articulos').modal('show');
    });
});

function Insertar() {
    var articulo = $("#txtArt").val()
    var fabrica = $("#fab_ID").val()
    var stock = $("#txtStock").val()

    $.ajax({
        url: "/Articulos/Create",
        method: "POST",
        data: { txtArt: articulo, fab_ID: fabrica, txtStock: stock },
        success: function (data) {
            window.location.reload();
        }
    })
}
