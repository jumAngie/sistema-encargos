using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace Sistema_Envios.Models
{
    [MetadataType(typeof(tbCiudadesMetaData))]
    public partial class tbCiudades
    {
    }

    public class tbCiudadesMetaData
    {
        [Display(Name = "Ciudad ID")]
        public int ciu_ID { get; set; }


        [Display(Name = "Nombre de la Ciudad")]
        [Required(ErrorMessage = "Este campo {0} es requerido.")]
        public string ciu_Descripcion { get; set; }

        [Display(Name = "Departamento de la Ciudad")]
        [Required(ErrorMessage = "Este campo {0} es requerido.")]
        public int ciu_DeptoID { get; set; }
    }
}