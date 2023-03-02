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

        // POST: Ciudades/Create
        // Para protegerse de ataques de publicación excesiva, habilite las propiedades específicas a las que quiere enlazarse. Para obtener 
        // más detalles, vea https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "ciu_ID,ciu_Descripcion,ciu_DeptoID,ciu_UsuarioCreador,ciu_FechaCreacion,ciu_UsuarioMod,ciu_FechaMod")] tbCiudades tbCiudades)
        {
            if (ModelState.IsValid)
            {
                db.tbCiudades.Add(tbCiudades);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.ciu_DeptoID = new SelectList(db.tbDepartamentos, "depto_ID", "depto_Descripcion", tbCiudades.ciu_DeptoID);
            ViewBag.ciu_UsuarioCreador = new SelectList(db.tbUsuarios, "usu_ID", "usu_Usuario", tbCiudades.ciu_UsuarioCreador);
            ViewBag.ciu_UsuarioMod = new SelectList(db.tbUsuarios, "usu_ID", "usu_Usuario", tbCiudades.ciu_UsuarioMod);
            return View(tbCiudades);
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




        // GET: Ciudades/Edit/5
        //public ActionResult Edit(int? id)
        //{
        //    if (id == null)
        //    {
        //        return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
        //    }
        //    tbCiudades tbCiudades = db.tbCiudades.Find(id);
        //    if (tbCiudades == null)
        //    {
        //        return HttpNotFound();
        //    }
        //    ViewBag.ciu_DeptoID = new SelectList(db.tbDepartamentos, "depto_ID", "depto_Descripcion", tbCiudades.ciu_DeptoID);
        //    ViewBag.ciu_UsuarioCreador = new SelectList(db.tbUsuarios, "usu_ID", "usu_Usuario", tbCiudades.ciu_UsuarioCreador);
        //    ViewBag.ciu_UsuarioMod = new SelectList(db.tbUsuarios, "usu_ID", "usu_Usuario", tbCiudades.ciu_UsuarioMod);
        //    return View(tbCiudades);
        //}

        //// POST: Ciudades/Edit/5
        //// Para protegerse de ataques de publicación excesiva, habilite las propiedades específicas a las que quiere enlazarse. Para obtener 
        //// más detalles, vea https://go.microsoft.com/fwlink/?LinkId=317598.
        //[HttpPost]
        //[ValidateAntiForgeryToken]
        //public ActionResult Edit([Bind(Include = "ciu_ID,ciu_Descripcion,ciu_DeptoID,ciu_UsuarioCreador,ciu_FechaCreacion,ciu_UsuarioMod,ciu_FechaMod")] tbCiudades tbCiudades)
        //{

        //    ModelState.Remove("ciu_UsuarioCreador");
        //    ModelState.Remove("ciu_FechaCreacion");
        //    ModelState.Remove("ciu_FechaMod");
        //    ModelState.Remove("ciu_FechaMod");
        //    if (ModelState.IsValid)
        //    {
        //        db.UDP_Editar_Ciudades(tbCiudades.ciu_ID, tbCiudades.ciu_Descripcion, UsuarioModi).ToString();
        //        return RedirectToAction("Index");
        //    }
        //    ViewBag.ciu_DeptoID = new SelectList(db.tbDepartamentos, "depto_ID", "depto_Descripcion", tbCiudades.ciu_DeptoID);
        //    ViewBag.ciu_UsuarioCreador = new SelectList(db.tbUsuarios, "usu_ID", "usu_Usuario", tbCiudades.ciu_UsuarioCreador);
        //    ViewBag.ciu_UsuarioMod = new SelectList(db.tbUsuarios, "usu_ID", "usu_Usuario", tbCiudades.ciu_UsuarioMod);
        //    return View(tbCiudades);
        //}

        // GET: Ciudades/Delete/5
        //public ActionResult Delete(int? id)
        //{
        //    if (id == null)
        //    {
        //        return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
        //    }
        //    tbCiudades tbCiudades = db.tbCiudades.Find(id);
        //    if (tbCiudades == null)
        //    {
        //        return HttpNotFound();
        //    }
        //    return View(tbCiudades);
        //}

        //// POST: Ciudades/Delete/5
        //[HttpPost, ActionName("Delete")]
        //[ValidateAntiForgeryToken]
        //public ActionResult DeleteConfirmed(int id)
        //{
        //    tbCiudades tbCiudades = db.tbCiudades.Find(id);
        //    return RedirectToAction("Index");
        //}

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
