$(function () {
    $('#btnCancelar').click(function () {
        $('#Fabricas').modal('hide');
    });
});

$(function () {
    $('.btn-primary').click(function () {
        $('#Fabricas').modal('show');
    });
});

function Insertar() {
    var fabrica = $("#txtFabrica").val()
    var telefono = $("#txtTelefono").val()
    
    $.ajax({
        url: "/Fabricas/Create",
        method: "POST",
        data: { txtFabrica: fabrica, txtTelefono: telefono },
        success: function (data) {
            window.location.reload();
        }
    })
}