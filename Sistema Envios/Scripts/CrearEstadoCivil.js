$(function () {
    $('#btnCancelar').click(function () {
        $('#EstadoCivil').modal('hide');
    });
});

$(function () {
    $('.btn-primary').click(function () {
        $('#EstadoCivil').modal('show');
    });
});

function Insertar() {
    var estciv = $("#txtEstadoCivil").val()

    $.ajax({
        url: "/EstadosCiviles/Create",
        method: "POST",
        data: { txtEstadoCivil: estciv },
        success: function (data) {
            window.location.reload();
        }
    })
}