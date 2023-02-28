$(function () {
    $('#btnCancelar').click(function () {
        $('#Departamentos').modal('hide');
    });
});

$(function () {
    $('.btn-primary').click(function () {
        $('#Departamentos').modal('show');
    });
});

function Insertar() {
    var id = $("#txtDeptos").val()
    $.ajax({
        url: "/Departamentos/Create",
        method: "POST",
        data: { txtDeptos: id },
        success: function (data) {
            window.location.reload();
        }
    })
}