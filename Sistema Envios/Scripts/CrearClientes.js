$("#lblAlertaCredito").hide();
$("#lblNombre").hide();
$("#lblIdentidad").hide();
$("#lblSexo").hide();
$("#lblSexo").hide();
$("#lblSaldo").hide();
$("#lblCredito").hide();
$("#lblDescuento").hide();
$("#lblTelefono").hide();

    

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


    var nombre = $("#txtNombre").val();
    var EstadoCiv = $("#Id_Estado").val();
    var telefono = $("#txtTelefono").val();
    var limite_Credit = $("#txtCredito").val();
    var descuento = $("#txtDescuento").val();
    var identidad = $("#txtIdentidad").val();
    var saldo = $("#txtSaldo").val();
    var sexo = "";
    if ($("#drf").prop('checked', true)) { sexo = "F"; }
    if ($("#drm").prop('checked', true)) { sexo = "M"; }

    console.log(nombre);
    console.log(EstadoCiv);
    console.log(telefono);
    console.log(limite_Credit);
    console.log(descuento);
    console.log(identidad);
    console.log(sexo);
    console.log(saldo);

    $.ajax({
        url: "/Clientes/Guardo",
        method: "POST",
        data: ({ nombre: nombre, identidad: identidad, EstadoCiv: EstadoCiv, sexo: sexo, telefono: telefono, saldo: saldo, limite_Credit: limite_Credit, descuento: descuento }),

        success: function (data) {


            /*   window.location.reload();*/

        }

    })

    if ($("#drf").prop('checked', false) && $("#drm").prop('checked', false)) {

        $("#lblSexo").show();

    }
    if (nombre == "" || nombre == null) {
        $("#txtNombre").focus();
        $("#lblNombre").show();


    }
    if (identidad == "" || identidad == null) {

        $("#lblIdentidad").show();
        $("#txtIdentidad").focus();


    }
    if (telefono == "" || telefono == null) {

        $("#lblTelefono").show();
        $("#txtTelefono").focus();


    }
    if (saldo == "" || saldo == null) {

        $("#lblSaldo").show();
        $("#txtSaldo").focus();


    }
    if (limite_Credit == "" || limite_Credit == null) {
        $("#lblCredito").show();
        $("#txtExistencia").focus();


    }
    if (descuento == "" || descuento == null) {
        $("#lblDescuento").show();
        $("#txtDescuento").focus();


    }
    if (parseInt(limite_Credit) > 3000000) {
        $("#lblAlertaCredito").show();
        $("#txtCredito").focus();
    }
    if ((nombre != "" || nombre != null) && (identidad != "" || identidad != null) && (telefono != "" || telefono != null) && (saldo != "" || saldo != null) && (limite_Credit != "" || limite_Credit != null) && (descuento != "" || descuento != null)) {
       
        $("#lblAlertaCredito").hide();
        $("#lblNombre").hide();
        $("#lblIdentidad").hide();
        $("#lblSexo").hide();
        $("#lblSexo").hide();
        $("#lblSaldo").hide();
        $("#lblCredito").hide();
        $("#lblDescuento").hide();
        $("#lblTelefono").hide();

        window.location.reload();

        alert("Se guardo correctamente");

        
    }



}



//function Insertar() {
//    var id = $("#txtDeptos").val()
//    $.ajax({
//        url: "/Departamentos/Create",
//        method: "POST",
//        data: { txtDeptos: id },
//        success: function (data) {
//            window.location.reload();
//        }
//    })
//}



