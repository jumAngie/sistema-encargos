using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.ComponentModel.DataAnnotations;

namespace Sistema_Envios.Models
{
    [MetadataType(typeof(tbFabricasMetaData))]
    public partial class tbFabricas
    {
    }

    public class tbFabricasMetaData
    {
        [Display(Name = "Fábrica ID")]
        public int fab_ID { get; set; }

        [Display(Name = "Nombr de la Fábrica")]
        [Required(ErrorMessage = "Este campo {0} es requerido.")]
        public string fab_Descripcion { get; set; }

        [Display(Name = "Teléfono")]
        [Required(ErrorMessage = "Este campo {0} es requerido.")]
        public string fab_Telefono { get; set; }
    }

}