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
        public string Usu = "1";

        // GET: Direcciones
        public ActionResult Index()
        {
            var tbDireccionesIndex = db.V_INDEX_DIRECCIONES;
            return View(tbDireccionesIndex.ToList());
        }

        // GET: Direcciones/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            tbDirecciones tbDirecciones = db.tbDirecciones.Find(id);
            if (tbDirecciones == null)
            {
                return HttpNotFound();
            }
            return View(tbDirecciones);
        }

        // GET: Direcciones/Create
        public ActionResult Create()
        {
            ViewBag.direc_CiudadID = new SelectList(db.tbCiudades, "ciu_ID", "ciu_Descripcion");
            ViewBag.direc_ClienteID = new SelectList(db.tbClientes, "client_ID", "client_Nombre");
            ViewBag.direc_UsuarioCreador = new SelectList(db.tbUsuarios, "usu_ID", "usu_Usuario");
            ViewBag.direc_UsuarioMod = new SelectList(db.tbUsuarios, "usu_ID", "usu_Usuario");
            return View();
        }

        // POST: Direcciones/Create
        // Para protegerse de ataques de publicación excesiva, habilite las propiedades específicas a las que quiere enlazarse. Para obtener 
        // más detalles, vea https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        //[ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "direc_ID,direc_ClienteID,direc_DireccionExacta,direc_CiudadID,direc_UsuarioCreador,direc_FechaCreacion,direc_UsuarioMod,direc_FechaMod,direc_Estado")] tbDirecciones tbDirecciones)
        {
            // AÑADIR UN MODEL STATE ERROR Y LLENARLO EN EL MODAL
            if (ModelState.IsValid)
            {
                db.tbDirecciones.Add(tbDirecciones);
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            //ViewBag.direc_CiudadID = new SelectList(db.tbCiudades, "ciu_ID", "ciu_Descripcion", tbDirecciones.direc_CiudadID);
            //ViewBag.direc_ClienteID = new SelectList(db.tbClientes, "client_ID", "client_Nombre", tbDirecciones.direc_ClienteID);
            //ViewBag.direc_UsuarioCreador = new SelectList(db.tbUsuarios, "usu_ID", "usu_Usuario", tbDirecciones.direc_UsuarioCreador);
            //ViewBag.direc_UsuarioMod = new SelectList(db.tbUsuarios, "usu_ID", "usu_Usuario", tbDirecciones.direc_UsuarioMod);
            return View();
        }

        // GET: Direcciones/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            tbDirecciones tbDirecciones = db.tbDirecciones.Find(id);
            if (tbDirecciones == null)
            {
                return HttpNotFound();
            }
            ViewBag.direc_CiudadID = new SelectList(db.tbCiudades, "ciu_ID", "ciu_Descripcion", tbDirecciones.direc_CiudadID);
            ViewBag.direc_ClienteID = new SelectList(db.tbClientes, "client_ID", "client_Nombre", tbDirecciones.direc_ClienteID);
            ViewBag.direc_UsuarioCreador = new SelectList(db.tbUsuarios, "usu_ID", "usu_Usuario", tbDirecciones.direc_UsuarioCreador);
            ViewBag.direc_UsuarioMod = new SelectList(db.tbUsuarios, "usu_ID", "usu_Usuario", tbDirecciones.direc_UsuarioMod);
            return View(tbDirecciones);
        }

        // POST: Direcciones/Edit/5
        // Para protegerse de ataques de publicación excesiva, habilite las propiedades específicas a las que quiere enlazarse. Para obtener 
        // más detalles, vea https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "direc_ID,direc_ClienteID,direc_DireccionExacta,direc_CiudadID,direc_UsuarioCreador,direc_FechaCreacion,direc_UsuarioMod,direc_FechaMod,direc_Estado")] tbDirecciones tbDirecciones)
        {
            // ,,direc_UsuarioMod,,
            ModelState.Remove("direc_UsuarioCreador");
            ModelState.Remove("direc_FechaCreacion");
            ModelState.Remove("direc_FechaMod");
            ModelState.Remove("direc_Estado");

            if (ModelState.IsValid)
            {
                db.UDP_Editar_Direcciones(tbDirecciones.direc_ID, tbDirecciones.direc_ClienteID, tbDirecciones.direc_DireccionExacta, tbDirecciones.direc_CiudadID, Usu).ToString();
                return RedirectToAction("Index");
            }
            ViewBag.direc_CiudadID = new SelectList(db.tbCiudades, "ciu_ID", "ciu_Descripcion", tbDirecciones.direc_CiudadID);
            ViewBag.direc_ClienteID = new SelectList(db.tbClientes, "client_ID", "client_Nombre", tbDirecciones.direc_ClienteID);
            ViewBag.direc_UsuarioCreador = new SelectList(db.tbUsuarios, "usu_ID", "usu_Usuario", tbDirecciones.direc_UsuarioCreador);
            ViewBag.direc_UsuarioMod = new SelectList(db.tbUsuarios, "usu_ID", "usu_Usuario", tbDirecciones.direc_UsuarioMod);
            return View(tbDirecciones);
        }

        // GET: Direcciones/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            tbDirecciones tbDirecciones = db.tbDirecciones.Find(id);
            if (tbDirecciones == null)
            {
                return HttpNotFound();
            }
            return View(tbDirecciones);
        }

        // POST: Direcciones/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            tbDirecciones tbDirecciones = db.tbDirecciones.Find(id);
            db.UDP_Eliminar_Direcciones(id, Usu);
            db.SaveChanges();
            return RedirectToAction("Index");
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
