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
    
    public partial class tbDirecciones
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public tbDirecciones()
        {
            this.tbPedidos = new HashSet<tbPedidos>();
        }
    
        public int direc_ID { get; set; }
        public int direc_ClienteID { get; set; }
        public string direc_DireccionExacta { get; set; }
        public int direc_CiudadID { get; set; }
        public int direc_UsuarioCreador { get; set; }
        public System.DateTime direc_FechaCreacion { get; set; }
        public Nullable<int> direc_UsuarioMod { get; set; }
        public Nullable<System.DateTime> direc_FechaMod { get; set; }
        public bool direc_Estado { get; set; }
    
        public virtual tbCiudades tbCiudades { get; set; }
        public virtual tbClientes tbClientes { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<tbPedidos> tbPedidos { get; set; }
        public virtual tbUsuarios tbUsuarios { get; set; }
        public virtual tbUsuarios tbUsuarios1 { get; set; }
    }
}
