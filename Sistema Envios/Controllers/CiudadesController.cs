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
    public class CiudadesController : Controller
    {
        private DBArticulosEncargosEntities1 db = new DBArticulosEncargosEntities1();
        public string UsuarioModi = "1";
        // GET: Ciudades
        public ActionResult Index()
        {
            if(Session.Count > 0)
            {
                var tbCiudadesIndex = db.V_INDEX_CIUDADES;
                return View(tbCiudadesIndex.ToList());
            }
            else
            {
                return RedirectToAction("Index", "Login");
            }
        }

        // GET: Ciudades/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            tbCiudades tbCiudades = db.tbCiudades.Find(id);
            if (tbCiudades == null)
            {
                return HttpNotFound();
            }
            return View(tbCiudades);
        }

        // GET: Ciudades/Create
        public ActionResult Create()
        {
            ViewBag.ciu_DeptoID = new SelectList(db.tbDepartamentos, "depto_ID", "depto_Descripcion");
            ViewBag.ciu_UsuarioCreador = new SelectList(db.tbUsuarios, "usu_ID", "usu_Usuario");
            ViewBag.ciu_UsuarioMod = new SelectList(db.tbUsuarios, "usu_ID", "usu_Usuario");
            return View();
        }

        [HttpPost]
        public ActionResult Create(string Depto, string muni)
        {
            if(Depto == "0" || muni == "")
            {
                

            }
            else
            {
                try
                {
                    if (ModelState.IsValid)
                    {
                        int DepId = Int32.Parse(Depto);
                        int Usu = Int32.Parse(UsuarioModi);
                        db.UDP_CIUDADES_INSERT(muni, DepId, Usu);
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


        public JsonResult CargarDepto()
        {
            var ddl = db.UDP_CargarDepartamentos().ToList();
            return Json(ddl, JsonRequestBehavior.AllowGet);
        }



        [HttpPost]
        public JsonResult Cargar(string ciu_ID)
        {
            var tbCargos = db.UDP_CARGAR_CIUDAD(int.Parse(ciu_ID)).ToList();
            return Json(tbCargos, JsonRequestBehavior.AllowGet);
        }

        [HttpPost, ActionName("Editores")]
        //[ValidateAntiForgeryToken]
        public ActionResult Edito(string ID, string Descripcion)

        {
            if (ModelState.IsValid)
            {
                //string id = Session["IdUsuario"].ToString();
                var Edit = db.UDP_Editar_Ciudades(int.Parse(ID), Descripcion, "1");


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
