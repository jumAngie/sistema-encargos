using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace Sistema_Envios.Models
{
    [MetadataType(typeof(tbDepartamentosMetaData))]
    public partial class tbDepartamentos
    {
    }

    public class tbDepartamentosMetaData
    {

        [Display(Name = "Departamento ID")]
        public int depto_ID { get; set; }

        [Display(Name = "Nombre del Departamento")]
        [Required(ErrorMessage = "Este campo {0} es requerido.")]
        public string depto_Descripcion { get; set; }
    }
}