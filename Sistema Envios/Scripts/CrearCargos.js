
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
        var id = $("#txtCargo").val()
        $.ajax({
            url: "/Cargos/Create",
            method: "POST",
            data: { txtCargo: id },
            success: function (data) {
                window.location.reload();
            }
        })
    }