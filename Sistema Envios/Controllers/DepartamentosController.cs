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
    public class DepartamentosController : Controller
    {
        private DBArticulosEncargosEntities1 db = new DBArticulosEncargosEntities1();

        // GET: Departamentos
        public ActionResult Index()
        {if (Session.Count > 0)
            {
                if (Session["Rol_ID"].ToString() == "2")
                {
                    return RedirectToAction("Principal", "Login");
                }
                else
                {
                    var tbDepartamentosIndex = db.V_INDEX_DEPARTAMENTOS;
                    return View(tbDepartamentosIndex.ToList());
                }
            }
            else
            {
                return RedirectToAction("Index", "Login");
            }
        }

        [HttpPost]
        public ActionResult Create(string txtDeptos)
        {
            try
            {
                if (ModelState.IsValid)
                {
                    db.UDP_DEPARTAMENTOS_INSERT(txtDeptos, Int32.Parse(Session["UsuarioID"].ToString()));
                    return RedirectToAction("Index");
                }
                return View();
            }
            catch (Exception)
            {

                return RedirectToAction("Index");
            }
            
        }


        [HttpPost]
        public JsonResult Cargar(string depto_ID)
        {

            var tbCargos = db.UDP_CARGAR_DEPARTAMENTO(int.Parse(depto_ID)).ToList();
            return Json(tbCargos, JsonRequestBehavior.AllowGet);
        }





        [HttpPost, ActionName("Editores")]
        public ActionResult Edito(string ID, string Descripcion)

        {
           

            try
            {
                if (ModelState.IsValid)
                {
                    string usuario = Session["UsuarioID"].ToString();
                    if (Descripcion != "" && Descripcion != null)
                    {
                        var Edit = db.UDP_Editar_Departamentos(int.Parse(ID), Descripcion, usuario);
                        return RedirectToAction("Index");
                    }
                    else
                    {
                        return RedirectToAction("Index");
                    }

                }
            }
            catch(Exception)
            {
                return RedirectToAction("Index");
            }
           

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
