$(document).ready(function () {
    var pedi_DireccionID = $("#pedi_DireccionID").val();
    var estv_Id = $("#estv_Id").val();
    var emp_Id = $("#emp_Id").val();
    $.ajax({
        url: "/Pedidos/CargarDirecciones",
        method: "POST",
        dataType: "json",
        contentType: "application/json; charset=utf-8",
        data: JSON.stringify({ pedi_DireccionID: pedi_DireccionID }),
        success: function (data) {
            $.each(data, function (i, value) {

                $("#pedi_DireccionID").append("<option value='" + value.direc_ID + "'>" + value.direc_DireccionExacta + "</option>")
            })
        }
    })
    $.ajax({
        url: "/Pedidos/CargarEstadoEnvio",
        method: "POST",
        dataType: "json",
        contentType: "application/json; charset=utf-8",
        data: JSON.stringify({ estv_Id: estv_Id }),
        success: function (data) {
            $.each(data, function (i, value) {

                $("#estv_Id").append("<option value='" + value.estv_Id + "'>" + value.estv_Description + "</option>")
            })
        }
    })
    $.ajax({
        url: "/Pedidos/CargarEmpleados",
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