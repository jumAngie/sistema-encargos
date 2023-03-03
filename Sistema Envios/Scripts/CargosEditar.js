$("#lblMensaje1").hide();

function Cerrar() {
    $('#FormModal').modal('hide');
}

function AbrirModal(carg_Id) {

    $.ajax({
        url: "/Cargos/Cargar",
        method: "POST",
        dataType: "json",
        contentType: "application/json; charset=utf-8",
        data: JSON.stringify({ carg_Id: carg_Id }),
        success: function (data) {
            console.log(data);
            $('#FormModal').modal('show');
            $.each(data, function (i, value) {
                $("#carg_Id").val(value.carg_Id);
                $("#txtCargo").val(value.carg_Description);
            

            })



        }

    })

}


function Editar(x) {


    var ID = $("#carg_Id").val();
    var Descripcion = $("#txtCargo").val();

    console.log(ID);
    console.log(Descripcion);
    console.log(x);
  
  

    $.ajax({
        url: "/Cargos/Editores",
        method: "POST",
        dataType: "json",
        contentType: "application/json; charset=utf-8",
        data: JSON.stringify({ ID: ID, Descripcion: Descripcion }),
        success: function (data) {


            window.location.reload();

        }

    })


    if (Descripcion == "" || null) {
        $("#lblMensaje1").show();
        $("#txtCargo").focus();
    }
    else {


        $('#FormModal').modal('hide');
        window.location.reload();
    }


}

