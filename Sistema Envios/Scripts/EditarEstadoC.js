$("#lblName").hide();

function Cerrar() {
    $('#FormModal').modal('hide');
    $("#lblName").hide();
    window.location.reload();
}

//function Abrir() {

//    $('#FormModal').modal('show');
//}

//$("#tbnModal").click(function () {
//    $('#FormModal').modal('show');
//});




function ObtenerId(est_ID) {

    var est_Id = est_ID;
    console.log(est_ID);
    $.ajax({
        url: "/EStadosCiviles/Cargar",
        method: "post",
        dataType: "json",
        contentType: "application/json; charset=utf-8",
        data: JSON.stringify({ est_Id: est_Id }),
        success: function (data) {
            console.log(data);
            $('#FormModal').modal('show');
            $.each(data, function (i, value) {
                $("#est_ID").val(value.est_ID);
                $("#txtEstadoCivilC").val(value.est_Descripcion);

            })



        }

    })

}


function Editar() {


    var estado = $("#txtEstadoCivilC").val();
    var ID = $("#est_ID").val();

    if (estado != "" && estado != null) {
        console.log(ID);
        console.log(estado);

        $.ajax({
            url: "/EStadosCiviles/Editores",
            method: "POST",
            dataType: "json",
            contentType: "application/json; charset=utf-8",
            data: JSON.stringify({ ID: ID, estado: estado }),
            success: function (data) {

                $("#lblName").hide();
                window.location.reload();

            }

        })
        $("#lblName").hide();
        $('#FormModal').modal('hide');
        window.location.reload();
    }
    else {

        $("#lblName").show();
        $("#txtEstadoCivilC").focus();
    }



}