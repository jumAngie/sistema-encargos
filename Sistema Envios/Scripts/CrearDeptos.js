$("#lbldepto").hide();

$(function () {
    $('#btnCancelar').click(function () {
        $("#lbldepto").hide();
        $('#Departamentos').modal('hide');
    });
});

$(function () {
    $('.btn-primary').click(function () {
        $("#lbldepto").hide();
        $('#Departamentos').modal('show');
    });
});

function Insertar() {
    var id = $("#txtDeptos").val()
    if (id != "") {
        $("#lbldepto").hide();
        $.ajax({
            url: "/Departamentos/Create",
            method: "POST",
            data: { txtDeptos: id },
            success: function (data) {
                window.location.reload();
            }
        })

    }
    else {

        $("#lbldepto").show();
        $("#txtDeptos").focus();
    }

}