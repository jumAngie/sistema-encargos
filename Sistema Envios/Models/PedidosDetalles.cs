using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace Sistema_Envios.Models
{
    [MetadataType(typeof(tbPedidoDetallesMetaData))]
    public partial class tbPedidoDetalles
    {
    }

    public class tbPedidoDetallesMetaData
    {
        [Display(Name = "Detalles ID")]
        public int det_Id { get; set; }

        [Display(Name = "ID del Pedido")]
        [Required(ErrorMessage = "Este campo {0} es requerido.")]
        public int pedi_ID { get; set; }

        [Display(Name = "ID del Artículo")]
        [Required(ErrorMessage = "Este campo {0} es requerido.")]
        public int art_ID { get; set; }

        [Display(Name = "Cantidad")]
        [Required(ErrorMessage = "Este campo {0} es requerido.")]
        public int det_Cantidad { get; set; }
    }
}