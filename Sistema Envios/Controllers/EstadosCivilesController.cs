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
    public class EstadosCivilesController : Controller
    {
        private DBArticulosEncargosEntities1 db = new DBArticulosEncargosEntities1();
        public string Usu = "1";

        // GET: EstadosCiviles
        public ActionResult Index()
        {
            var tbEstadosCivilesIndex = db.V_INDEX_ESTADOS_CIVILES;
            return View(tbEstadosCivilesIndex.ToList());
        }

        // GET: EstadosCiviles/Details/5
        public ActionResult Details(string id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            tbEstadosCiviles tbEstadosCiviles = db.tbEstadosCiviles.Find(id);
            if (tbEstadosCiviles == null)
            {
                return HttpNotFound();
            }
            return View(tbEstadosCiviles);
        }

        // GET: EstadosCiviles/Create
        public ActionResult Create()
        {
            ViewBag.est_UsuCrea = new SelectList(db.tbUsuarios, "usu_ID", "usu_Usuario");
            ViewBag.est_UsuMod = new SelectList(db.tbUsuarios, "usu_ID", "usu_Usuario");
            return View();
        }

        // POST: EstadosCiviles/Create
        // Para protegerse de ataques de publicación excesiva, habilite las propiedades específicas a las que quiere enlazarse. Para obtener 
        // más detalles, vea https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        //[ValidateAntiForgeryToken]
        public ActionResult Create(string txtEstadoCivil)
        {
            int UsuarioCrea = 1;
            if (ModelState.IsValid)
            {
                db.UDP_EstadosCiviles_INSERT(txtEstadoCivil, UsuarioCrea);
                return RedirectToAction("Index");
            }
            return View();
        }

        // GET: EstadosCiviles/Edit/5
        public ActionResult Edit(string id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            tbEstadosCiviles tbEstadosCiviles = db.tbEstadosCiviles.Find(id);
            if (tbEstadosCiviles == null)
            {
                return HttpNotFound();
            }
            ViewBag.est_UsuCrea = new SelectList(db.tbUsuarios, "usu_ID", "usu_Usuario", tbEstadosCiviles.est_UsuCrea);
            ViewBag.est_UsuMod = new SelectList(db.tbUsuarios, "usu_ID", "usu_Usuario", tbEstadosCiviles.est_UsuMod);
            return View(tbEstadosCiviles);
        }

        // POST: EstadosCiviles/Edit/5
        // Para protegerse de ataques de publicación excesiva, habilite las propiedades específicas a las que quiere enlazarse. Para obtener 
        // más detalles, vea https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "est_ID,est_Descripcion,est_UsuCrea,est_FechaCrea,est_UsuMod,est_FechaMod")] tbEstadosCiviles tbEstadosCiviles)
        {
            
            ModelState.Remove("est_UsuCrea");
            ModelState.Remove("est_FechaCrea");
            ModelState.Remove("est_FechaMod");

            if (ModelState.IsValid)
            {
                db.UDP_Editar_EstadosCiviles(tbEstadosCiviles.est_ID, tbEstadosCiviles.est_Descripcion, Usu).ToString();
                return RedirectToAction("Index");
            }
            ViewBag.est_UsuCrea = new SelectList(db.tbUsuarios, "usu_ID", "usu_Usuario", tbEstadosCiviles.est_UsuCrea);
            ViewBag.est_UsuMod = new SelectList(db.tbUsuarios, "usu_ID", "usu_Usuario", tbEstadosCiviles.est_UsuMod);
            return View(tbEstadosCiviles);
        }

        // GET: EstadosCiviles/Delete/5
        //public ActionResult Delete(string id)
        //{
        //    if (id == null)
        //    {
        //        return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
        //    }
        //    tbEstadosCiviles tbEstadosCiviles = db.tbEstadosCiviles.Find(id);
        //    if (tbEstadosCiviles == null)
        //    {
        //        return HttpNotFound();
        //    }
        //    return View(tbEstadosCiviles);
        //}

        //// POST: EstadosCiviles/Delete/5
        //[HttpPost, ActionName("Delete")]
        //[ValidateAntiForgeryToken]
        //public ActionResult DeleteConfirmed(string id)
        //{
        //    tbEstadosCiviles tbEstadosCiviles = db.tbEstadosCiviles.Find(id);
        //    db.tbEstadosCiviles.Remove(tbEstadosCiviles);
        //    db.SaveChanges();
        //    return RedirectToAction("Index");
        //}

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
