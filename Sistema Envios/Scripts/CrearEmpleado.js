$(document).ready(function () {
    var carg_Id = $("#carg_Id").val();
    $.ajax({
        url: "/Empleados/CargarCargos",
        method: "POST",
        dataType: "json",
        contentType: "application/json; charset=utf-8",
        data: JSON.stringify({ carg_Id: carg_Id }),
        success: function (data) {
            $.each(data, function (i, value) {

                $("#carg_Id").append("<option value='" + value.carg_Id + "'>" + value.carg_Description + "</option>")
            })
        }
    })

})


$(document).ready(function () {
    var depto_ID = $("#depto_ID").val();
    $.ajax({
        url: "/Empleados/cargarDeptos",
        method: "POST",
        dataType: "json",
        contentType: "application/json; charset=utf-8",
        data: JSON.stringify({ depto_ID: depto_ID }),
        success: function (data) {
            $.each(data, function (i, value) {

                $("#depto_ID").append("<option value='" + value.depto_ID + "'>" + value.depto_Descripcion + "</option>")
            })
        }
    })
})

$("#depto_ID").change(function () {

    var dep_ID = $("#depto_ID").val();
    $.ajax({
        url: "/Empleados/CargarMunicipios",
        method: "POST",
        dataType: "json",
        contentType: "application/json; charset=utf-8",
        data: JSON.stringify({ dep_ID: dep_ID }),
        success: function (data) {
            $("#ciu_ID").empty();
         
            $.each(data, function (i, value) {
                $("#ciu_ID").append("<option value='" + value.ciu_ID + "'>" + value.ciu_Descripcion + "</option>")
            })
        }
    })
})


$(document).ready(function () {

    var Id_Estado = $("#Id_Estado").val();
    $.ajax({
        url: "/Empleados/CargarEstadosCiviles",
        method: "POST",
        dataType: "json",
        contentType: "application/json; charset=utf-8",
        data: JSON.stringify({ Id_Estado: Id_Estado }),
        success: function (data) {
            $.each(data, function (i, value) {

                $("#Id_Estado").append("<option value='" + value.est_ID + "'>" + value.est_Descripcion + "</option>")
            })
        }
    })
})

