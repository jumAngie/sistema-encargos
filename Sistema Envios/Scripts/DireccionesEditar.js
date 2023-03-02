function Cerrar() {
    $('#FormModal').modal('hide');
}

//function Abrir() {

//    $('#FormModal').modal('show');
//}

$("#tbnModal").click(function () {
    $('#FormModal').modal('show');
});



$(document).ready(function () {
    var client_ID = $("#client_ID").val();
    $.ajax({
        url: "/Direcciones/CargarCliente",
        method: "POST",
        dataType: "json",
        contentType: "application/json; charset=utf-8",
        data: JSON.stringify({ client_ID: client_ID }),
        success: function (data) {
            $.each(data, function (i, value) {

                $("#client_ID").append("<option value='" + value.client_ID + "'>" + value.client_Nombre + "</option>")
            })
        }
    })
})




$(document).ready(function () {
    var dep_ID = $("#dep_ID").val();
    $.ajax({
        url: "/Direcciones/CargarDepartamentos",
        method: "POST",
        dataType: "json",
        contentType: "application/json; charset=utf-8",
        data: JSON.stringify({ dep_ID: dep_ID }),
        success: function (data) {
            $.each(data, function (i, value) {

                $("#dep_ID").append("<option value='" + value.depto_ID + "'>" + value.depto_Descripcion + "</option>")
            })
        }
    })
})

$("#Id_depto").change(function () {

    var Id_depto = $("#Id_depto").val();
    $.ajax({
        url: "/Direcciones/CargarMunicipios '"+"",
        method: "GET",
        dataType: "json",
        contentType: "application/json; charset=utf-8",
        data: JSON.stringify({ Id_depto: Id_depto }),
        success: function (data) {
            //$("#Id_Ciudad").empty();
            //$("#Id_Ciudad").append("<option value= '0' > Seleccione un Municipio</option>");

            $.each(data, function (i, value) {
                $("#Id_Ciudad").append("<option value='" + value.ciu_ID + "'>" + value.ciu_Descripcion + "</option>")
            })
        }
    })
})





Id_Cliente
txtDireccion
Id_depto
Id_Ciudad
direc_ID

[direc_ID], [direc_ClienteID], [direc_DireccionExacta], [direc_CiudadID], [depto_ID]
function ObtenerId(direc_ID) {

    var direc_ID = direc_ID;
    console.log(direc_ID);
    $.ajax({
        url: "/Direcciones/Cargar",
        method: "post",
        dataType: "json",
        contentType: "application/json; charset=utf-8",
        data: JSON.stringify({ direc_ID: direc_ID }),
        success: function (data) {
            console.log(data);
            /* $('#FormModal').modal('show');*/
            $.each(data, function (i, value) {
                $("#Id_Cliente").val(value.direc_ID);
                $("#txtDireccion").val(value.direc_DireccionExacta);
                $("#Id_depto").val(value.depto_ID);
                $("#Id_Ciudad").val(value.direc_CiudadID);
                $("#direc_ID").val(value.direc_ID);

            })



        }

    })

}


function Editar() {


    var estado = $("#txtEstadoCivil").val();
    var ID = $("#est_ID").val();

    console.log(ID);
    console.log(estado);

    $.ajax({
        url: "/EStadosCiviles/Editores",
        method: "POST",
        dataType: "json",
        contentType: "application/json; charset=utf-8",
        data: JSON.stringify({ ID: ID, estado: estado }),
        success: function (data) {


            window.location.reload();

        }

    })
    $('#FormModal').modal('hide');

}
