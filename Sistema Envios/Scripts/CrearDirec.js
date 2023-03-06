$("#lblClienteID").hide();
$("#lblDirec").hide();
$("#lblDep_ID").hide();
$("#lblCiu_ID").hide();



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
        $("#lblClienteID").hide();
        $("#lblDirec").hide();
        $("#lblDep_ID").hide();
        $("#lblCiu_ID").hide();
        $('#Direc').modal('hide');
    });
});

$(function () {
    $('.btn-primary').click(function () {
        $('#Direc').modal('show');
    });
});

function Insertar() {
    var client_ID = $("#client_ID").val();
    var txtDirec = $("#txtDirec").val();
    var dep_ID = $("#dep_ID").val();
    var ciu_ID = $("#ciu_ID").val();

    if (client_ID != "0" && txtDirec != "" && dep_ID != "0" && ciu_ID != "0") {

        $("#lblClienteID").hide();
        $("#lblDirec").hide();
        $("#lblDep_ID").hide();
        $("#lblCiu_ID").hide();

        $.ajax({
            url: "/Direcciones/Create",
            method: "POST",
            data: { client_ID: client_ID, txtDirec: txtDirec, dep_ID: dep_ID, ciu_ID: ciu_ID },
            success: function (data) {
                window.location.reload();
            }
        })
    }
    else {

        if (client_ID == "0") {
            $("#lblClienteID").show();
        }
        if (dep_ID == "0") {
            $("#lblDep_ID").show();
        }
        if (ciu_ID == "0" || ciu_ID == "" || ciu_ID == null) {
            $("#lblCiu_ID").show();
        }
        if (txtDirec == "") {
            $("#lblDirec").show();
        }


        if (client_ID != "0") {
            $("#lblClienteID").hide();
        }
        if (dep_ID != "0") {
            $("#lblDep_ID").hide();
        }
        if (ciu_ID != "0" && ciu_ID != null) {
            $("#lblCiu_ID").hide();
        }
        if (txtDirec != "") {
            $("#lblDirec").hide();
        }

    }




}