

$(document).ready(function () {

    var fab_ID = $("#fab_ID").val();
    $.ajax({
        url: "/Articulos/CargarFabricas",
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


function Cerrar() {
    $('#FormModal').modal('hide');
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
                $("#txtArt").val(value.art_Descripcion);
                $("#fab_ID").val(value.fab_ID);
                $("#txtStock").val(value.art_Stock);
             
            })



        }

    })

}


function Editar(x) {


    var articulo = $("#txtArt").val();
    var fabrica = $("#fab_ID").val();
    var stock = $("#txtStock").val();
    var ID = $("#art_ID").val();

    //console.log(x);
    //console.log(fabrica);
/*    console.log(stock);*/
    console.log(ID);
 
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
    $('#FormModal').modal('hide');

}

