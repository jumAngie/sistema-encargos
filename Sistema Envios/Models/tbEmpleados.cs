//------------------------------------------------------------------------------
// <auto-generated>
//     Este código se generó a partir de una plantilla.
//
//     Los cambios manuales en este archivo pueden causar un comportamiento inesperado de la aplicación.
//     Los cambios manuales en este archivo se sobrescribirán si se regenera el código.
// </auto-generated>
//------------------------------------------------------------------------------

namespace Sistema_Envios.Models
{
    using System;
    using System.Collections.Generic;
    
    public partial class tbEmpleados
    {
        public int emp_Id { get; set; }
        public string emp_Name { get; set; }
        public string emp_Apellido { get; set; }
        public string emp_DNI { get; set; }
        public Nullable<System.DateTime> emp_FechaNac { get; set; }
        public int ciu_ID { get; set; }
        public string est_ID { get; set; }
        public string emp_Sexo { get; set; }
        public int carg_Id { get; set; }
        public int emp_UsuarioCrea { get; set; }
        public System.DateTime emp_FechaCrea { get; set; }
        public Nullable<int> emp_UsuModif { get; set; }
        public Nullable<System.DateTime> emp_FechaModif { get; set; }
        public Nullable<bool> emp_Estado { get; set; }
    
        public virtual tbCiudades tbCiudades { get; set; }
        public virtual tbEstadosCiviles tbEstadosCiviles { get; set; }
    }
}
