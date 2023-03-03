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

