$("#lblMensaje1").hide();


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
 
        //if (Descripcion.val() == "") {
        //    $("#lblMensaje1").show();
        //    $("#txtFabrica").focus();
        //    $("#lblMensaje1").show();
        //    $('#FormModal').modal('show');

        //}

        //if (telefono.val() == "") {
        //    $("#lblMensaje2").show();
        //    $("#txtTelefono").focus();
        //    /*  $('#FormModal').modal('show');*/
        //}
        //if (telefono.val() == "" && Descripcion.val() == "") {
        //    $("#lblMensaje3").show();
        //    /*   $('#FormModal').modal('show');*/
        //}

        //else {
             console.log(x);   
            $.ajax({
                url: "/Fabricas/Editores",
                method: "POST",
                dataType: "json",
                contentType: "application/json; charset=utf-8",
                data: JSON.stringify({ ID: ID, Descripcion: Descripcion, telefono: telefono }),
                success: function (data) {


                    window.location.reload();

                }



            })
        /*    $('#FormModal').modal('hide');*/
}




/*}*/

    


