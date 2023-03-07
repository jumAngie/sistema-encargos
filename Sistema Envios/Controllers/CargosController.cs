using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.WebPages;
using System.Web.Mvc;
using System.Web.UI;
using Sistema_Envios.Models;

namespace Sistema_Envios.Controllers
{
    public class CargosController : Controller
    {
        private DBArticulosEncargosEntities1 db = new DBArticulosEncargosEntities1();
        

        // GET: Cargos
        public ActionResult Index()
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
                        var tbCargosIndex = db.V_INDEX_CARGOS;
                        return View(tbCargosIndex.ToList());
                    }
                        
                }
                else
                {
                    return RedirectToAction("Index", "Login");
                }
            }
            catch (Exception)
            {

                return RedirectToAction("Index", "Login"); // pagina 404
            }
            
            
        }

        // GET: Cargos/Details/5
        public ActionResult Details(int? id)
        {

            try
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
                    tbCargos tbCargos = db.tbCargos.Find(id);
                    if (tbCargos == null)
                    {
                        return HttpNotFound(); // pagina 404
                    }
                    return View(tbCargos);
                }
              
            }
            catch (Exception)
            {

                return RedirectToAction("Index"); // PAGINA 404
            }
            
        }

        [HttpPost]
        public ActionResult Create(string txtCargos)
        { 
            

            if (ModelState.IsValid)
            {
                int UsuarioModi = Int32.Parse(Session["UsuarioID"].ToString());
                try
                {
                    db.UDP_CARGOS_INSERT(txtCargos, UsuarioModi);
                    return RedirectToAction("Index");
                }
                catch (Exception)
                {
                    return RedirectToAction("Index");
                }
                
            }

            return View();
        }

        [HttpPost]
        public JsonResult Cargar(string carg_Id)
        {

            var tbCargos = db.UDP_CARGAR_CARGOS(int.Parse(carg_Id)).ToList();
            return Json(tbCargos, JsonRequestBehavior.AllowGet);
        }

        [HttpPost, ActionName("Editores")]
        public ActionResult Edito(string ID, string Descripcion)

        {
           string usuario = Session["UsuarioID"].ToString();

            try
            {
                if (Descripcion != null && Descripcion != "")
                {

                    if (ModelState.IsValid)
                    {
                     
                        var Edit = db.UDP_Editar_Cargos(int.Parse(ID), Descripcion, usuario);

                    }

                }
                else
                {
                    return RedirectToAction("Index");
                }
            }
            catch(Exception)
            {
                return RedirectToAction("Index");
            }

            return RedirectToAction("Index");
        }
        public ActionResult Delete(int id)
        {
            try
            {

                db.UDP_Eliminar_Cargos(id, Session["UsuarioID"].ToString());
                return RedirectToAction("Index");

            }
            catch (Exception)
            {

                return RedirectToAction("Index"); // página 404
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


