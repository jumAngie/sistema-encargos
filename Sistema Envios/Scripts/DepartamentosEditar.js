function Cerrar() {
    $('#FormModal').modal('hide');
}

function AbrirModal(depto_ID) {

    $.ajax({
        url: "/Departamentos/Cargar",
        method: "POST",
        dataType: "json",
        contentType: "application/json; charset=utf-8",
        data: JSON.stringify({ depto_ID: depto_ID }),
        success: function (data) {
            console.log(data);
            $('#FormModal').modal('show');
            $.each(data, function (i, value) {
                $("#txtDescripcion").val(value.depto_Descripcion);
                $("#depto_ID").val(value.depto_ID);


            })



        }

    })

}


function Editar(x) {


    var ID = $("#depto_ID").val();
    var Descripcion = $("#txtDescripcion").val();

    console.log(ID);
    console.log(Descripcion);
    console.log(x);



    $.ajax({
        url: "/Departamentos/Editores",
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

