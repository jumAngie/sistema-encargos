$(document).ready(function () {
    var client_ID = $("#client_ID").val();
    $.ajax({
        url: "/Direcciones/CargarCliente",
        method: "POST",
        dataType: "json",
        contentType: "application/json; charset=utf-8",
        data: JSON.stringify({ client_ID: client_ID }),
        success: function (data) {
            $.each(data, function (i, value) {

                $("#client_ID").append("<option value='" + value.client_ID + "'>" + value.client_Nombre + "</option>")
            })
        }
    })
})



$(document).ready(function () {
    var dep_ID = $("#dep_ID").val();
    $.ajax({
        url: "/Direcciones/CargarDepartamentos",
        method: "POST",
        dataType: "json",
        contentType: "application/json; charset=utf-8",
        data: JSON.stringify({ dep_ID: dep_ID }),
        success: function (data) {
            $.each(data, function (i, value) {

                $("#dep_ID").append("<option value='" + value.depto_ID + "'>" + value.depto_Descripcion + "</option>")
            })
        }
    })
})

$("#dep_ID").change(function () {

    var dep_ID = $("#dep_ID").val();
    $.ajax({
        url: "/Direcciones/CargarMunicipios",
        method: "POST",
        dataType: "json",
        contentType: "application/json; charset=utf-8",
        data: JSON.stringify({ dep_ID: dep_ID }),
        success: function (data) {
            $("#ciu_ID").empty();
            $("#ciu_ID").append("<option value= '0' > Seleccione un Municipio</option>");

            $.each(data, function (i, value) {
                $("#ciu_ID").append("<option value='" + value.ciu_ID + "'>" + value.ciu_Descripcion + "</option>")
            })
        }
    })
})


$(function () {
    $('#btnCancelar').click(function () {
        $('#Direc').modal('hide');
    });
});

$(function () {
    $('.btn-primary').click(function () {
        $('#Direc').modal('show');
    });
});

//function Insertar() {
//    var id = $("#txtCargo").val()
//    $.ajax({
//        url: "/Cargos/Create",
//        method: "POST",
//        data: { txtCargo: id },
//        success: function (data) {
//            window.location.reload();
//        }
//    })
//}
