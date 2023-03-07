using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace Sistema_Envios.Models
{
    [MetadataType(typeof(tbPedidosMetaData))]
    public partial class tbPedidos
    {
    }

    public class tbPedidosMetaData
    {
        [Display(Name = "Pedido ID")]
        public int pedi_ID { get; set; }

        [Display(Name = "Código del Pedido")]
        [Required(ErrorMessage = "Este campo {0} es requerido.")]
        public string pedi_Code { get; set; }

        [Display(Name = "Dirección a Entregar")]
        [Required(ErrorMessage = "Este campo {0} es requerido.")]
        public int pedi_DireccionID { get; set; }

        [Display(Name = "Costo del Envío")]
        [Required(ErrorMessage = "Este campo {0} es requerido.")]
        public decimal pedi_CostoEnvio { get; set; }

        [Display(Name = "Estado del Envío")]
        [Required(ErrorMessage = "Este campo {0} es requerido.")]
        public int estv_Id { get; set; }

        [Display(Name = "Empleado encargado")]
        [Required(ErrorMessage = "Este campo {0} es requerido.")]
        public int emp_Id { get; set; }
        public System.DateTime pedi_Fecha { get; set; }
    }
}