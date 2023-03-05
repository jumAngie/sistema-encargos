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

$("#drf").prop("checked", false);
$("#drf").prop("checked", false);

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

var txtNombre = $("#txtNombre").val();
var Id_Estado = $("#Id_Estado").val();
var txtTelefono = $("#txtTelefono").val();
var txtCredito = $("#txtCredito").val();
var txtDescuento = $("#txtDescuento").val();
var txtIdentidad = $("#txtIdentidad").val();
var txtSaldo = $("#txtSaldo").val();
var sexo = "";


function Guardar() {


  
    if ($("#drf").prop("checked", true)) { sexo = "F"; }
    if ($("#drm").prop("checked", true)) { sexo = "M"; }
     if ($("#drf").prop("checked", false) && $("#drm").prop("checked", false)) {
        sexo = "";
        $("#lblSexo").show();

    }


        if (Id_Estado == "0") {
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
            /*   $("#txtExistencia").focus();*/


        }
        if (txtDescuento == "") {
            $("#lblDescuento").show();
            /*    $("#txtDescuento").focus();*/


        }

        if (txtCredito > 3000000) {
            $("#lblAlertaCredito").show();
            $("#txtCredito").focus();
        }
    

    if (txtNombre != "" && txtIdentidad != "" && txtTelefono != "" && txtSaldo != "" && txtCredito != "" && txtDescuento != "" && Id_Estado != "0" && sexo != "" )
    {


        $.ajax({
            url: "/Clientes/Guardo",
            method: "POST",
            data: ({ txtNombre: txtNombre, txtIdentidad: txtIdentidad, Id_Estado: Id_Estado, sexo: sexo, txtTelefono: txtTelefono, txtSaldo: txtSaldo, txtCredito: txtCredito, txtDescuento: txtDescuento }),

            success: function (data) {


                   window.location.reload();

            }

        })
      /*  window.location.reload();*/

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

        console.log(txtNombre);
        console.log(Id_Estado);
        console.log(txtTelefono);
        console.log(txtCredito);
        console.log(txtDescuento);
        console.log(txtIdentidad);
        console.log(txtSaldo);
    }



}




