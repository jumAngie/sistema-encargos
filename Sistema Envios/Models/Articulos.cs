using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.ComponentModel.DataAnnotations;

namespace Sistema_Envios.Models
{
    public partial class tbArticulos
    {
    }

    [MetadataType(typeof(tbArticulosMetaData))]
    public class tbArticulosMetaData
    {
        [Display(Name = "Artículo ID")]
        public int art_ID { get; set; }


        [Display(Name = "Nombre del Artículo")]
        [Required(ErrorMessage = "Este campo {0} es requerido.")]
        public string art_Descripcion { get; set; }


        [Display(Name = "Fábrica del Artículo")]
        [Required(ErrorMessage = "Este campo {0} es requerido.")]
        public int fab_ID { get; set; }

        [Display(Name = "Stock")]
        [Required(ErrorMessage = "Este campo {0} es requerido.")]
        public int art_Stock { get; set; }
    }
}