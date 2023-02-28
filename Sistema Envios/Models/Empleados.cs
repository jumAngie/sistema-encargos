using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace Sistema_Envios.Models
{
    [MetadataType(typeof(tbEmpleadosMetaData))]
    public partial class tbEmpleados
    {
    }

    public class tbEmpleadosMetaData
    {

        [Display(Name = "Empleado ID")]
        public int emp_Id { get; set; }

        [Display(Name = "Nombres")]
        [Required(ErrorMessage = "Este campo {0} es requerido.")]
        public string emp_Name { get; set; }

        [Display(Name = "Apellidos")]
        [Required(ErrorMessage = "Este campo {0} es requerido.")]
        public string emp_Apellido { get; set; }

        [Display(Name = "DNI")]
        [Required(ErrorMessage = "Este campo {0} es requerido.")]
        public string emp_DNI { get; set; }

        [Display(Name = "Fecha de Nacimiento")]
        [Required(ErrorMessage = "Este campo {0} es requerido.")]
        public Nullable<System.DateTime> emp_FechaNac { get; set; }

        [Display(Name = "Ciudad")]
        [Required(ErrorMessage = "Este campo {0} es requerido.")]
        public int ciu_ID { get; set; }

        [Display(Name = "Estado Civil")]
        [Required(ErrorMessage = "Este campo {0} es requerido.")]
        public string est_ID { get; set; }

        [Display(Name = "Sexo")]
        [Required(ErrorMessage = "Este campo {0} es requerido.")]
        public string emp_Sexo { get; set; }

        [Display(Name = "Cargo")]
        [Required(ErrorMessage = "Este campo {0} es requerido.")]
        public int carg_Id { get; set; }
    }
}