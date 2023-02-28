using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.ComponentModel.DataAnnotations;

namespace Sistema_Envios.Models
{
    [MetadataType(typeof(tbEstadosCivilesMetaData))]
    public partial class tbEstadosCiviles
    {
    }

    public class tbEstadosCivilesMetaData
    {
        [Display(Name = "Estado Civil ID")]
        public string est_ID { get; set; }

        [Display(Name = "Nombre del Estado Civil")]
        [Required(ErrorMessage = "Este campo {0} es requerido.")]
        public string est_Descripcion { get; set; }
    }
}