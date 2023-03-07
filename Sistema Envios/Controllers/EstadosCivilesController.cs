using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.ServiceModel.Channels;
using System.Web;
using System.Web.Mvc;
using Sistema_Envios.Models;


namespace Sistema_Envios.Controllers
{

   
    public class EstadosCivilesController : Controller
    {
        
        private DBArticulosEncargosEntities1 db = new DBArticulosEncargosEntities1();
        

        public ActionResult Index()
        {
           if (Session.Count > 0)
            {
                var tbEstadosCivilesIndex = db.V_INDEX_ESTADOS_CIVILES;
                return View(tbEstadosCivilesIndex.ToList());
            }
           else
            {
                return RedirectToAction("Index", "Login");
            }
            
        }

        // GET: EstadosCiviles/Details/5
        public ActionResult Details(string id)
        {
            try
            {
                if (id == null)
                {
                    return RedirectToAction("Index");
                }
                tbEstadosCiviles tbEstadosCiviles = db.tbEstadosCiviles.Find(id);
                if (tbEstadosCiviles == null)
                {
                    return HttpNotFound(); // 404 page not found
                }
                return View(tbEstadosCiviles);
            }
            catch (Exception)
            {

                return RedirectToAction("Index"); // 404 page not foun
            }
            
        }

        [HttpPost]
        public ActionResult Create(string txtEstadoCivil)
        {
            try
            {
                if (ModelState.IsValid)
                {
                    db.UDP_EstadosCiviles_INSERT(txtEstadoCivil, Int32.Parse(Session["UsuarioID"].ToString()));
                    return RedirectToAction("Index");
                }
                return View();
                
            }
            catch (Exception)
            {
                return RedirectToAction("Index"); // pagna 404 no se puede insertar un estado civil con la misma Letraaaa
            }
            
        }

        [HttpPost]

        public JsonResult Cargar (string est_ID)
        {

            var jso = db.UDP_CARGAR_ESTADOSCIVILES(est_ID).ToList();

            return Json(jso, JsonRequestBehavior.AllowGet);
        }

        [HttpPost, ActionName("Editores")]
        public ActionResult Edito(string ID, string estado)

        {
            try
            {
                if (ModelState.IsValid)
                {
                    if (estado != "")
                    {
                        db.UDP_Editar_EstadosCiviles(ID, estado, Session["UsuarioID"].ToString());


                        return RedirectToAction("Index");
                    }

                }

                return RedirectToAction("Index");
            }
            catch (Exception)
            {

                return RedirectToAction("Index"); // pagina 404
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
