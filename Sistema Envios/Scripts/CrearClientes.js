$("#lblAlertaCredito").hide();
$("#lblNombre").hide();
$("#lblIdentidad").hide();
$("#lblSexo").hide();
$("#lblSexo").hide();
$("#lblSaldo").hide();
$("#lblCredito").hide();
$("#lblDescuento").hide();
$("#lblTelefono").hide();
$("#lblEstadoCiv").hide();


$("drfm").prop("checked", false);

//txtNombre    lblNombre
//txtIdentidad lblIdentidad
//Id_Estado
//drf          lblSexo
//drm          lblSexo
//txtSaldo     lblSaldo
//txtCredito   lblCredito
//txtDescuento lblDescuento
//txtTelefono  lblTelefono





$(document).ready(function () {

    var Id_Estado = $("#Id_Estado").val();
    $.ajax({
        url: "/Clientes/CargarEstadosCiviles",
        method: "POST",
        dataType: "json",
        contentType: "application/json; charset=utf-8",
        data: JSON.stringify({ Id_Estado: Id_Estado }),
        success: function (data) {
            $.each(data, function (i, value) {

                $("#Id_Estado").append("<option value='" + value.est_ID + "'>" + value.est_Descripcion + "</option>")
            })
        }
    })
})


function Guardar() {

    var txtNombre = $("#txtNombre").val();
    var Id_Estado = $("#Id_Estado").val();
    var txtTelefono = $("#txtTelefono").val();
    var txtCredito = $("#txtCredito").val();
    var txtDescuento = $("#txtDescuento").val();
    var txtIdentidad = $("#txtIdentidad").val();
    var txtSaldo = $("#txtSaldo").val();
    var sexo = "";
   


    if ($('#drf').attr("checked", true))
    {
        sexo = $('#drf').val();
    }
    else if ($('#drm').attr("checked", true))
            {
                sexo = $('#drm').val();
            }

   else {

        $("#lblSexo").show();
        sexo = "";
          }

    if ($("#Id_Estado").val() == "0") {
        $("#lblEstadoCiv").show();

    }

    if (txtNombre == "") {
        /* $("#txtNombre").focus();*/
        $("#lblNombre").show();


    }
    if (txtIdentidad == "") {

        $("#lblIdentidad").show();
        /*   $("#txtIdentidad").focus();*/


    }
    if (txtTelefono == "") {

        $("#lblTelefono").show();
        /*    $("#txtTelefono").focus();*/


    }
    if (txtSaldo == "") {

        $("#lblSaldo").show();
        /*   $("#txtSaldo").focus();*/


    }
    if (txtCredito == "") {
        $("#lblCredito").show();
        $("#lblAlertaCredito").hide();
        /*   $("#txtExistencia").focus();*/


    }
    if (txtDescuento == "") {
        $("#lblDescuento").show();
        /*    $("#txtDescuento").focus();*/


    }

    if (txtCredito > 300000) {
        $("#lblAlertaCredito").show();
        $("#txtCredito").focus();
    }

    //else if ($("#drm").attr("checked", true)) { sexo = "M"; }


  

    console.log(txtNombre);
    console.log(Id_Estado);
    console.log(txtTelefono);
    console.log(txtCredito);
    console.log(txtDescuento);
    console.log(txtIdentidad);
    console.log(txtSaldo);
    console.log(sexo);

    


    if (txtNombre != "" && txtIdentidad != "" && txtTelefono != "" && txtSaldo != "" && txtCredito != "" && txtDescuento != "" && $("#Id_Estado").val() != "0" && sexo != "" && txtCredito < 300000 )
    {
        $.ajax({
            url: "/Clientes/Guardo",
            method: "POST",
            data: ({ txtNombre: txtNombre, txtIdentidad: txtIdentidad, Id_Estado: Id_Estado, sexo: sexo, txtTelefono: txtTelefono, txtSaldo: txtSaldo, txtCredito: txtCredito, txtDescuento: txtDescuento }),

            success: function (data) {


                //window.location.reload();

            }

        })

        /*  window.location.reload();*/


        window.location.reload();

        alert("Si esta entrando ??");
        $("#lblAlertaCredito").hide();
        $("#lblNombre").hide();
        $("#lblIdentidad").hide();
        $("#lblSexo").hide();
        $("#lblSexo").hide();
        $("#lblSaldo").hide();
        $("#lblCredito").hide();
        $("#lblDescuento").hide();
        $("#lblTelefono").hide();

       

    }



}




