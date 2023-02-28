using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace Sistema_Envios.Models
{
    [MetadataType(typeof(tbDireccionesMetaData))]
    public partial class tbDirecciones
    {
    }

    public class tbDireccionesMetaData
    {
        [Display(Name = "Dirección ID")]
        public int direc_ID { get; set; }

        [Display(Name = "Cliente")]
        [Required(ErrorMessage = "Este campo {0} es requerido.")]
        public int direc_ClienteID { get; set; }

        [Display(Name = "Dirección Exacta")]
        [Required(ErrorMessage = "Este campo {0} es requerido.")]
        public string direc_DireccionExacta { get; set; }

        [Display(Name = "Ciudad")]
        [Required(ErrorMessage = "Este campo {0} es requerido.")]
        public int direc_CiudadID { get; set; }

    }
}