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
    public class ArticulosController : Controller
    {
        private DBArticulosEncargosEntities1 db = new DBArticulosEncargosEntities1();
        public string UsuarioModi = "1";

        // GET: Articulos
        public ActionResult Index()
        {
            var tbArticulosIndex = db.V_INDEX_ARTICULOS;
            return View(tbArticulosIndex.ToList());
        }

        // GET: Articulos/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            tbArticulos tbArticulosDetails = db.tbArticulos.Find(id);
            if (tbArticulosDetails == null)
            {
                return HttpNotFound();
            }
            return View(tbArticulosDetails);
        }


        // GET: Articulos/Create
        public ActionResult Create()
        {
            ViewBag.fab_ID = new SelectList(db.UDP_CargarFabricas(), "fab_ID", "fab_Descripcion");
            ViewBag.art_UsuarioCreador = new SelectList(db.tbUsuarios, "usu_ID", "usu_Usuario");
            ViewBag.art_UsuarioMod = new SelectList(db.tbUsuarios, "usu_ID", "usu_Usuario");
            return View();
        }

        // POST: Articulos/Create
        // Para protegerse de ataques de publicación excesiva, habilite las propiedades específicas a las que quiere enlazarse. Para obtener 
        // más detalles, vea https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        public ActionResult Create(string txtArticulo, string txtFabrica, string Stock)
        {
            int Modi = 1;
            int fab = Int32.Parse(txtFabrica);
            int stock = Int32.Parse(Stock);
            if (ModelState.IsValid)
            {
                db.UDP_InsertArticulos(txtArticulo, fab, stock, Modi);
                return RedirectToAction("Index");
            }
            return View();
        }

        // GET: Articulos/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            tbArticulos tbArticulos = db.tbArticulos.Find(id);
            if (tbArticulos == null)
            {
                return HttpNotFound();
            }
            ViewBag.fab_ID = new SelectList(db.tbFabricas, "fab_ID", "fab_Descripcion", tbArticulos.fab_ID);
            ViewBag.art_UsuarioCreador = new SelectList(db.tbUsuarios, "usu_ID", "usu_Usuario", tbArticulos.art_UsuarioCreador);
            ViewBag.art_UsuarioMod = new SelectList(db.tbUsuarios, "usu_ID", "usu_Usuario", tbArticulos.art_UsuarioMod);
            return View(tbArticulos);
        }

        // POST: Articulos/Edit/5
        // Para protegerse de ataques de publicación excesiva, habilite las propiedades específicas a las que quiere enlazarse. Para obtener 
        // más detalles, vea https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "art_ID,art_Descripcion,fab_ID,art_Stock,art_UsuarioCreador,art_FechaCreacion,art_UsuarioMod,art_FechaMod,art_Estado")] tbArticulos tbArticulos)
        {
            
            ModelState.Remove("art_UsuarioCreador");
            ModelState.Remove("art_FechaCreacion");
            ModelState.Remove("art_FechaMod");
            ModelState.Remove("art_Estado");

            if (ModelState.IsValid)
            {
                db.UDP_Editar_Articulos(tbArticulos.art_ID, tbArticulos.art_Descripcion, tbArticulos.fab_ID, tbArticulos.art_Stock, UsuarioModi).ToString();
                return RedirectToAction("Index");
            }
            ViewBag.fab_ID = new SelectList(db.tbFabricas, "fab_ID", "fab_Descripcion", tbArticulos.fab_ID);
            ViewBag.art_UsuarioCreador = new SelectList(db.tbUsuarios, "usu_ID", "usu_Usuario", tbArticulos.art_UsuarioCreador);
            ViewBag.art_UsuarioMod = new SelectList(db.tbUsuarios, "usu_ID", "usu_Usuario", tbArticulos.art_UsuarioMod);
            return View(tbArticulos);
        }

        // GET: Articulos/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            tbArticulos tbArticulos = db.tbArticulos.Find(id);
            if (tbArticulos == null)
            {
                return HttpNotFound();
            }
            return View(tbArticulos);
        }

        // POST: Articulos/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            tbArticulos tbArticulos = db.tbArticulos.Find(id);
            db.UDP_Eliminar_Articulos(id, UsuarioModi).ToString();
            return RedirectToAction("Index");
        }

        public JsonResult CargarFabricas()
        {
            var ddl = db.UDP_CargarFabricas().ToList();

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
