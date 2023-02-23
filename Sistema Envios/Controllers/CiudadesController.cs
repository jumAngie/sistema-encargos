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
    public class CiudadesController : Controller
    {
        private DBArticulosEncargosEntities db = new DBArticulosEncargosEntities();

        // GET: Ciudades
        public ActionResult Index()
        {
            var tbCiudades = db.tbCiudades.Include(t => t.tbDepartamentos).Include(t => t.tbUsuarios).Include(t => t.tbUsuarios1);
            return View(tbCiudades.ToList());
        }

        // GET: Ciudades/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            tbCiudades tbCiudades = db.tbCiudades.Find(id);
            if (tbCiudades == null)
            {
                return HttpNotFound();
            }
            return View(tbCiudades);
        }

        // GET: Ciudades/Create
        public ActionResult Create()
        {
            ViewBag.ciu_DeptoID = new SelectList(db.tbDepartamentos, "depto_ID", "depto_Descripcion");
            ViewBag.ciu_UsuarioCreador = new SelectList(db.tbUsuarios, "usu_ID", "usu_Usuario");
            ViewBag.ciu_UsuarioMod = new SelectList(db.tbUsuarios, "usu_ID", "usu_Usuario");
            return View();
        }

        // POST: Ciudades/Create
        // Para protegerse de ataques de publicación excesiva, habilite las propiedades específicas a las que quiere enlazarse. Para obtener 
        // más detalles, vea https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "ciu_ID,ciu_Descripcion,ciu_DeptoID,ciu_UsuarioCreador,ciu_FechaCreacion,ciu_UsuarioMod,ciu_FechaMod")] tbCiudades tbCiudades)
        {
            if (ModelState.IsValid)
            {
                db.tbCiudades.Add(tbCiudades);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.ciu_DeptoID = new SelectList(db.tbDepartamentos, "depto_ID", "depto_Descripcion", tbCiudades.ciu_DeptoID);
            ViewBag.ciu_UsuarioCreador = new SelectList(db.tbUsuarios, "usu_ID", "usu_Usuario", tbCiudades.ciu_UsuarioCreador);
            ViewBag.ciu_UsuarioMod = new SelectList(db.tbUsuarios, "usu_ID", "usu_Usuario", tbCiudades.ciu_UsuarioMod);
            return View(tbCiudades);
        }

        // GET: Ciudades/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            tbCiudades tbCiudades = db.tbCiudades.Find(id);
            if (tbCiudades == null)
            {
                return HttpNotFound();
            }
            ViewBag.ciu_DeptoID = new SelectList(db.tbDepartamentos, "depto_ID", "depto_Descripcion", tbCiudades.ciu_DeptoID);
            ViewBag.ciu_UsuarioCreador = new SelectList(db.tbUsuarios, "usu_ID", "usu_Usuario", tbCiudades.ciu_UsuarioCreador);
            ViewBag.ciu_UsuarioMod = new SelectList(db.tbUsuarios, "usu_ID", "usu_Usuario", tbCiudades.ciu_UsuarioMod);
            return View(tbCiudades);
        }

        // POST: Ciudades/Edit/5
        // Para protegerse de ataques de publicación excesiva, habilite las propiedades específicas a las que quiere enlazarse. Para obtener 
        // más detalles, vea https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "ciu_ID,ciu_Descripcion,ciu_DeptoID,ciu_UsuarioCreador,ciu_FechaCreacion,ciu_UsuarioMod,ciu_FechaMod")] tbCiudades tbCiudades)
        {
            if (ModelState.IsValid)
            {
                db.Entry(tbCiudades).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.ciu_DeptoID = new SelectList(db.tbDepartamentos, "depto_ID", "depto_Descripcion", tbCiudades.ciu_DeptoID);
            ViewBag.ciu_UsuarioCreador = new SelectList(db.tbUsuarios, "usu_ID", "usu_Usuario", tbCiudades.ciu_UsuarioCreador);
            ViewBag.ciu_UsuarioMod = new SelectList(db.tbUsuarios, "usu_ID", "usu_Usuario", tbCiudades.ciu_UsuarioMod);
            return View(tbCiudades);
        }

        // GET: Ciudades/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            tbCiudades tbCiudades = db.tbCiudades.Find(id);
            if (tbCiudades == null)
            {
                return HttpNotFound();
            }
            return View(tbCiudades);
        }

        // POST: Ciudades/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            tbCiudades tbCiudades = db.tbCiudades.Find(id);
            db.tbCiudades.Remove(tbCiudades);
            db.SaveChanges();
            return RedirectToAction("Index");
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
