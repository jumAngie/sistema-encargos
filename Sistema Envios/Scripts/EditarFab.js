$("#lblMensaje2").hide();
$("#lblMensaje3").hide();

function Cerrar() {
    $('#FormModal').modal('hide');
}

function AbrirModal(fab_ID) {

    $.ajax({
        url: "/Fabricas/Cargar",
        method: "POST",
        dataType: "json",
        contentType: "application/json; charset=utf-8",
        data: JSON.stringify({ fab_ID: fab_ID }),
        success: function (data) {
            console.log(data);
            $('#FormModal').modal('show');
            $.each(data, function (i, value) {
                $("#txtFabrica").val(value.fab_Descripcion);
                $("#txtTelefono").val(value.fab_Telefono);
                $("#fab_ID").val(value.fab_ID);

                $("#lblMensaje2").hide();
                $("#lblMensaje3").hide();

            })



        }

    })

}



var Descripcion = $("#txtFabrica").val();
var telefono = $("#txtTelefono").val();
var ID = $("#fab_ID").val();

//if (Descripcion.val() != "" && telefono.val() != "") {


function Editar(x) {

    var Descripcion = $("#txtFabrica").val();
    var telefono = $("#txtTelefono").val();
    var ID = $("#fab_ID").val();

    if (Descripcion == "" || telefono == "") {

        if (Descripcion == "" || Descripcion == null) {
            $("#lblMensaje2").show();
            $("#txtFabrica").focus();

        }

        if (telefono == "" || telefono == null) {
            $("#lblMensaje3").show();
            $("#txtTelefono").focus();

        }
    }
    else {

        console.log(x);
        $.ajax({
            url: "/Fabricas/Editores",
            method: "POST",
            dataType: "json",
            contentType: "application/json; charset=utf-8",
            data: JSON.stringify({ ID: ID, Descripcion: Descripcion, telefono: telefono }),
            success: function (data) {

                $("#lblMensaje2").hide();
                $("#lblMensaje3").hide();
                window.location.reload();

            }

        })

    }
    //if ((telefono == "" && Descripcion == "") || (telefono == null && Descripcion == null)) {
    //        $("#lblMensaje1").show();

    // }

    //if (telefono != "" && Descripcion != "") {
    //    $('#FormModal').modal('hide');
    //    window.location.reload();
    //}
}