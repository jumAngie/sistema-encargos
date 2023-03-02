using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace Sistema_Envios.Models
{
  
    [MetadataType(typeof(tbClientesMetaData))]
    public partial class tbClientes
    {
    }

   
    public class tbClientesMetaData
    {
        [Display(Name = "Cliente ID")]
        public int client_ID { get; set; }


        [Display(Name = "Nombre del Cliente")]
        [Required(ErrorMessage = "Este campo {0} es requerido.")]
        public string client_Nombre { get; set; }


        [Display(Name = "Identidad del Cliente")]
        [Required(ErrorMessage = "Este campo {0} es requerido.")]
        public string client_Identidad { get; set; }

        [Display(Name = "Estado Civil del Cliente")]
        [Required(ErrorMessage = "Este campo {0} es requerido.")]
        public string client_EstadoCivil { get; set; }

        [Display(Name = "Sexo del Cliente")]
        [Required(ErrorMessage = "Este campo {0} es requerido.")]
        public string client_Sexo { get; set; }

        [Display(Name = "Telefono del Cliente")]
        [Required(ErrorMessage = "Este campo {0} es requerido.")]
        public string client_Telefono { get; set; }

        [Display(Name = "Saldo del Cliente")]
        [Required(ErrorMessage = "Este campo {0} es requerido.")]
        public string client_Saldo { get; set; }

        [Display(Name = "Limite de Crédito del Cliente")]
        [Required(ErrorMessage = "Este campo {0} es requerido.")]
        public decimal client_LimiteCredito { get; set; }

        [Display(Name = "Descuento del Cliente")]
        [Required(ErrorMessage = "Este campo {0} es requerido.")]
        public string client_Descuento { get; set; }
    }
}