


function Cerrar() {
    $('#FormModal').modal('hide');
}

function Abrir() {

    $('#FormModal').modal('show');
}




//function AbrirModal(est_ID) {
//    $('#FormModal').modal('show');
//   //var est_ID = $("#est_ID").val()
//    $.ajax({
//        url: "/EStadosCiviles/Cargar",
//        method: "GET",
//        dataType: "json",
//        contentType: "application/json; charset=utf-8",
//        data: JSON.stringify({ est_ID: est_ID }),
//        success: function (data) {
//            console.log(data);
           
//            $.each(data, function (i, value) {
//                $("#est_ID").val(value.est_ID);
//                $("#txtEstadoCivil").val(value.est_Descripcion);

//            })



//        }

//    })

//}


//function Editar(x) {


//    var estado = $("#txtEstadoCivil").val(); 
//    var ID = $("#est_ID").val();

//    console.log(ID);

//    $.ajax({
//        url: "/EStadosCiviles/Editores",
//        method: "POST",
//        dataType: "json",
//        contentType: "application/json; charset=utf-8",
//        data: JSON.stringify({ ID: ID, estado: estado }),
//        success: function (data) {


//            window.location.reload();

//        }

//    })
//    $('#FormModal').modal('hide');

//}
