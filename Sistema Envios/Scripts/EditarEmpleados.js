

console.log($("#ciu_Id").val());

$(document).ready(function () {
    var ciu_Id = $("#ciu_Id").val();
    $.ajax({
        url: "/Empleados/CargarCiudadDescripcion",
        method: "POST",
        dataType: "json",
        contentType: "application/json; charset=utf-8",
        data: JSON.stringify({ ciu_Id: ciu_Id }),
        success: function (data) {
            $.each(data, function (i, value) {

                $("#Ciudad").append("<option value='" + value.ciu_ID + "'>" + value.ciu_Descripcion + "</option>")
            })
        }
    })

})




//$(document).ready(function () {
//    var carg_Id = $("#cargo").val();
//    $.ajax({
//        url: "/Empleados/CargarCargosEdit",
//        method: "POST",
//        dataType: "json",
//        contentType: "application/json; charset=utf-8",
//        data: JSON.stringify({ carg_Id: carg_Id }),
//        success: function (data) {
//            $.each(data, function (i, value) {

//                $("#carg_Id").append("<option value='" + value.carg_Id + "'>" + value.carg_Description + "</option>")
//            })
//        }
//    })

//})



//$(document).ready(function () {
//    var ciudad_Act = $("#ciudad_Act").val();
//    $.ajax({
//        url: "/Empleados/CargarMUNIedit",
//        method: "POST",
//        dataType: "json",
//        contentType: "application/json; charset=utf-8",
//        data: JSON.stringify({ ciudad_Act: ciudad_Act }),
//        success: function (data) {
//            $.each(data, function (i, value) {

//                $("#ciudad_Act").append("<option value='" + value.ciu_ID + "'>" + value.ciu_Descripcion + "</option>")
//            })
//        }
//    })
//})

//var ciudad = $("#ciudad_II").val();

//$("#ciudad_Act").val(ciudad);

//console.log(ciudad);



//$(document).ready(function () {

//    var cargo_Des = $("#cargo_Des").val();
//    $.ajax({
//        url: "/Empleados/CargarCargosEdit",
//        method: "POST",
//        dataType: "json",
//        contentType: "application/json; charset=utf-8",
//        data: JSON.stringify({ cargo_Des: cargo_Des }),
//        success: function (data) {
//            $.each(data, function (i, value) {

//                $("#cargo_Des").append("<option value='" + value.carg_Id + "'>" + value.carg_Description + "</option>")
//            })
          
//        }
//    })

//})

////$("#cargo_Des").val() = $("#cargo_Id").val();

//$(document).ready(function () {
//    var depa = $("#depa").val();
//    $.ajax({
//        url: "/Empleados/cargarDeptosEdit",
//        method: "POST",
//        dataType: "json",
//        contentType: "application/json; charset=utf-8",
//        data: JSON.stringify({ depa: depa }),
//        success: function (data) {
//            $.each(data, function (i, value) {

//                $("#depa").append("<option value='" + value.depa + "'>" + value.depto_Descripcion + "</option>")
//            })
//        }
//    })
//})

//$("#depa").change(function () {

//    var depa = $("#depa").val();
//    $.ajax({
//        url: "/Empleados/CargarMunicipiosEdit",
//        method: "POST",
//        dataType: "json",
//        contentType: "application/json; charset=utf-8",
//        data: JSON.stringify({ depa: depa }),
//        success: function (data) {
//            $("#ciudad").empty();

//            $.each(data, function (i, value) {
//                $("#ciudad").append("<option value='" + value.ciu_ID + "'>" + value.ciu_Descripcion + "</option>")
//            })
//        }
//    })
//})











//$(document).ready(function () {

//    var Id_Estado = $("#Id_Estado").val();
//    $.ajax({
//        url: "/Empleados/CargarEstadosCivilesEdit",
//        method: "POST",
//        dataType: "json",
//        contentType: "application/json; charset=utf-8",
//        data: JSON.stringify({ Id_Estado: Id_Estado }),
//        success: function (data) {
//            $.each(data, function (i, value) {

//                $("#Id_Estado").append("<option value='" + value.est_ID + "'>" + value.est_Descripcion + "</option>")
//            })
//        }
//    })
//})



//function cargar(emp_Id) {

//    $.ajax({
//        url: "/Empleados/Cargar",
//        method: "POST",
//        dataType: "json",
//        contentType: "application/json; charset=utf-8",
//        data: JSON.stringify({ art_ID: art_ID }),
//        success: function (data) {
//            console.log(data);
//         /*   $('#FormModal').modal('show');*/
//            $.each(data, function (i, value) {
//                $("#emp_Name").val(value.emp_Name);
//                //$("#txtArtiC").val(value.art_Descripcion);
//                //$("#fab_ID").val(value.fab_ID);
//                //$("#txtExistencia").val(value.art_Stock);

//            })



//        }

//    })

//}


//function Editar(x) {
 
//    var articulo = $("#txtArtiC").val();
//    var fabrica = $("#fab_ID").val();
//    var stock = $("#txtExistencia").val();
//    var ID = $("#art_ID").val();

//    console.log(x);

//    console.log(ID);

//    if ((stock != "" || stock != null) && (articulo != "" || articulo != null)) {

//        $.ajax({
//            url: "/Articulos/Editores",
//            method: "POST",
//            dataType: "json",
//            contentType: "application/json; charset=utf-8",
//            data: JSON.stringify({ ID: ID, articulo: articulo, fabrica: fabrica, stock: stock }),
//            success: function (data) {


//                window.location.reload();

//            }

//        })
//        $("#Mensaje").show();
//        $('#FormModal').modal('hide');

//        window.location.reload();
//    }



//    if (articulo == "" || articulo == null) {
//        $("#Mensaje").hide();
//        $("#artiMess").hide();
//        $("#txtArtiC").focus();
//        $("#CantidadMess").show();


//    }
//    if (stock == "" || stock == null) {
//        $("#Mensaje").hide();
//        $("#artiMess").hide();
//        $("#CantidadMess").show();
//        $("#txtExistencia").focus();


//    }

//}
