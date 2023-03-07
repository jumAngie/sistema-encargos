using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using Sistema_Envios.Models;

namespace Sistema_Envios.Controllers
{
    public class DireccionesController : Controller
    {
        private DBArticulosEncargosEntities1 db = new DBArticulosEncargosEntities1();

        // GET: Direcciones
        public ActionResult Index()
        {
            if (Session.Count > 0)
            {
                if (Session["Rol_ID"].ToString() == "2")
                {
                    return RedirectToAction("Principal", "Login");
                }
                else
                {
                    var tbDireccionesIndex = db.V_INDEX_DIRECCIONES;
                    return View(tbDireccionesIndex.ToList());
                }
            }
            else
            {
                return RedirectToAction("Index", "Login");
            }
            
        }

        public ActionResult Details(int? id)
        {
            try
            {
                if (Session["Rol_ID"].ToString() == "2")
                {
                    return RedirectToAction("Principal", "Login");
                }
                else
                {
                    if (id == null)
                    {
                        return RedirectToAction("Index");
                    }
                    tbDirecciones tbDirecciones = db.tbDirecciones.Find(id);
                    if (tbDirecciones == null)
                    {
                        return HttpNotFound(); // pagina 404
                    }
                    return View(tbDirecciones);
                }
            }
            catch (Exception)
            {

                return RedirectToAction("Index"); //pagina 404
            }
        }

        [HttpPost]
        public ActionResult Create(string client_ID, string txtDirec, string dep_ID, string ciu_ID)
        {
            try
            {
                if (ModelState.IsValid)
                {

                    db.UDP_DIRECCIONES_INSERT(Int32.Parse(client_ID), txtDirec, Int32.Parse(ciu_ID), Int32.Parse(Session["UsuarioID"].ToString()));
                    return RedirectToAction("Index");
                }
                return View();
            }
            catch (Exception)
            {
                return RedirectToAction("Index"); // 404 page

            }
           
        }


        public JsonResult CargarClienteEdit()
        {
            var ddlC = db.UDP_CARGARCLIENTES_DIRECCIONESEdit().ToList();

            return Json(ddlC, JsonRequestBehavior.AllowGet);

        }


        public JsonResult CargarDepartamentosEdit()
        {
            var ddlD = db.UDP_CARGARDEPTOS_DIRECCIONEDIT().ToList();

            return Json(ddlD, JsonRequestBehavior.AllowGet);

        }

        public JsonResult CargarMunicipiosEdit()
        {
            var ddlM = db.UDP_CARGAR_MUNICIPIO().ToList();

            return Json(ddlM, JsonRequestBehavior.AllowGet);

        }

        [HttpPost]
        public JsonResult CargarMunicipiosDEPA(string depto)
        {
            var ddlMM = db.UDP_CargarCiudades(depto).ToList();

            return Json(ddlMM, JsonRequestBehavior.AllowGet);

        }

        [HttpPost]
        public JsonResult Cargar(string direc_ID)
        {
          
                var direc = db.UDP_CARGAR_DIRECCIONESEdit(int.Parse(direc_ID)).ToList();

                return Json(direc, JsonRequestBehavior.AllowGet);
            
           
        }




        [HttpPost, ActionName("Editores")]
        //[ValidateAntiForgeryToken]
        public ActionResult Edito(string ID, string cliente, string ciudad, string direccion)

        {
            if (ModelState.IsValid)
            {
                try
                {
                    if ( direccion != "" && direccion != null)
                    {
                        
                        var Edit = db.UDP_Editar_Direcciones(int.Parse(ID), int.Parse(cliente), direccion, int.Parse(ciudad), Session["UsuarioID"].ToString());
                        
                    }
                }
                catch(Exception)
                {
                    return RedirectToAction("Index");
                }
            }
            else
            {
                return RedirectToAction("Index");
            }

            return RedirectToAction("Index");
        }

        public ActionResult Delete(int id)
        {
            try
            {
                db.UDP_Eliminar_Direcciones(id, Session["UsuarioID"].ToString());
                return RedirectToAction("Index");
            }
            catch (Exception)
            {

                return RedirectToAction("Index"); //pagina 404
            }
            
        }

        public JsonResult CargarCliente()
        {
            var ddl = db.UDP_CargarCliente().ToList();

            return Json(ddl, JsonRequestBehavior.AllowGet);

        }


        public JsonResult CargarDepartamentos()
        {
            var ddl = db.UDP_CargarDepartamentos().ToList();

            return Json(ddl, JsonRequestBehavior.AllowGet);

        }

        public JsonResult CargarMunicipios(string dep_ID)
        {
            var ddl = db.UDP_CargarCiudades(dep_ID).ToList();

            return Json(ddl, JsonRequestBehavior.AllowGet);

        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }
    }
}
