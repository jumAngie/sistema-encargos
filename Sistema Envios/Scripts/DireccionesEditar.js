$("#mensaje1").hide();


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

$(document).ready(function () {
    var ciu_Id = $("#ciu_Id").val();
    $.ajax({
        url: "/Direcciones/CargarMunicipiosEdit",
        method: "POST",
        dataType: "json",
        contentType: "application/json; charset=utf-8",
        data: JSON.stringify({ ciu_Id: ciu_Id }),
        success: function (data) {
            $.each(data, function (i, value) {

                $("#ciu_Id").append("<option value='" + value.ciu_ID + "'>" + value.ciu_Descripcion + "</option>")
            })
        }
    })
})


//$("#Id_depto").change(function () {

//    var Id_depto = $("#Id_depto").val();
//    $.ajax({
//        url: "/Direcciones/CargarMunicipiosDEPA",
//        method: "POST",
//        dataType: "json",
//        contentType: "application/json; charset=utf-8",
//        data: JSON.stringify({ Id_depto: Id_depto }),
//        success: function (data) {

//            $("#ciu_Id").empty();
//          /*  $("#Id_Ciudad").append("<option value= '0' > Seleccione un Municipio</option>");*/

//            $.each(data, function (i, value) {
//                $("#ciu_Id").append("<option value='" + value.ciu_ID + "'>" + value.ciu_Descripcion + "</option>")
//            })
//        }
//    })
//})



//function CargandoMunis(depa) {
//    /* var Id_depto = $("#Id_depto").val();*/
  
//    $.ajax({
//        url: "/Direcciones/CargarMunicipiosDEPA",
//        method: "POST",
//        dataType: "json",
//        contentType: "application/json; charset=utf-8",
//        data: JSON.stringify({ depa: depa }),
//        success: function (data) {
//            $("#ciu_Id").empty();
//            //$("#Id_Ciudad").append("<option value= '0' > Seleccione un Municipio</option>");

//            $.each(data, function (i, value) {
//                $("#ciu_Id").append("<option value='" + value.ciudad + "'>" + value.ciu_Descripcion + "</option>")
//            })
//        }
//    })

//}




function ObtenerId(direc_ID) {

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
                $("#Id_Cliente").val(value.direc_ClienteID);
                $("#txtDireccion").val(value.direc_DireccionExacta);
                $("#Id_depto").val(value.depto_ID);
                $("#direc_ID").val(value.direc_ID);
                $("#txtCiudad").val(value.ciu_Descripcion);

              
                $("#ciu_Id").val(value.ciu_ID);            
            

             

            })
        
        

        }

    })


}

function Editar(x) {
 
    var ID =      $("#direc_ID").val();
    var cliente = $("#Id_Cliente").val();
    var ciudad =   $("#ciu_Id").val();
    var direccion = $("#txtDireccion").val();
    console.log(ID);
   
    console.log(x);
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

    if (direccion == "" || null) {
        $("#mensaje1").show();
        $("#txtDireccion").focus();
    }
    else {


        $('#FormModal').modal('hide');
        window.location.reload();
    }
}
