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
    // GET: Articulos
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
                        var tbArticulosIndex = db.V_INDEX_ARTICULOS;
                        return View(tbArticulosIndex.ToList());

                    }
                   

                }
                else
                {
                    return RedirectToAction("Index", "Login");
                }
            

        }

        // GET: Articulos/Details/5
        public ActionResult Details(int? id)
        {
            if (Session["Rol_ID"].ToString() == "2")
            {
                return RedirectToAction("Principal", "Login");
            }
            else
            {
                try
                {
                    if (id == null)
                    {
                        return RedirectToAction("Index", "Articulos");
                    }
                    tbArticulos tbArticulosDetails = db.tbArticulos.Find(id);
                    if (tbArticulosDetails == null)
                    {
                        return HttpNotFound(); // acá vamos a redireccionar a la pagina 404
                    }
                    return View(tbArticulosDetails);

                }
                catch (Exception)
                {
                    return RedirectToAction("Index", "Articulos"); // acá iria la pagina 404

                }
            }
            
        }
        

        [HttpPost]
        public ActionResult Create(string txtArt, string fabrica_ID, string txtStock)
        {
            try
            {
                if (ModelState.IsValid)
                {
                    int Modi = Int32.Parse(Session["UsuarioID"].ToString());
                    int fab = Int32.Parse(fabrica_ID);
                    int stock = Int32.Parse(txtStock);
                    db.UDP_InsertArticulos(txtArt, fab, stock, Modi);
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
        public JsonResult CARGARFABRICAS()
        {
            var Fabricas = db.UDP_CARGAR_FABRICASArtc().ToList();

            return Json(Fabricas, JsonRequestBehavior.AllowGet);
        }


        [HttpPost]
        public JsonResult Cargar(string art_Id)
        {
           
                var tbArticulos = db.UDP_CARGAR_ARTICULO(int.Parse(art_Id)).ToList();
                return Json(tbArticulos, JsonRequestBehavior.AllowGet);
 
        }



        [HttpPost, ActionName("Editores")]
        //[ValidateAntiForgeryToken]
        public ActionResult Edito(string ID, string articulo, string fabrica, string stock)

        {
            try
            {
                string UsuarioModi = Session["UsuarioID"].ToString();
                if (ModelState.IsValid)
                {
                    if(articulo != "" && stock != "")
                    {                
                    var Edit = db.UDP_Editar_Articulos(int.Parse(ID), articulo, int.Parse(fabrica), int.Parse(stock), UsuarioModi);
                   
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
                db.UDP_Eliminar_Articulos(id, Session["UsuarioID"].ToString());
                return RedirectToAction("Index");
            }
            catch (Exception)
            {
                return RedirectToAction("Index");

            }
            
        }

        public JsonResult CargarFabricasCrear()
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
