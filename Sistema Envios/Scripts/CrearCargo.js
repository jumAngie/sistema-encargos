
$(function () {
    $('#btnCancelar').click(function () {
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
    $.ajax({
        url: "/Cargos/Create",
        method: "POST",
        data: { txtCargos: txtCargos },
        success: function (data) {
            window.location.reload();
        }
    })
}