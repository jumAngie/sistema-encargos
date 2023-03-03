$(document).ready(function () {
    var txtArticulo = $("#txtArticulo").val();
    $.ajax({
        url: "/Clientes/CargarArticulos",
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
    $('#btnCerrar').click(function () {
        $('#modal-insertar').modal('hide');
    });
});

$(function () {
    $('#btnAbrir').click(function () {
        $('#modal-insertar').modal('show');
    });
});

//function AbrirM(PEDIDO) {


//    $.ajax({
//        url: "/Clientes/InsertarDetalles",
//        method: "POST",
//        dataType: "json",
//        contentType: "application/json; charset=utf-8",
//        data: JSON.stringify({ PEDIDO: PEDIDO }),
//        success: function (data) {
//            console.log(data);
//            $('#FormModal').modal('show');
//            $.each(data, function (i, value) {
//                $("#carg_Id").val(value.carg_Id);
//                $("#txtCargo").val(value.carg_Description);


//            })



//        }

//    })
//}

