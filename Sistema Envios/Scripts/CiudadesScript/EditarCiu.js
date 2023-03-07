
$("#Mensaje").hide();

function Cerrar() {
    $('#FormModal').modal('hide');
    $("#Mensaje").hide();
}




$(document).ready(function () {

    var Departamento = $("#Departamento").val();
    $.ajax({
        url: "/Ciudades/CargarDeptosEdit",
        method: "POST",
        dataType: "json",
        contentType: "application/json; charset=utf-8",
        data: JSON.stringify({ Departamento: Departamento }),
        success: function (data) {
            $.each(data, function (i, value) {

                $("#Departamento").append("<option value='" + value.depto_ID + "'>" + value.depto_Descripcion + "</option>")
            })
        }
    })
})


function AbrirModal(ciu_ID) {
    $("#Mensaje").hide();
    $.ajax({
        url: "/Ciudades/Cargar",
        method: "POST",
        dataType: "json",
        contentType: "application/json; charset=utf-8",
        data: JSON.stringify({ ciu_ID: ciu_ID }),
        success: function (data) {
            console.log(data);
            $('#FormModal').modal('show');
            $.each(data, function (i, value) {
                $("#txtDescripcion").val(value.ciu_Descripcion);
                $("#ciu_ID").val(value.ciu_ID);
                $("#Departamento").val(value.depto_ID);
                $("#DeptoAct").val(value.depto_Descripcion);

            })



        }

    })

}


function Editar(x) {


    var ID = $("#ciu_ID").val();
    var Descripcion = $("#txtDescripcion").val();
    var Departamento = $("#Departamento").val();


  
        $.ajax({
            url: "/Ciudades/Editores",
            method: "POST",
            dataType: "json",
            contentType: "application/json; charset=utf-8",
            data: JSON.stringify({ ID: ID, Descripcion: Descripcion, Departamento: Departamento }),
            success: function (data) {

                $("#Mensaje").hide();
                window.location.reload();

            }

        })
    

        if (Descripcion == "" || Descripcion == null) {
            $("#Mensaje").show();
            $("#txtDescripcion").focus();
        }
        else {

            $("#Mensaje").hide();
            $('#FormModal').modal('hide');
            window.location.reload();

        }

    }