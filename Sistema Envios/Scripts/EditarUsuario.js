
$(document).ready(function (ID) {
    //var emp_Id = $("#emp_Id").val();
    var rol_ID = $("#rol_ID").val();
    //$.ajax({
    //    url: "/Usuarios/CargarEmpleado",
    //    method: "POST",
    //    dataType: "json",
    //    contentType: "application/json; charset=utf-8",
    //    data: JSON.stringify({ emp_Id: emp_Id }),
    //    success: function (data) {
    //        $.each(data, function (i, value) {

    //            $("#emp_Id").append("<option value='" + value.emp_Id + "'>" + value.emp_Nombre + "</option>")
    //        })
    //    }
    //})
    //$.ajax({
    //    url: "/Usuarios/CargarRol",
    //    method: "POST",
    //    dataType: "json",
    //    contentType: "application/json; charset=utf-8",
    //    data: JSON.stringify({ rol_ID: rol_ID }),
    //    success: function (data) {
    //        $.each(data, function (i, value) {

    //            $("#rol_ID").append("<option value='" + value.rol_ID + "'>" + value.rol_Descripcion + "</option>")
    //        })
    //    }
    //})
})


$(function () {
    $('#Cancelar').click(function () {
        $("#labelusuE").hide();
        $("#labeladminE").hide();
        $("#labelcargoE").hide();
        $('#EditUsuarios').modal('hide');
    });
});

function AbrirEditar(ID) {
    console.log(ID);
    var rol_ID = $("#rol_IDE").val();
    $.ajax({
        url: "/Usuarios/CargarRol",
        method: "POST",
        dataType: "json",
        contentType: "application/json; charset=utf-8",
        data: JSON.stringify({ rol_ID: rol_ID }),
        success: function (data) {
            $.each(data, function (i, value) {

                $("#rol_IDE").append("<option value='" + value.rol_ID + "'>" + value.rol_Descripcion + "</option>")
            })
        }
    })
    $.ajax({
        url: "/Usuarios/CargarUsuario",
        method: "POST",
        dataType: "json",
        contentType: "application/json; charset=utf-8",
        data: JSON.stringify({ ID: ID }),
        success: function (data) {
            $('#EditUsuarios').modal('show');
            console.log(data);
            $.each(data, function (i, value) {
                $("#txtUsuarioE").val(value.usu_Usuario);
                //$("#txtClave").val(value.usu_Clave);
                //$("#emp_Id").val(value.emp_Id);
                $("#rol_IDE").val(value.rol_ID);
                //$("#ckEsAdmin").val(value.usu_EsAdmin);
                if (value.usu_EsAdmin = true) {
                    $('#ckEsAdminE').prop("checked") = true;
                }
                if (value.usu_EsAdmin = false) {
                    $('#ckEsAdminE').prop("checked") = false;
                }
            })
        }
    })
}

function Editar(ID) {
    var usuarioE = $("#txtUsuarioE").val()
    //var clave = $("#txtClave").val()
    //var empleado = $("#emp_Id").val()
    var admE
    if ($('#ckEsAdminE').prop("checked") == true) {
        admE = 1;
    }
    if ($('#ckEsAdminE').prop("checked") == false) {
        admE = 0;
    }

    var rolE = $("#rol_IDE").val()
    if (usuarioE == "") {
        $("#labelusuE").text('*');
    }
    if (usuarioE != "") {
        $("#labelusuE").text(' ');
    }

    //if (clave == "") {
    //    $("#labelclave").text('*');
    //}
    //if (clave != "") {
    //    $("#labelclave").text(' ');
    //}

    //if (empleado == 0) {
    //    $("#labelemp").text('*');
    //}
    //if (empleado != 0) {
    //    $("#labelemp").text(' ');
    //}

    if ($('#ckEsAdminE').prop("checked") == true) {
        rolE.disabled = true;
    }
    if ($('#ckEsAdminE').prop("checked") == true) {
        if (rolE == 0) {
            $("#labelcargoE").text('*');
        }
        if (rolE != 0) {

        } {
            $("#labelcargoE").text(' ');
        }
    }
    if (usuarioE == "" /*|| clave == "" || empleado == 0*/) {
    }
    else {
        if (rolE == 0 && admE == "" || rolE != 0 && admE != "") {
            $("#labeladminE").text('Debe escoger uno solo');
        }
        else {
            $.ajax({
                url: "/Usuarios/EditarUsu",
                method: "POST",
                data: { usu_ID: ID, txtUsuario: usuarioE, ckEsAdminE: admE, rol_ID: rolE },
                success: function (data) {
                    window.location.reload();
                }
            })
        }

    }

    $('#EditUsuarios').modal('hide');
}