$("#Code").hide();
$("#lblArticuloID").hide();
$("#lblCantidad").hide();



$(document).ready(function () {

    var txtPedidoCode = $("#txtPedidoCode").val();
    $.ajax({
        url: "/PedidoDetalles/CARGARCODIGOS",
        method: "POST",
        dataType: "json",
        contentType: "application/json; charset=utf-8",
        data: JSON.stringify({ txtPedidoCode: txtPedidoCode }),
        success: function (data) {
            $.each(data, function (i, value) {

                $("#txtPedidoCode").append("<option value='" + value.pedi_ID + "'>" + value.pedi_Code + "</option>")
            })
        }
    })
})

$(document).ready(function () {

    var txtArticuloID = $("#txtArticuloID").val();
    $.ajax({
        url: "/PedidoDetalles/CARGARARTICULOSdet",
        method: "POST",
        dataType: "json",
        contentType: "application/json; charset=utf-8",
        data: JSON.stringify({ txtArticuloID: txtArticuloID }),
        success: function (data) {
            $.each(data, function (i, value) {

                $("#txtArticuloID").append("<option value='" + value.art_ID + "'>" + value.art_Descripcion + "</option>")
            })
        }
    })
})


function Cerrar() {
    $('#Modal-Det').modal('hide');
    $("#Code").hide();
    $("#lblArticuloID").hide();
    $("#lblCantidad").hide();
    window.location.reload();
}


function AbrirModal(det_ID) {

    $.ajax({
        url: "/PedidoDetalles/Cargar",
        method: "POST",
        dataType: "json",
        contentType: "application/json; charset=utf-8",
        data: JSON.stringify({ det_ID: det_ID }),
        success: function (data) {
            console.log(data);
            $('#Modal-Det').modal('show');
            $.each(data, function (i, value) {
                $("#det_ID").val(value.pedi_ID);
                $("#txtPedidoCode").val(value.pedi_ID);
                $("#txtArticuloID").val(value.art_ID);
                $("#txtCantid").val(value.det_Cantidad);

                $("#Code").hide();
                $("#lblArticuloID").hide();
                $("#lblCantidad").hide();

            })



        }

    })

}


function Editar(x) {


    var txtPedidoCode = $("#txtPedidoCode").val();
    var txtArticuloID = $("#txtArticuloID").val();
    var txtCantid = $("#txtCantid").val();
    var det_ID = $("#det_ID").val();

    if (txtPedidoCode != "0" && txtArticuloID != "0" && txtCantid !="" ) {

        var stocknegativo = parseInt(txtCantid);
        if (stocknegativo < 0) {
            $("#lblCantidad").show();
        }
        else {
            $.ajax({
                url: "/PedidoDetalles/Editores",
                method: "POST",
                dataType: "json",
                contentType: "application/json; charset=utf-8",
                data: JSON.stringify({ det_ID: det_ID, txtCantid: txtCantid, txtArticuloID: txtArticuloID, txtPedidoCode: txtPedidoCode }),
                success: function (data) {

                    $("#Code").hide();
                    $("#lblArticuloID").hide();
                    $("#lblCantidad").hide();
                    window.location.reload();
                }

            })
            $("#Code").hide();
            $("#lblArticuloID").hide();
            $("#lblCantidad").hide();
            window.location.reload();
        }


    }
    else {

        if (txtPedidoCode == "0") {
            $("#Code").show();
        }
        if (txtArticuloID == "0") {
            $("#lblArticuloID").show();

        }
        if (txtCantid == "") {
            $("#lblCantidad").show();
        }

        if (txtPedidoCode != "0") {
            $("#Code").hide();
        }
        if (txtArticuloID != "0") {
            $("#lblArticuloID").hide();

        }
        if (txtCantid != "") {
            $("#lblCantidad").hide();
        }

    }





}