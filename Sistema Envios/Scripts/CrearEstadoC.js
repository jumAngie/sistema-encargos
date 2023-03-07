$("#lblEstadoC").hide();

$(function () {
    $('#btnCancelar').click(function () {
        $('#EstadoCivil').modal('hide');
        window.location.reload();
    });
});

$(function () {
    $('.btn-primary').click(function () {
        $('#EstadoCivil').modal('show');
    });
});

function Insertar() {
    var estciv = $("#txtEstadoCivil").val()

    if (estciv != "" && estciv != null) {


        $("#lblEstadoC").hide();

        $.ajax({
            url: "/EstadosCiviles/Create",
            method: "POST",
            data: { txtEstadoCivil: estciv },
            success: function (data) {
                $("#lblEstadoC").hide();
                window.location.reload();

            }
        })
    }
    else {
        $("#lblEstadoC").show();
        $("#txtEstadoCivil").focus();
    }
}