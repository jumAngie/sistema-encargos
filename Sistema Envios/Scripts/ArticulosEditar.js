
$("#Mensaje").hide();
$("#artiMess").hide();
$("#CantidadMess").hide();



$(document).ready(function () {

    var fab_ID = $("#fab_ID").val();
    $.ajax({
        url: "/Articulos/CARGARFABRICAS",
        method: "POST",
        dataType: "json",
        contentType: "application/json; charset=utf-8",
        data: JSON.stringify({ fab_ID: fab_ID }),
        success: function (data) {
            $.each(data, function (i, value) {

                $("#fab_ID").append("<option value='" + value.fab_ID + "'>" + value.fab_Descripcion + "</option>")
            })
        }
    })
})


//txtArtiC
//txtExistencia
//fab_ID
//art_ID
function Cerrar() {
    $('#FormModal').modal('hide');
    $("#Mensaje").hide();
    $("#artiMess").hide();
    $("#CantidadMess").hide();
}


function AbrirModal(art_ID) {

    $.ajax({
        url: "/Articulos/Cargar",
        method: "POST",
        dataType: "json",
        contentType: "application/json; charset=utf-8",
        data: JSON.stringify({ art_ID: art_ID }),
        success: function (data) {
            console.log(data);
            $('#FormModal').modal('show');
            $.each(data, function (i, value) {
                $("#art_ID").val(value.art_ID);
                $("#txtArtiC").val(value.art_Descripcion);
                $("#fab_ID").val(value.fab_ID);
                $("#txtExistencia").val(value.art_Stock);
             
            })



        }

    })

}


function Editar(x) {


    var articulo = $("#txtArtiC").val();
    var fabrica = $("#fab_ID").val();
    var stock = $("#txtExistencia").val();
    var ID = $("#art_ID").val();

    console.log(x);

    console.log(ID);

    if ((stock != "" || stock != null) && (articulo != "" || articulo != null)) {
        
        $.ajax({
            url: "/Articulos/Editores",
            method: "POST",
            dataType: "json",
            contentType: "application/json; charset=utf-8",
            data: JSON.stringify({ ID: ID, articulo: articulo, fabrica: fabrica, stock: stock }),
            success: function (data) {


                window.location.reload();

            }

        })
        $("#Mensaje").show();
        $('#FormModal').modal('hide');

         window.location.reload();
    }

   

    if (articulo == "" || articulo == null) {
        $("#Mensaje").hide();
        $("#artiMess").hide();
        $("#txtArtiC").focus();
        $("#CantidadMess").show();


    }
    if (stock == "" || stock == null) {
        $("#Mensaje").hide();
        $("#artiMess").hide();
        $("#CantidadMess").show();
        $("#txtExistencia").focus();


    }
 
}

