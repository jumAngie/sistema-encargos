$(document).ready(function () {

    var fabrica_ID = $("#fabrica_ID").val();
    $.ajax({
        url: "/Articulos/CargarFabricas",
        method: "POST",
        dataType: "json",
        contentType: "application/json; charset=utf-8",
        data: JSON.stringify({ fabrica_ID: fabrica_ID }),
        success: function (data) {
            $.each(data, function (i, value) {

                $("#fabrica_ID").append("<option value='" + value.fab_ID + "'>" + value.fab_Descripcion + "</option>")
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
    var fabrica = $("#fabrica_ID").val()
    var stock = $("#txtStock").val()

    if (articulo == null || fabrica == "0" || stock == null) {
        if (articulo == "") {
            document.getElementById("lblArticulo").style.display = "inline";
        }
        else {
            document.getElementById("lblArticulo").style.display = "none";
        }

        if (fabrica == "0") {
            document.getElementById("lblfabrica").style.display = "inline";
        }
        else {
            document.getElementById("lblfabrica").style.display = "none";
        }

        if (stock == "") {
            document.getElementById("lblStock").style.display = "inline";
        }
        else {
            document.getElementById("lblStock").style.display = "none";
        }
        
    }
    else {
        $.ajax({
            url: "/Articulos/Create",
            method: "POST",
            data: { txtArt: articulo, fab_ID: fabrica, txtStock: stock },
            success: function (data) {
                window.location.reload();
            }
        })
    }

}
