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
    public class ClientesController : Controller
    {
        private DBArticulosEncargosEntities db = new DBArticulosEncargosEntities();

        // GET: Clientes
        public ActionResult Index()
        {
            var tbClientes = db.tbClientes.Include(t => t.tbEstadosCiviles).Include(t => t.tbUsuarios).Include(t => t.tbUsuarios1);
            return View(tbClientes.ToList());
        }

        // GET: Clientes/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            tbClientes tbClientes = db.tbClientes.Find(id);
            if (tbClientes == null)
            {
                return HttpNotFound();
            }
            return View(tbClientes);
        }

        // GET: Clientes/Create
        public ActionResult Create()
        {
            ViewBag.client_EstadoCivil = new SelectList(db.tbEstadosCiviles, "est_ID", "est_Descripcion");
            ViewBag.client_UsuarioCreador = new SelectList(db.tbUsuarios, "usu_ID", "usu_Usuario");
            ViewBag.client_UsuarioMod = new SelectList(db.tbUsuarios, "usu_ID", "usu_Usuario");
            return View();
        }

        // POST: Clientes/Create
        // Para protegerse de ataques de publicación excesiva, habilite las propiedades específicas a las que quiere enlazarse. Para obtener 
        // más detalles, vea https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "client_ID,client_Nombre,client_Identidad,client_EstadoCivil,client_Sexo,client_Telefono,client_Saldo,client_LimiteCredito,client_Descuento,client_UsuarioCreador,client_FechaCreacion,client_UsuarioMod,client_FechaMod,client_Estado")] tbClientes tbClientes)
        {
            if (ModelState.IsValid)
            {
                db.tbClientes.Add(tbClientes);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.client_EstadoCivil = new SelectList(db.tbEstadosCiviles, "est_ID", "est_Descripcion", tbClientes.client_EstadoCivil);
            ViewBag.client_UsuarioCreador = new SelectList(db.tbUsuarios, "usu_ID", "usu_Usuario", tbClientes.client_UsuarioCreador);
            ViewBag.client_UsuarioMod = new SelectList(db.tbUsuarios, "usu_ID", "usu_Usuario", tbClientes.client_UsuarioMod);
            return View(tbClientes);
        }

        // GET: Clientes/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            tbClientes tbClientes = db.tbClientes.Find(id);
            if (tbClientes == null)
            {
                return HttpNotFound();
            }
            ViewBag.client_EstadoCivil = new SelectList(db.tbEstadosCiviles, "est_ID", "est_Descripcion", tbClientes.client_EstadoCivil);
            ViewBag.client_UsuarioCreador = new SelectList(db.tbUsuarios, "usu_ID", "usu_Usuario", tbClientes.client_UsuarioCreador);
            ViewBag.client_UsuarioMod = new SelectList(db.tbUsuarios, "usu_ID", "usu_Usuario", tbClientes.client_UsuarioMod);
            return View(tbClientes);
        }

        // POST: Clientes/Edit/5
        // Para protegerse de ataques de publicación excesiva, habilite las propiedades específicas a las que quiere enlazarse. Para obtener 
        // más detalles, vea https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "client_ID,client_Nombre,client_Identidad,client_EstadoCivil,client_Sexo,client_Telefono,client_Saldo,client_LimiteCredito,client_Descuento,client_UsuarioCreador,client_FechaCreacion,client_UsuarioMod,client_FechaMod,client_Estado")] tbClientes tbClientes)
        {
            if (ModelState.IsValid)
            {
                db.Entry(tbClientes).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.client_EstadoCivil = new SelectList(db.tbEstadosCiviles, "est_ID", "est_Descripcion", tbClientes.client_EstadoCivil);
            ViewBag.client_UsuarioCreador = new SelectList(db.tbUsuarios, "usu_ID", "usu_Usuario", tbClientes.client_UsuarioCreador);
            ViewBag.client_UsuarioMod = new SelectList(db.tbUsuarios, "usu_ID", "usu_Usuario", tbClientes.client_UsuarioMod);
            return View(tbClientes);
        }

        // GET: Clientes/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            tbClientes tbClientes = db.tbClientes.Find(id);
            if (tbClientes == null)
            {
                return HttpNotFound();
            }
            return View(tbClientes);
        }

        // POST: Clientes/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            tbClientes tbClientes = db.tbClientes.Find(id);
            db.tbClientes.Remove(tbClientes);
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
