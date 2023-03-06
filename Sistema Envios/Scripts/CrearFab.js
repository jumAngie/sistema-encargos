$("#lblNombre").hide();
$("#lblTelefono").hide();
$("#lblTeleLetra").hide();

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

    
    var txtFab = $("#txtFab").val()
    var txtTel = $("#txtTel").val()

    console.log(txtFab)
    console.log(txtTel)

    if ($("#txtFab").val() == "" || $("#txtTel").val()  == "") {

        if ($("#txtFab").val() == "") {
            $("#lblNombre").show();
            
        }
        if ($("#txtTel").val() == "") {
            document.getElementById("lblTelefono").style.display = "inline";
        }

        if ($("#txtFab").val() != "") {
            $("#lblNombre").hide();

        }
        if ($("#txtTel").val() != "") {
            $("#lblTelefono").hide();
        }
    }
    else {
        if ($("#txtTel").val().includes("e")) {
            document.getElementById("lblTeleLetra").style.display = "inline";
        }
        else {
            $.ajax({
                url: "/Fabricas/Create",
                method: "POST",
                data: { txtFab: txtFab, txtTel: txtTel },
                success: function (data) {
                    window.location.reload();
                }
            })
        }
        
    }


}