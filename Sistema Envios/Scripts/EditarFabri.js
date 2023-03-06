$("#lblMensaje2").hide();
$("#lblMensaje3").hide();

function Cerrar() {
    $('#FormModal').modal('hide');
}

function AbrirModal(fabri_ID) {
    console.log(fabri_ID)
    $.ajax({
        url: "/Fabricas/Cargar",
        method: "POST",
        dataType: "json",
        contentType: "application/json; charset=utf-8",
        data: JSON.stringify({ fabri_ID: fabri_ID }),
        success: function (data) {
            console.log(data);
            $('#FormModal').modal('show');
            $.each(data, function (i, value) {
                $("#txtFabrica").val(value.fab_Descripcion);
                $("#txtTelefono").val(value.fab_Telefono);
                $("#fabri_ID").val(value.fab_ID);
                
                $("#lblMensaje2").hide();
                $("#lblMensaje3").hide();

                
            })



        }

    })

}

                var Descripcion = $("#txtFabrica").val();
                var telefono = $("#txtTelefono").val();
                var ID = $("#fabri_ID").val();

                console.log(ID)



//if (Descripcion.val() != "" && telefono.val() != "") {


function Editar(x) {

    var Descripcion = $("#txtFabrica").val();
    var telefono = $("#txtTelefono").val();
    var ID = $("#fabri_ID").val();

    if (Descripcion != "" && telefono != "") {

        console.log(Descripcion)
        console.log(telefono)
        console.log(ID)

        $.ajax({
            url: "/Fabricas/Editores",
            method: "POST",
            dataType: "json",
            contentType: "application/json; charset=utf-8",
            data: JSON.stringify({ ID: ID, Descripcion: Descripcion, telefono: telefono }),
            success: function (data) {

            }

        })

       $('#FormModal').modal('hide');
        window.location.reload()

    }
    else {
        if (Descripcion == "" || Descripcion == null) {
            $("#lblMensaje2").show();
            $("#txtFabrica").focus();

        }

        if (telefono == "" || telefono == null) {
            $("#lblMensaje3").show();
            $("#txtTelefono").focus();

        }
    }
    
}