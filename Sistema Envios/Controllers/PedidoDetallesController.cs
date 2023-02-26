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
    public class PedidoDetallesController : Controller
    {
        private DBArticulosEncargosEntities db = new DBArticulosEncargosEntities();

        // GET: PedidoDetalles
        public ActionResult Index()
        {
            var tbPedidoDetallesIndex = db.V_INDEX_PEDIDOS_DETALLES;
            return View(tbPedidoDetallesIndex.ToList());
        }

        // GET: PedidoDetalles/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            tbPedidoDetalles tbPedidoDetalles = db.tbPedidoDetalles.Find(id);
            if (tbPedidoDetalles == null)
            {
                return HttpNotFound();
            }
            return View(tbPedidoDetalles);
        }

        // GET: PedidoDetalles/Create
        public ActionResult Create()
        {
            ViewBag.pedi_ID = new SelectList(db.tbPedidos, "pedi_ID", "pedi_Code");
            ViewBag.det_UsuarioCrea = new SelectList(db.tbUsuarios, "usu_ID", "usu_Usuario");
            ViewBag.det_UsuModif = new SelectList(db.tbUsuarios, "usu_ID", "usu_Usuario");
            return View();
        }

        // POST: PedidoDetalles/Create
        // Para protegerse de ataques de publicación excesiva, habilite las propiedades específicas a las que quiere enlazarse. Para obtener 
        // más detalles, vea https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "det_Id,pedi_ID,art_ID,det_Cantidad,det_UsuarioCrea,det_FechaCrea,det_UsuModif,det_FechaModif,det_Estado")] tbPedidoDetalles tbPedidoDetalles)
        {
            if (ModelState.IsValid)
            {
                db.tbPedidoDetalles.Add(tbPedidoDetalles);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.pedi_ID = new SelectList(db.tbPedidos, "pedi_ID", "pedi_Code", tbPedidoDetalles.pedi_ID);
            ViewBag.det_UsuarioCrea = new SelectList(db.tbUsuarios, "usu_ID", "usu_Usuario", tbPedidoDetalles.det_UsuarioCrea);
            ViewBag.det_UsuModif = new SelectList(db.tbUsuarios, "usu_ID", "usu_Usuario", tbPedidoDetalles.det_UsuModif);
            return View(tbPedidoDetalles);
        }

        // GET: PedidoDetalles/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            tbPedidoDetalles tbPedidoDetalles = db.tbPedidoDetalles.Find(id);
            if (tbPedidoDetalles == null)
            {
                return HttpNotFound();
            }
            ViewBag.pedi_ID = new SelectList(db.tbPedidos, "pedi_ID", "pedi_Code", tbPedidoDetalles.pedi_ID);
            ViewBag.det_UsuarioCrea = new SelectList(db.tbUsuarios, "usu_ID", "usu_Usuario", tbPedidoDetalles.det_UsuarioCrea);
            ViewBag.det_UsuModif = new SelectList(db.tbUsuarios, "usu_ID", "usu_Usuario", tbPedidoDetalles.det_UsuModif);
            return View(tbPedidoDetalles);
        }

        // POST: PedidoDetalles/Edit/5
        // Para protegerse de ataques de publicación excesiva, habilite las propiedades específicas a las que quiere enlazarse. Para obtener 
        // más detalles, vea https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "det_Id,pedi_ID,art_ID,det_Cantidad,det_UsuarioCrea,det_FechaCrea,det_UsuModif,det_FechaModif,det_Estado")] tbPedidoDetalles tbPedidoDetalles)
        {
            if (ModelState.IsValid)
            {
                db.Entry(tbPedidoDetalles).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.pedi_ID = new SelectList(db.tbPedidos, "pedi_ID", "pedi_Code", tbPedidoDetalles.pedi_ID);
            ViewBag.det_UsuarioCrea = new SelectList(db.tbUsuarios, "usu_ID", "usu_Usuario", tbPedidoDetalles.det_UsuarioCrea);
            ViewBag.det_UsuModif = new SelectList(db.tbUsuarios, "usu_ID", "usu_Usuario", tbPedidoDetalles.det_UsuModif);
            return View(tbPedidoDetalles);
        }

        // GET: PedidoDetalles/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            tbPedidoDetalles tbPedidoDetalles = db.tbPedidoDetalles.Find(id);
            if (tbPedidoDetalles == null)
            {
                return HttpNotFound();
            }
            return View(tbPedidoDetalles);
        }

        // POST: PedidoDetalles/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            tbPedidoDetalles tbPedidoDetalles = db.tbPedidoDetalles.Find(id);
            db.tbPedidoDetalles.Remove(tbPedidoDetalles);
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
