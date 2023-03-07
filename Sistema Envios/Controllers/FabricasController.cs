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
    public class FabricasController : Controller
    {
        private DBArticulosEncargosEntities1 db = new DBArticulosEncargosEntities1();
        

        // GET: Fabricas
        public ActionResult Index()
        {if (Session.Count > 0)
            {
                var tbFabricasIndex = db.V_INDEX_FABRICAS;
                return View(tbFabricasIndex.ToList());
            }
            else
            {
                return RedirectToAction("Index", "Login");
            }
        }

        // GET: Fabricas/Details/5
        public ActionResult Details(int? id)
        {
            try
            {
                if (id == null)
                {
                    return RedirectToAction("Index");
                }
                tbFabricas tbFabricas = db.tbFabricas.Find(id);
                if (tbFabricas == null)
                {
                    return HttpNotFound(); // pagina 404 NOT FOUND
                }
                return View(tbFabricas);
            }
            catch (Exception)
            {

                return RedirectToAction("Index");
            }
           
            
        }

        [HttpPost]
        public ActionResult Create(string txtFab, string txtTel)
        {
            try
            {
                int UsuarioModi = Int32.Parse(Session["UsuarioID"].ToString());
                if (ModelState.IsValid)
                {
                    db.UDP_InsertFabrica(txtFab, txtTel, UsuarioModi);
                    return RedirectToAction("Index");
                }
                else
                {
                    return View(); // VISTA 404
                }
            }
            catch (Exception)
            {
                return RedirectToAction("Index");

            }
        }


        [HttpPost]
        public JsonResult Cargar(string fabri_ID)
        {
            var tbEstadosCiviles1 = db.UDP_CARGARDATOS_FABRICA(int.Parse(fabri_ID)).ToList();
            return Json(tbEstadosCiviles1, JsonRequestBehavior.AllowGet);
        }





        [HttpPost, ActionName("Editores")]
        //[ValidateAntiForgeryToken]
        public ActionResult Edito(string ID, string Descripcion, string telefono)

        {
            if (ModelState.IsValid)
            {
                try
                {


                    if (Descripcion != "" && telefono != "")
                    {
                      
                        //string id = Session["IdUsuario"].ToString();
                        var Edit = db.UDP_Editar_Fabricas(int.Parse(ID), Descripcion, telefono, Session["UsuarioID"].ToString());


                        return RedirectToAction("Index");
                    }
                }
                catch (Exception)
                {
                    return RedirectToAction("Index");
                }

            }

            return RedirectToAction("Index");
        }


        // GET: Fabricas/Delete/5
        public ActionResult Delete(int id)
        {
            try
            {
                db.UDP_Eliminar_Fabricas(id, Session["UsuarioID"].ToString());
                return RedirectToAction("Index");

            }
            catch (Exception)
            {

                return  RedirectToAction("Index"); // pagina 404
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
