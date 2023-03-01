function AbrirModal(usu_Id) {

    console.log(usu_Id);

    $.ajax({
        url: "/Articulos/Cargar",
        method: "POST",
        dataType: "json",
        contentType: "application/json; charset=utf-8",
        data: JSON.stringify({ usu_Id: usu_Id }),
        success: function (data) {
            console.log(data);
            $('#FormModal').modal('show');
            $.each(data, function (i, value) {
                $("#usu_Id").val(value.usu_Id);
                $("#txtNombre").val(value.usu_Nambe);
                $("#txtApellidos").val(value.usu_Apellido);
            })



        }

    })

}


function Editar(x) {

    var Nombre = $("#txtNombre").val();
    var Apellido = $("#txtApellidos").val();
    var ID = $("#usu_Id").val();

    console.log(x);
    console.log(Nombre);
    $.ajax({
        url: "/Articulos/Editores",
        method: "POST",
        dataType: "json",
        contentType: "application/json; charset=utf-8",
        data: JSON.stringify({ ID: ID, Nombre: Nombre, Apellido: Apellido }),
        success: function (data) {


            window.location.reload();

        }

    })
    $('#FormModal').modal('hide');

}

