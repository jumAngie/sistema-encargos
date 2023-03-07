
$("#lblCodigo").hide();
$("#lblCosto").hide();
$("#lblFecha").hide();
$("#lblEncargado").hide();
$("#lblCliente").hide();
$("#lblEstado").hide();
$("#lblDireccion").hide();



//txtCodigo
//txtCosto
//txtFecha
//encargado
//cliente
//estado
//direccion

$(document).ready(function () {
 /*   var pedi_DireccionID = $("#pedi_DireccionID").val();*/
    var estado = $("#estado").val();
    var encargado = $("#encargado").val();
  


    $.ajax({
        url: "/Pedidos/CargarEstadoEnvio",
        method: "POST",
        dataType: "json",
        contentType: "application/json; charset=utf-8",
        data: JSON.stringify({ estado: estado }),
        success: function (data) {
            $.each(data, function (i, value) {

                $("#estado").append("<option value='" + value.estv_Id + "'>" + value.estv_Description + "</option>")
            })
        }
    })


    $.ajax({
        url: "/Pedidos/CargarEmpleados",
        method: "POST",
        dataType: "json",
        contentType: "application/json; charset=utf-8",
        data: JSON.stringify({ encargado: encargado }),
        success: function (data) {
            $.each(data, function (i, value) {

                $("#encargado").append("<option value='" + value.emp_Id + "'>" + value.emp_Nombre + "</option>")
            })
        }
    })
})



$(document).ready(function () {
    var cliente = $("#cliente").val();
    $.ajax({
        url: "/Pedidos/CargarClientesCrear",
        method: "POST",
        dataType: "json",
        contentType: "application/json; charset=utf-8",
        data: JSON.stringify({ cliente: cliente }),
        success: function (data) {
            $.each(data, function (i, value) {

                $("#cliente").append("<option value='" + value.client_ID + "'>" + value.client_Nombre + "</option>")
            })
        }
    })


})


$("#cliente").change(function () {

    var cliente = $("#cliente").val();
    $.ajax({
        url: "/Pedidos/cargarDireccionDeClienteCrear",
        method: "POST",
        dataType: "json",
        contentType: "application/json; charset=utf-8",
        data: JSON.stringify({ cliente: cliente }),
        success: function (data) {
            $("#direccion").empty();

            $.each(data, function (i, value) {
                $("#direccion").append("<option value='" + value.direc_ID + "'>" + value.direc_DireccionExacta + "</option>")
            })
        }
    })
})


function Guardar() {

    var txtCodigo = $("#txtCodigo").val();
    var txtCosto = $("#txtCosto").val();
    var txtFecha = $("#txtFecha").val();
    var encargado = $("#encargado").val();
    var cliente = $("#cliente").val();
    var estado = $("#estado").val();
    var direccion = $("#direccion").val();
   


    if ($("#estado").val() == "0") {
        $("#lblEstado").show();

    }

    if (txtCodigo == "") {
        $("#lblCodigo").show();


    }
    if (txtCosto == "") {

        $("#lblCosto").show();
       


    }
    if (txtFecha == "") {

        $("#lblFecha").show();
       


    }
    if ($("#encargado").val() == "0") {

        $("#lblEncargado").show();
       


    }
    if  ($("#cliente").val() == "0") {
        $("#lblCliente").show();
      
    }
    if ($("#direccion").val() == "0") {
        $("#lblDireccion").show();
   
    }
    console.log(txtCodigo);
    console.log(txtCosto);
    console.log(txtFecha);
    console.log(encargado);
    console.log(cliente);
    console.log(estado);
    console.log(direccion);

    if (txtCodigo != "" && txtCosto != "" && txtFecha != "" && $("#encargado").val() != "0" && $("#cliente").val() != "0" && $("#estado").val() != "0" && $("#direccion").val() != "0")
    {
        $.ajax({
            url: "/Pedidos/Guardar",
            method: "POST",
            data: ({ txtCodigo: txtCodigo, txtCosto: txtCosto, txtFecha: txtFecha, encargado: encargado, estado: estado, direccion: direccion }),

            success: function (data) {


                //window.location.reload();

            }

        })

        /*  window.location.reload();*/


        window.location.reload();

        $("#lblCodigo").hide();
        $("#lblCosto").hide();
        $("#lblFecha").hide();
        $("#lblEncargado").hide();
        $("#lblCliente").hide();
        $("#lblEstado").hide();
        $("#lblDireccion").hide();

    }
}



