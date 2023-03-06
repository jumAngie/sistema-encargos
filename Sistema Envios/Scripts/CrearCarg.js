
$(function () {
    $('#btnCancelar').click(function () {
        window.location.reload();
        $('#Cargos').modal('hide');

    });
});

$(function () {
    $('.btn-primary').click(function () {
        $('#Cargos').modal('show');
    });
});

function Insertar() {
    var txtCargos = $("#txtCargos").val()

    if (txtCargos == "") {
        $("#lblCargo").show();
    }
    else {
        $("#lblCargo").hide();
        $.ajax({
            url: "/Cargos/Create",
            method: "POST",
            data: { txtCargos: txtCargos },
            success: function (data) {
                window.location.reload();
            }
        })
    }

}