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

        // GET: Usuarios
        public ActionResult Index()
        {
            if (Session.Count > 0)
            {
                if (Session["Rol_ID"].ToString() == "2")
                {
                    return RedirectToAction("Principal", "Login");
                }
                else
                {
                    var tbUsuarios = db.V_INDEX_USUARIOS;
                    return View(tbUsuarios.ToList());
                }
            }
            else
            {
                return RedirectToAction("Index", "Login");
            }
      }

        // GET: Usuarios/Details/5
        public ActionResult Details(int? id)
        {
            try
            {
                if (Session.Count > 0)
                {
                    if (Session["Rol_ID"].ToString() == "2")
                    {
                        return RedirectToAction("Principal", "Login");
                    }
                    else
                    {
                        if (id == null)
                        {
                            return RedirectToAction("Index");
                        }
                        tbUsuarios tbUsuarios = db.tbUsuarios.Find(id);
                        if (tbUsuarios == null)
                        {
                            return HttpNotFound();
                        }
                        return View(tbUsuarios);
                    }
                }
                else
                {
                    return RedirectToAction("Index", "Login");
                }
            }
            catch (Exception)
            {

                return RedirectToAction("Index");
            }
            

        }

        [HttpPost]
        public JsonResult CargarEmpleados()
        {
            var ddl = db.UDP_CargarEmpleados().ToList();

            return Json(ddl, JsonRequestBehavior.AllowGet);

        }
        [HttpPost]
        public JsonResult CargarRoles()
        {
            var ddl = db.UDP_CargarRol().ToList();

            return Json(ddl, JsonRequestBehavior.AllowGet);

        }

        [HttpPost]
        public ActionResult Create(string txtUsuario, string txtClave, string emp_Id, string ckEsAdmin, string rol_ID)
        {
            if (ModelState.IsValid)
            {
                try
                {
                    int Usu = Int32.Parse(Session["UsuarioID"].ToString());
                    db.UDP_USUARIOS_INSERT(txtUsuario, Convert.ToInt32(emp_Id), Convert.ToInt32(rol_ID), txtClave, ckEsAdmin, Usu);
                    db.SaveChanges();
                    return RedirectToAction("Index");
                }
                catch (Exception)
                {
                    return RedirectToAction("Error", "Shared");
                    throw;
                }

            }

            return View();
        }
        [HttpPost]
        public JsonResult CargarUsuario(int? id)
        {
            tbUsuarios tbUsuarios = db.tbUsuarios.Find(id);
            var usuariosinfo = db.UDP_Obtener_Usuario(id).ToList();

            return Json(usuariosinfo, JsonRequestBehavior.AllowGet);
        }
        [HttpPost]
        public JsonResult CargarEmpleado()
        {
            var ddl = db.UDP_CargarEmpleados_EditUsuarios().ToList();

            return Json(ddl, JsonRequestBehavior.AllowGet);

        }
        [HttpPost]
        public JsonResult CargarRol()
        {
            var ddl = db.UDP_CargarRolParaEditar().ToList();

            return Json(ddl, JsonRequestBehavior.AllowGet);

        }

        [HttpPost, ActionName("EditarUsu")]
        public ActionResult Editar(int usu_ID, string txtUsuario, bool ckEsAdmin, int rol_ID)
        {
            if (ModelState.IsValid)
            {
                try
                {
                    int Usu = Int32.Parse(Session["UsuarioID"].ToString());
                    if (ModelState.IsValid)
                    {
                        db.UDP_Editar_Usuarios(usu_ID, txtUsuario, rol_ID, ckEsAdmin, Convert.ToString(Usu)).ToString();
                        return RedirectToAction("Index");
                    }
                    //ViewBag.rol_ID = new SelectList(db.tblRoles, "rol_ID", "rol_Descripcion", tbUsuarios.rol_ID);
                    return View();
                }
                catch (Exception)
                {
                    return RedirectToAction("Error");
                    throw;
                }
            }

            return RedirectToAction("Index");
        }

        // GET: Usuarios/Delete/5
        public ActionResult Delete(int id)
        {
            try
            {
                int Usu = Int32.Parse(Session["UsuarioID"].ToString());
                db.UDP_Eliminar_Usuarios(id, Convert.ToString(Usu));
                return RedirectToAction("Index");
            }
            catch (Exception)
            {
                return RedirectToAction("Index");
                throw;
            }

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
