$(document).ready(function () {

    var Depto = $("#Depto").val();
    $.ajax({
        url: "/Ciudades/CargarDepto",
        method: "POST",
        dataType: "json",
        contentType: "application/json; charset=utf-8",
        data: JSON.stringify({ Depto: Depto }),
        success: function (data) {
            $.each(data, function (i, value) {

                $("#Depto").append("<option value='" + value.depto_ID + "'>" + value.depto_Descripcion + "</option>")
            })
        }
    })
})

$(function () {
    $('#btnCancelar').click(function () {
        $('#Ciudades').modal('hide');
    });
});

$(function () {
    $('.btn-primary').click(function () {
        $('#Ciudades').modal('show');
    });
});

function Insertar() {

    var Depto = $("#Depto").val()
    var muni = $("#muni").val()

    if (muni == null || Depto == "0") {
        if (muni == "") {
            document.getElementById("lblDepto").style.display = "inline";
        }
        else {
            document.getElementById("lblDepto").style.display = "none";
        }

        if (Depto == "0") {
            document.getElementById("lblMunicipio").style.display = "inline";
        }
        else {
            document.getElementById("lblMunicipio").style.display = "none";
        }

    }
    else {
        $.ajax({
            url: "/Ciudades/Create",
            method: "POST",
            data: { Depto: Depto, muni: muni},
            success: function (data) {
                window.location.reload();
            }
        })
    }

}