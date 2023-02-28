using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace Sistema_Envios.Models
{
    [MetadataType(typeof(tbUsuariosMetaData))]
    public partial class tbUsuarios
    {
    }

    public class tbUsuariosMetaData
    {
        [Display(Name = "Usuario ID")]
        public int usu_ID { get; set; }

        [Display(Name = "Usuario")]
        [Required(ErrorMessage = "Este campo {0} es requerido.")]
        public string usu_Usuario { get; set; }

        [Display(Name = "Empleado")]
        [Required(ErrorMessage = "Este campo {0} es requerido.")]
        public Nullable<int> emp_Id { get; set; }

        [Display(Name = "Rol")]
        [Required(ErrorMessage = "Este campo {0} es requerido.")]
        public Nullable<int> rol_ID { get; set; }
    }
}