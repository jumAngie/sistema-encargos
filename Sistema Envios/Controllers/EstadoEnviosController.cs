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
    public class EstadoEnviosController : Controller
    {
        private DBArticulosEncargosEntities db = new DBArticulosEncargosEntities();

        // GET: EstadoEnvios
        public ActionResult Index()
        {
            return View(db.tbEstadoEnvios.ToList());
        }

        // GET: EstadoEnvios/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            tbEstadoEnvios tbEstadoEnvios = db.tbEstadoEnvios.Find(id);
            if (tbEstadoEnvios == null)
            {
                return HttpNotFound();
            }
            return View(tbEstadoEnvios);
        }

        // GET: EstadoEnvios/Create
        public ActionResult Create()
        {
            return View();
        }

        // POST: EstadoEnvios/Create
        // Para protegerse de ataques de publicación excesiva, habilite las propiedades específicas a las que quiere enlazarse. Para obtener 
        // más detalles, vea https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "estv_Id,estv_Description")] tbEstadoEnvios tbEstadoEnvios)
        {
            if (ModelState.IsValid)
            {
                db.tbEstadoEnvios.Add(tbEstadoEnvios);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            return View(tbEstadoEnvios);
        }

        // GET: EstadoEnvios/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            tbEstadoEnvios tbEstadoEnvios = db.tbEstadoEnvios.Find(id);
            if (tbEstadoEnvios == null)
            {
                return HttpNotFound();
            }
            return View(tbEstadoEnvios);
        }

        // POST: EstadoEnvios/Edit/5
        // Para protegerse de ataques de publicación excesiva, habilite las propiedades específicas a las que quiere enlazarse. Para obtener 
        // más detalles, vea https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "estv_Id,estv_Description")] tbEstadoEnvios tbEstadoEnvios)
        {
            if (ModelState.IsValid)
            {
                db.Entry(tbEstadoEnvios).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            return View(tbEstadoEnvios);
        }

        // GET: EstadoEnvios/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            tbEstadoEnvios tbEstadoEnvios = db.tbEstadoEnvios.Find(id);
            if (tbEstadoEnvios == null)
            {
                return HttpNotFound();
            }
            return View(tbEstadoEnvios);
        }

        // POST: EstadoEnvios/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            tbEstadoEnvios tbEstadoEnvios = db.tbEstadoEnvios.Find(id);
            db.tbEstadoEnvios.Remove(tbEstadoEnvios);
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
