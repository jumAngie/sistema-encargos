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
        // GET: Ciudades
        public ActionResult Index()
        {
            if (Session.Count > 0)
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
            try
            {
                if (id == null)
                {
                    return RedirectToAction("Index");
                }
                tbCiudades tbCiudades = db.tbCiudades.Find(id);
                if (tbCiudades == null)
                {
                    return HttpNotFound(); // pagina 404
                }
                return View(tbCiudades);
            }
            catch (Exception)
            {

                return RedirectToAction("Index"); // pagina 404
            }
            
        }

        [HttpPost]
        public ActionResult Create(string Depto, string muni)
        {
                try
                {
                    if (ModelState.IsValid)
                    {
                        int DepId = Int32.Parse(Depto);
                        int Usu = Int32.Parse(Session["UsuarioID"].ToString());
                        db.UDP_CIUDADES_INSERT(muni, DepId, Usu);
                        //TempData["Mensaje"] = "El registro se ha guardado correctamente.";
                        return RedirectToAction("Index");
                    }
                    else
                    {
                        //TempData["Mensaje"] = "El registro no se ha guardado.";
                        return RedirectToAction("Index");

                    }
                }
                catch (Exception)
                {
                    //TempData["Mensaje"] = "El registro no se ha guardado.";
                    return RedirectToAction("Index"); // pagina 404
                }
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
        public ActionResult Edito(string ID, string Descripcion, string Departamento)

        {
            string usuario = Session["UsuarioID"].ToString();
            try
            {
                if (ModelState.IsValid)
                {
                    if (Descripcion != "" && Descripcion != null)
                    { 
                        var Edit = db.UDP_Editar_Ciudades(int.Parse(ID), Descripcion,int.Parse(Departamento) ,usuario);
                        //TempData["Mensaje"] = "El registro se ha guardado correctamente.";
                        return RedirectToAction("Index");
                    }
                    else
                    {
                        //TempData["Mensaje"] = "El registro no se ha guardado.";
                        return RedirectToAction("Index"); // pagina 404
                    }
                }

            }
            catch (Exception)
            {
                //TempData["Mensaje"] = "El registro no se ha guardado.";
                return RedirectToAction("Index"); // pagina 404
            }
            return RedirectToAction("Index");

        }

        //[HttpPost]
        public JsonResult CargarDeptosEdit()
        {
            var dep = db.UDP_CARGAR_DEPA_CIUDADES().ToList();
            return Json(dep, JsonRequestBehavior.AllowGet);
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

