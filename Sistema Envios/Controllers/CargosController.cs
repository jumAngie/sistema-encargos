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
    public class CargosController : Controller
    {
        private DBArticulosEncargosEntities db = new DBArticulosEncargosEntities();

        // GET: Cargos
        public ActionResult Index()
        {
            var tbCargos = db.tbCargos.Include(t => t.tbUsuarios).Include(t => t.tbUsuarios1);
            return View(tbCargos.ToList());
        }

        // GET: Cargos/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            tbCargos tbCargos = db.tbCargos.Find(id);
            if (tbCargos == null)
            {
                return HttpNotFound();
            }
            return View(tbCargos);
        }

        // GET: Cargos/Create
        public ActionResult Create()
        {
            ViewBag.rep_UsuarioCreador = new SelectList(db.tbUsuarios, "usu_ID", "usu_Usuario");
            ViewBag.rep_UsuarioMod = new SelectList(db.tbUsuarios, "usu_ID", "usu_Usuario");
            return View();
        }

        // POST: Cargos/Create
        // Para protegerse de ataques de publicación excesiva, habilite las propiedades específicas a las que quiere enlazarse. Para obtener 
        // más detalles, vea https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "carg_Id,carg_Description,rep_UsuarioCreador,rep_FechaCreacion,rep_UsuarioMod,rep_FechaMod,rep_Estado")] tbCargos tbCargos)
        {
            if (ModelState.IsValid)
            {
                db.tbCargos.Add(tbCargos);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.rep_UsuarioCreador = new SelectList(db.tbUsuarios, "usu_ID", "usu_Usuario", tbCargos.rep_UsuarioCreador);
            ViewBag.rep_UsuarioMod = new SelectList(db.tbUsuarios, "usu_ID", "usu_Usuario", tbCargos.rep_UsuarioMod);
            return View(tbCargos);
        }

        // GET: Cargos/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            tbCargos tbCargos = db.tbCargos.Find(id);
            if (tbCargos == null)
            {
                return HttpNotFound();
            }
            ViewBag.rep_UsuarioCreador = new SelectList(db.tbUsuarios, "usu_ID", "usu_Usuario", tbCargos.rep_UsuarioCreador);
            ViewBag.rep_UsuarioMod = new SelectList(db.tbUsuarios, "usu_ID", "usu_Usuario", tbCargos.rep_UsuarioMod);
            return View(tbCargos);
        }

        // POST: Cargos/Edit/5
        // Para protegerse de ataques de publicación excesiva, habilite las propiedades específicas a las que quiere enlazarse. Para obtener 
        // más detalles, vea https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "carg_Id,carg_Description,rep_UsuarioCreador,rep_FechaCreacion,rep_UsuarioMod,rep_FechaMod,rep_Estado")] tbCargos tbCargos)
        {
            if (ModelState.IsValid)
            {
                db.Entry(tbCargos).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.rep_UsuarioCreador = new SelectList(db.tbUsuarios, "usu_ID", "usu_Usuario", tbCargos.rep_UsuarioCreador);
            ViewBag.rep_UsuarioMod = new SelectList(db.tbUsuarios, "usu_ID", "usu_Usuario", tbCargos.rep_UsuarioMod);
            return View(tbCargos);
        }

        // GET: Cargos/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            tbCargos tbCargos = db.tbCargos.Find(id);
            if (tbCargos == null)
            {
                return HttpNotFound();
            }
            return View(tbCargos);
        }

        // POST: Cargos/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            tbCargos tbCargos = db.tbCargos.Find(id);
            db.tbCargos.Remove(tbCargos);
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
