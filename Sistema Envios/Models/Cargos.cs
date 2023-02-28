using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace Sistema_Envios.Models
{
    [MetadataType(typeof(tbCargosMetaData))]
    public partial class tbCargos
    {
    }

    public class tbCargosMetaData
    {
        [Display(Name = "Cargo ID")]
        public int carg_Id { get; set; }

        [Display(Name = "Nombre del Cargo")]
        [Required(ErrorMessage = "Este campo {0} es requerido.")]
        public string carg_Description { get; set; }
    }
}