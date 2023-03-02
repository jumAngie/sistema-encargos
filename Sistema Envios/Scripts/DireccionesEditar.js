function Cerrar() {
    $('#FormModal').modal('hide');
}

$(document).ready(function () {
    var Id_Cliente = $("#Id_Cliente").val();
    $.ajax({
        url: "/Direcciones/CargarClienteEdit",
        method: "POST",
        dataType: "json",
        contentType: "application/json; charset=utf-8",
        data: JSON.stringify({ Id_Cliente: Id_Cliente }),
        success: function (data) {
            $.each(data, function (i, value) {

                $("#Id_Cliente").append("<option value='" + value.client_ID + "'>" + value.client_Nombre + "</option>")
            })
        }
    })
})


$(document).ready(function () {
    var Id_depto = $("#Id_depto").val();
    $.ajax({
        url: "/Direcciones/CargarDepartamentosEdit",
        method: "POST",
        dataType: "json",
        contentType: "application/json; charset=utf-8",
        data: JSON.stringify({ Id_depto: Id_depto }),
        success: function (data) {
            $.each(data, function (i, value) {

                $("#Id_depto").append("<option value='" + value.depto_ID + "'>" + value.depto_Descripcion + "</option>")
            })
        }
    })
})

//$(document).ready(function () {
//    var Id_depto = $("#Id_depto").val();
//    $.ajax({
//        url: "/Direcciones/CargarMunicipiosEdit",
//        method: "POST",
//        dataType: "json",
//        contentType: "application/json; charset=utf-8",
//        data: JSON.stringify({ Id_depto: Id_depto }),
//        success: function (data) {
//            $("#Id_Ciudad").empty();

//            //$("#Id_Ciudad").append("<option value= '0' > Seleccione un Municipio</option>");

//            $.each(data, function (i, value) {
//                $("#Id_Ciudad").append("<option value='" + value.ciu_ID + "'>" + value.ciu_Descripcion + "</option>")
//            })
//        }
//    })
//})




$("#dep_ID").change(function () {

    /*function Muni(dep_Id) {*/
        var dep_Id = $("#Id_depto").val();
        $.ajax({
            url: "/Direcciones/CargarMunicipiosEdit",
            method: "POST",
            dataType: "json",
            contentType: "application/json; charset=utf-8",
            data: JSON.stringify({ dep_Id: dep_Id }),
            success: function (data) {
                $("#Id_Ciudad").empty();
                //$("#Id_Ciudad").append("<option value= '0' > Seleccione un Municipio</option>");

                $.each(data, function (i, value) {
                    $("#Id_Ciudad").append("<option value='" + value.ciu_ID + "'>" + value.ciu_Descripcion + "</option>")
                })
            }
        })
   /* }*/
 })

function ObtenerId(direc_ID) {

    //var id = '';
//    var direc_ID = direc_ID;
/*    var Id = $("#Id_depto").val();*/
    $.ajax({
        url: "/Direcciones/Cargar",
        method: "POST",
        dataType: "json",
        contentType: "application/json; charset=utf-8",
        data: JSON.stringify({ direc_ID: direc_ID }),
        success: function (data) {
            console.log(data);

            $('#FormModal').modal('show');

            $.each(data, function (i, value) {
                $("#Id_Cliente").val(value.direc_ID);
                $("#txtDireccion").val(value.direc_DireccionExacta);
                $("#Id_depto").val(value.depto_ID);
                $("#direc_ID").val(value.direc_ID);

                /* cargarDep();*/
                /*   Muni(depto);*/  
                Muni($("#Id_depto").val());
             
                //Muni($("#Id_depto").val());
                $('#Id_Ciudad').val(value.ciu_ID);

                /*    $("#Id_Ciudad").append("<option value='" + value.direc_CiudadID + "'>" + value.ciu_Descripcion + "</option>")*/


            })



        }

    })





}


//function Abrir() {

//    $('#FormModal').modal('show');
//}

//$("#tbnModal").click(function () {
//    $('#FormModal').modal('show');
//});






//$(document).ready(function () {


/*})*/




/*$(document).ready(function () {*/

/*})*/




function Editar() {
 
    var ID = $("#direc_ID").val();
    var cliente = $("#Id_Cliente").val();
    var ciudad = $("#Id_Ciudad").val();
    var direccion = $("#direc_ID").val();
    console.log(ID);
    console.log(estado);

    $.ajax({
        url: "/Direcciones/Editores",
        method: "POST",
        dataType: "json",
        contentType: "application/json; charset=utf-8",
        data: JSON.stringify({ ID: ID, cliente: cliente, direccion: direccion, ciudad: ciudad }),
        success: function (data) {


            window.location.reload();

        }

    })
    $('#FormModal').modal('hide');

}
