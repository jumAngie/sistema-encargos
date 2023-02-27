
$("#depto_ID").change(function () {

    var depto_ID = $("#depto_ID").val();
    $.ajax({
        url: "/Empleados/CargarMunicipios",
        method: "POST",
        dataType: "json",
        contentType: "application/json; charset=utf-8",
        data: JSON.stringify({ depto_ID: depto_ID }),
        success: function (data) {
            $("#ciu_ID").empty();
            $("#ciu_ID").append("<option value= '0' >Seleccione un Municipio</option>");

            $.each(data, function (i, value) {
                $("#ciu_ID").append("<option value='" + value.ciu_ID + "'>" + value.ciu_Descripcion + "</option>")
            })
        }
    })
})