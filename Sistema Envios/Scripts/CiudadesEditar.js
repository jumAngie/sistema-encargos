function Cerrar() {
    $('#FormModal').modal('hide');
}

function AbrirModal(ciu_ID) {

    $.ajax({
        url: "/Ciudades/Cargar",
        method: "POST",
        dataType: "json",
        contentType: "application/json; charset=utf-8",
        data: JSON.stringify({ ciu_ID: ciu_ID }),
        success: function (data) {
            console.log(data);
            $('#FormModal').modal('show');
            $.each(data, function (i, value) {
                $("#txtDescripcion").val(value.ciu_Descripcion);
                $("#ciu_ID").val(value.ciu_ID);


            })



        }

    })

}


function Editar(x) {


    var ID = $("#ciu_ID").val();
    var Descripcion = $("#txtDescripcion").val();

    console.log(ID);
    console.log(Descripcion);
    console.log(x);



    $.ajax({
        url: "/Ciudades/Editores",
        method: "POST",
        dataType: "json",
        contentType: "application/json; charset=utf-8",
        data: JSON.stringify({ ID: ID, Descripcion: Descripcion }),
        success: function (data) {


            window.location.reload();

        }

    })
    $('#FormModal').modal('hide');

}

