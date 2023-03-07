$("#lblStockNegativo").hide();
$("#lblCant").hide();
$("#lblArt").hide();
$("#lblCode").hide();


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
        $("#lblStockNegativo").hide();
        $("#lblCant").hide();
        $("#lblArt").hide();
        $("#lblCode").hide();
        $('#Detalles').modal('hide');
        window.location.reload();
    });
});

$(function () {
    $('.btn-primary').click(function () {
        $("#lblStockNegativo").hide();
        $("#lblCant").hide();
        $("#lblArt").hide();
        $("#lblCode").hide();
        $('#Detalles').modal('show');
    });
});

function Insertar() {
    var txtPedi = $("#txtPedi").val()
    var txtArticulo = $("#txtArticulo").val()
    var txtCant = $("#txtCant").val()

    if (txtPedi != "0" && txtArticulo != "0" && txtCant != "") {

        if (txtCant.includes("e")) {
            $("#lblStockNegativo").show();
            $("#txtCant").focus();
        }
        else {

            $.ajax({
                url: "/PedidoDetalles/Create",
                method: "POST",
                data: { txtPedi: txtPedi, txtArticulo: txtArticulo, txtCant: txtCant },
                success: function (data) {
                    window.location.reload();
                }
            })

        }

    }
    else {
        if (txtPedi == "0") {
            $("#lblCode").show();
            $("#txtPedi").focus();

        }
        if (txtArticulo == "0") {
            $("#lblArt").show();
            $("#txtArticulo").focus();
        }
        if (txtCant == "") {
            $("#lblCant").show();
            $("#txtCant").focus();
        }
        if (txtPedi != "0") {
            $("#lblCode").hide();

        }
        if (txtArticulo != "0") {
            $("#lblArt").hide();
        }
        if (txtCant != "") {
            $("#lblCant").hide();
        }

    }

}