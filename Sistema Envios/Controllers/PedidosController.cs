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
    public class PedidosController : Controller
    {
        private DBArticulosEncargosEntities db = new DBArticulosEncargosEntities();

        // GET: Pedidos
        public ActionResult Index()
        {
            var tbPedidos = db.V_INDEX_PEDIDOS;
            return View(tbPedidos.ToList());
        }

        // GET: Pedidos/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            tbPedidos tbPedidos = db.tbPedidos.Find(id);
            if (tbPedidos == null)
            {
                return HttpNotFound();
            }
            return View(tbPedidos);
        }

        // GET: Pedidos/Create
        public ActionResult Create()
        {
            ViewBag.pedi_DireccionID = new SelectList(db.tbDirecciones, "direc_ID", "direc_DireccionExacta");
            ViewBag.estv_Id = new SelectList(db.tbEstadoEnvios, "estv_Id", "estv_Description");
            ViewBag.pedi_UsuarioCreador = new SelectList(db.tbUsuarios, "usu_ID", "usu_Usuario");
            ViewBag.pedi_UsuarioMod = new SelectList(db.tbUsuarios, "usu_ID", "usu_Usuario");
            return View();
        }

        // POST: Pedidos/Create
        // Para protegerse de ataques de publicación excesiva, habilite las propiedades específicas a las que quiere enlazarse. Para obtener 
        // más detalles, vea https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "pedi_ID,pedi_Code,pedi_DireccionID,pedi_CostoEnvio,estv_Id,emp_Id,pedi_Fecha,pedi_UsuarioCreador,pedi_FechaCreacion,pedi_UsuarioMod,pedi_FechaMod,pedi_Estado")] tbPedidos tbPedidos)
        {
            if (ModelState.IsValid)
            {
                db.tbPedidos.Add(tbPedidos);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.pedi_DireccionID = new SelectList(db.tbDirecciones, "direc_ID", "direc_DireccionExacta", tbPedidos.pedi_DireccionID);
            ViewBag.estv_Id = new SelectList(db.tbEstadoEnvios, "estv_Id", "estv_Description", tbPedidos.estv_Id);
            ViewBag.pedi_UsuarioCreador = new SelectList(db.tbUsuarios, "usu_ID", "usu_Usuario", tbPedidos.pedi_UsuarioCreador);
            ViewBag.pedi_UsuarioMod = new SelectList(db.tbUsuarios, "usu_ID", "usu_Usuario", tbPedidos.pedi_UsuarioMod);
            return View(tbPedidos);
        }

        // GET: Pedidos/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            tbPedidos tbPedidos = db.tbPedidos.Find(id);
            if (tbPedidos == null)
            {
                return HttpNotFound();
            }
            ViewBag.pedi_DireccionID = new SelectList(db.tbDirecciones, "direc_ID", "direc_DireccionExacta", tbPedidos.pedi_DireccionID);
            ViewBag.estv_Id = new SelectList(db.tbEstadoEnvios, "estv_Id", "estv_Description", tbPedidos.estv_Id);
            ViewBag.pedi_UsuarioCreador = new SelectList(db.tbUsuarios, "usu_ID", "usu_Usuario", tbPedidos.pedi_UsuarioCreador);
            ViewBag.pedi_UsuarioMod = new SelectList(db.tbUsuarios, "usu_ID", "usu_Usuario", tbPedidos.pedi_UsuarioMod);
            return View(tbPedidos);
        }

        // POST: Pedidos/Edit/5
        // Para protegerse de ataques de publicación excesiva, habilite las propiedades específicas a las que quiere enlazarse. Para obtener 
        // más detalles, vea https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "pedi_ID,pedi_Code,pedi_DireccionID,pedi_CostoEnvio,estv_Id,emp_Id,pedi_Fecha,pedi_UsuarioCreador,pedi_FechaCreacion,pedi_UsuarioMod,pedi_FechaMod,pedi_Estado")] tbPedidos tbPedidos)
        {
            if (ModelState.IsValid)
            {
                db.Entry(tbPedidos).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.pedi_DireccionID = new SelectList(db.tbDirecciones, "direc_ID", "direc_DireccionExacta", tbPedidos.pedi_DireccionID);
            ViewBag.estv_Id = new SelectList(db.tbEstadoEnvios, "estv_Id", "estv_Description", tbPedidos.estv_Id);
            ViewBag.pedi_UsuarioCreador = new SelectList(db.tbUsuarios, "usu_ID", "usu_Usuario", tbPedidos.pedi_UsuarioCreador);
            ViewBag.pedi_UsuarioMod = new SelectList(db.tbUsuarios, "usu_ID", "usu_Usuario", tbPedidos.pedi_UsuarioMod);
            return View(tbPedidos);
        }

        // GET: Pedidos/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            tbPedidos tbPedidos = db.tbPedidos.Find(id);
            if (tbPedidos == null)
            {
                return HttpNotFound();
            }
            return View(tbPedidos);
        }

        // POST: Pedidos/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            tbPedidos tbPedidos = db.tbPedidos.Find(id);
            db.tbPedidos.Remove(tbPedidos);
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
