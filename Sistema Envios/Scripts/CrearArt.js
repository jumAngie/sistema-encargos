$(document).ready(function () {

    var fabrica_ID = $("#fabrica_ID").val();
    $.ajax({
        url: "/Articulos/CargarFabricasCrear",
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

    var txtArt = $("#txtArt").val()
    var fabrica_ID = $("#fabrica_ID").val()
    var txtStock = $("#txtStock").val()

    if ($("#txtArt").val() == "" || $("#fabrica_ID").val() == "0" || $("#txtStock").val() == "") {
        if ($("#txtArt").val() == "") {
            document.getElementById("lblArticulo").style.display = "inline";
        }
        if ($("#fabrica_ID").val() == "0") {
            document.getElementById("lblfabrica").style.display = "inline";
        }
        if ($("#txtStock").val() == "") {
            document.getElementById("lblStock").style.display = "inline";
        }
        
    }
    else {

        var Stock = parseInt($("#txtStock").val());
        if (Stock < 0) {
            document.getElementById("lblStock2").style.display = "inline";
        }
        else {
            $.ajax({
                url: "/Articulos/Create",
                method: "POST",
                data: { txtArt: txtArt, fabrica_ID: fabrica_ID, txtStock: txtStock },
                success: function (data) {
                    window.location.reload();
                }
            });
        }
            

        }

    }