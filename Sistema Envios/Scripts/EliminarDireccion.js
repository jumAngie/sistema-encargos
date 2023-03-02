﻿function Borrar() {
    var id = $(this).data('id');
    $.ajax({
        url: "/Direcciones/Delete",
        method: "POST",
        data: { id: id },
        success: function (data) {
            window.location.reload();
        }
    })
}

$(function () {
    $('.btn-delete').click(function () {
        var id = $(this).data('id');
        $('#btn-confirm-delete').attr('href', '/Direcciones/Delete/' + id);
        $('#confirm-delete-modal').modal('show');
    });
    $('#btn-close-modal').click(function () {
        $('#confirm-delete-modal').modal('hide');
    });
});