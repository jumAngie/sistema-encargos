////$(function Ocultar() {
////    $("#labelusu").text('');
////    $("#labelclave").text('');
////    $("#labelemp").text('');
////    $("#labeladmin").text('');
////    $("#labelcargo").text('');
////});

$(document).ready(function () {
    var emp_Id = $("#emp_Id").val();
    var rol_ID = $("#rol_ID").val();
    $.ajax({
        url: "/Usuarios/CargarEmpleados",
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
    $.ajax({
        url: "/Usuarios/CargarRoles",
        method: "POST",
        dataType: "json",
        contentType: "application/json; charset=utf-8",
        data: JSON.stringify({ rol_ID: rol_ID }),
        success: function (data) {
            $.each(data, function (i, value) {

                $("#rol_ID").append("<option value='" + value.rol_ID + "'>" + value.rol_Descripcion + "</option>")
            })
        }
    })
})


$(function () {
    $('#btnCancelar').click(function () {
        $("#labelusu").hide();
        $("#labelclave").hide();
        $("#labelemp").hide();
        $("#labeladmin").hide();
        $("#labelcargo").hide();
        $('#Usuarios').modal('hide');
    });
});

$(function () {
    $('.btn-primary').click(function () {
        $('#Usuarios').modal('show');
    });
});

function Insertar() {
    var usuario = $("#txtUsuario").val()
    var clave = $("#txtClave").val()
    var empleado = $("#emp_Id").val()
    var adm
    if ($('#ckEsAdmin').prop("checked") == true) {
        adm = 1;
    }
    if ($('#ckEsAdmin').prop("checked") == false) {
        adm = 0;
    }

    var rol = $("#rol_ID").val()
    if (usuario == "") {
        $("#labelusu").text('*');
    }
    if (usuario != "") {
        $("#labelusu").hide();
    }

    if (clave == "") {
        $("#labelclave").text('*');
    }
    if (clave != "") {
        $("#labelclave").hide();
    }

    if (empleado == 0) {
        $("#labelemp").text('*');
    }
    if (empleado != 0) {
        $("#labelemp").hide();
    }

    if ($('#ckEsAdmin').prop("checked") == true) {
        rol.disabled = true;
    }
    if ($('#ckEsAdmin').prop("checked") == true) {
        if (rol == 0) {
            $("#labelcargo").text('*');
        }
        if (rol != 0) {

        } {
            $("#labelcargo").hide();
        }
    }
    if (usuario == "" || clave == "" || empleado == 0) {
    }
    else {
        if (rol == 0 && adm == "") {
            $("#labeladmin").text('Debe escoger uno solo');
        }
        else {
            $.ajax({
                url: "/Usuarios/Create",
                method: "POST",
                data: { txtUsuario: usuario, txtClave: clave, emp_Id: empleado, ckEsAdmin: adm, rol_ID: rol },
                success: function (data) {
                    window.location.reload();

                }
            })

        }

    }

}