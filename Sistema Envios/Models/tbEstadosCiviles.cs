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
    
    public partial class tbEstadosCiviles
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public tbEstadosCiviles()
        {
            this.tbClientes = new HashSet<tbClientes>();
            this.tbEmpleados = new HashSet<tbEmpleados>();
        }
    
        public string est_ID { get; set; }
        public string est_Descripcion { get; set; }
        public int est_UsuCrea { get; set; }
        public System.DateTime est_FechaCrea { get; set; }
        public Nullable<int> est_UsuMod { get; set; }
        public Nullable<System.DateTime> est_FechaMod { get; set; }
        public bool est_Estado { get; set; }
    
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<tbClientes> tbClientes { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<tbEmpleados> tbEmpleados { get; set; }
        public virtual tbUsuarios tbUsuarios { get; set; }
        public virtual tbUsuarios tbUsuarios1 { get; set; }
    }
}
