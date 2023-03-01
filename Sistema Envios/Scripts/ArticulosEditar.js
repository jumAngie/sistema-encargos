

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


function AbrirModal(art_Id) {

    $.ajax({
        url: "/Articulos/Cargar",
        method: "POST",
        dataType: "json",
        contentType: "application/json; charset=utf-8",
        data: JSON.stringify({ art_Id: art_Id }),
        success: function (data) {
            console.log(data);
            $('#FormModal').modal('show');
            $.each(data, function (i, value) {
                $("#txtArt").val(value.art_Descripcion);
                $("#fab_ID").val(value.art_ID);
                $("#txtStock").val(value.art_Stock);
            })



        }

    })

}


function Editar(x) {


    var articulo = $("#txtArt").val()
    var fabrica =  $("#fab_ID").val()
    var stock =    $("#txtStock").val()

    console.log(x);
    console.log(Nombre);
    $.ajax({
        url: "/Articulos/Editores",
        method: "POST",
        dataType: "json",
        contentType: "application/json; charset=utf-8",
        data: JSON.stringify({ fabrica: fabrica, articulo: articulo, stock: stock }),
        success: function (data) {


            window.location.reload();

        }

    })
    $('#FormModal').modal('hide');

}

