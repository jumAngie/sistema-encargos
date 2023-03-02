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
    public class UsuariosController : Controller
    {
        private DBArticulosEncargosEntities1 db = new DBArticulosEncargosEntities1();
        public string Usu = "1";

        // GET: Usuarios
        public ActionResult Index()
        {
            var tbUsuarios = db.V_INDEX_USUARIOS;
            return View(tbUsuarios.ToList());
        }

        // GET: Usuarios/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            tbUsuarios tbUsuarios = db.tbUsuarios.Find(id);
            if (tbUsuarios == null)
            {
                return HttpNotFound();
            }
            return View(tbUsuarios);
        }

        // GET: Usuarios/Create
        public ActionResult Create()
        {
            ViewBag.rol_ID = new SelectList(db.tblRoles, "rol_ID", "rol_Descripcion");
            return View();
        }

        // POST: Usuarios/Create
        // Para protegerse de ataques de publicación excesiva, habilite las propiedades específicas a las que quiere enlazarse. Para obtener 
        // más detalles, vea https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "usu_ID,usu_Usuario,emp_Id,rol_ID,usu_Clave,usu_UsuarioCreador,usu_FechaCreacion,usu_UsuarioMod,usu_FechaMod,usu_Estado,usu_EsAdmin")] tbUsuarios tbUsuarios)
        {
            

            if (ModelState.IsValid)
            {
                db.tbUsuarios.Add(tbUsuarios);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.rol_ID = new SelectList(db.tblRoles, "rol_ID", "rol_Descripcion", tbUsuarios.rol_ID);
            return View(tbUsuarios);
        }

        // GET: Usuarios/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            tbUsuarios tbUsuarios = db.tbUsuarios.Find(id);
            if (tbUsuarios == null)
            {
                return HttpNotFound();
            }
            ViewBag.rol_ID = new SelectList(db.tblRoles, "rol_ID", "rol_Descripcion", tbUsuarios.rol_ID);
            return View(tbUsuarios);
        }

        // POST: Usuarios/Edit/5
        // Para protegerse de ataques de publicación excesiva, habilite las propiedades específicas a las que quiere enlazarse. Para obtener 
        // más detalles, vea https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "usu_ID,usu_Usuario,emp_Id,rol_ID,usu_Clave,usu_UsuarioCreador,usu_FechaCreacion,usu_UsuarioMod,usu_FechaMod,usu_Estado,usu_EsAdmin")] tbUsuarios tbUsuarios)
        {
            ModelState.Remove("usu_UsuarioCreador");
            ModelState.Remove("usu_FechaCreacion");
            ModelState.Remove("usu_FechaMod");
            ModelState.Remove("usu_Estado");
            ModelState.Remove("usu_Clave");

            if (ModelState.IsValid)
            {
                db.UDP_Editar_Usuarios(tbUsuarios.usu_ID, tbUsuarios.usu_Usuario, tbUsuarios.rol_ID, tbUsuarios.usu_EsAdmin, Usu).ToString();
                return RedirectToAction("Index");
            }
            ViewBag.rol_ID = new SelectList(db.tblRoles, "rol_ID", "rol_Descripcion", tbUsuarios.rol_ID);
            return View(tbUsuarios);
        }

        // GET: Usuarios/Delete/5
        public ActionResult Delete(int id)
        {
            db.UDP_Eliminar_Usuarios(id, Usu);
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
