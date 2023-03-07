console.log($("#emp").val());

$(document).ready(function () {

    var emp = $("#emp").val();
    $.ajax({
        url: "/Pedidos/CargarEmpleadosEditar",
        method: "POST",
        dataType: "json",
        contentType: "application/json; charset=utf-8",
        data: JSON.stringify({ emp: emp }),
        success: function (data) {
            $.each(data, function (i, value) {

                $("#emp_Des").append("<option value='" + value.emp_Id + "'>" + value.emp_Name + "</option>")
            })
        }
    })
 })




$(document).ready(function () {

    var emp_Id = $("#emp_Id").val();
    $.ajax({
        url: "/Pedidos/CargarEncargadoEditar",
        method: "POST",
        dataType: "json",
        contentType: "application/json; charset=utf-8",
        data: JSON.stringify({ emp_Id: emp_Id }),
        success: function (data) {
            $.each(data, function (i, value) {

                $("#emp_Id").append("<option value='" + value.emp_Id + "'>" + value.emp_Nombre + "</option>")
            })
        }
    })

})

/*$("#emp_Id").val() = $("#emp").val();*/


$(document).ready(function () {
    var client_Id = $("#client_Id").val();
    $.ajax({
        url: "/Pedidos/CargarClientesEditar",
        method: "POST",
        dataType: "json",
        contentType: "application/json; charset=utf-8",
        data: JSON.stringify({ client_Id: client_Id }),
        success: function (data) {
            $.each(data, function (i, value) {

                $("#client_Id").append("<option value='" + value.client_ID + "'>" + value.client_Nombre + "</option>")
            })
        }
    })


})


$("#client_Id").change(function () {

    var client_Id = $("#client_Id").val();
    $.ajax({
        url: "/Pedidos/cargarDireccionDeClienteEditar",
        method: "POST",
        dataType: "json",
        contentType: "application/json; charset=utf-8",
        data: JSON.stringify({ client_Id: client_Id }),
        success: function (data) {
            $("#pedi_DireccionID").empty();

            $.each(data, function (i, value) {
                $("#pedi_DireccionID").append("<option value='" + value.direc_ID + "'>" + value.direc_DireccionExacta + "</option>")
            })
        }
    })
})


$(document).ready(function () {

    var direc = $("#direc").val();
    $.ajax({
        url: "/Pedidos/CargarClientePorDirecEdit",
        method: "POST",
        dataType: "json",
        contentType: "application/json; charset=utf-8",
        data: JSON.stringify({ direc: direc }),
        success: function (data) {
            $.each(data, function (i, value) {

                $("#clien").append("<option value='" + value.client_ID + "'>" + value.client_Nombre + "</option>")
            })
        }
    })

})

