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
    public class CargosController : Controller
    {
        private DBArticulosEncargosEntities1 db = new DBArticulosEncargosEntities1();
        public string UsuarioModi = "1";

        // GET: Cargos
        public ActionResult Index()
        {
            var tbCargosIndex = db.V_INDEX_CARGOS;
            return View(tbCargosIndex.ToList());
        }

        // GET: Cargos/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            tbCargos tbCargos = db.tbCargos.Find(id);
            if (tbCargos == null)
            {
                return HttpNotFound();
            }
            return View(tbCargos);
        }

        // GET: Cargos/Create
        public ActionResult Create()
        {
            ViewBag.rep_UsuarioCreador = new SelectList(db.tbUsuarios, "usu_ID", "usu_Usuario");
            ViewBag.rep_UsuarioMod = new SelectList(db.tbUsuarios, "usu_ID", "usu_Usuario");
            return View();
        }

        // POST: Cargos/Create
        // Para protegerse de ataques de publicación excesiva, habilite las propiedades específicas a las que quiere enlazarse. Para obtener 
        // más detalles, vea https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        //[ValidateAntiForgeryToken]
        public ActionResult Create(string txtCargo)
        { 
            int UsuarioModi = 1;

            if (ModelState.IsValid)
            {
                db.UDP_CARGOS_INSERT(txtCargo, UsuarioModi);
                return RedirectToAction("Index");
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
        //[ValidateAntiForgeryToken]
        public ActionResult Edito(string ID, string Descripcion)

        {
            if (ModelState.IsValid)
            {
                //string id = Session["IdUsuario"].ToString();
                var Edit = db.UDP_Editar_Cargos(int.Parse(ID),Descripcion, "1");


                return RedirectToAction("Index");


            }

            return RedirectToAction("Index");
        }






        // GET: Cargos/Edit/5
        //public ActionResult Edit(int? id)
        //{
        //    if (id == null)
        //    {
        //        return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
        //    }
        //    tbCargos tbCargos = db.tbCargos.Find(id);
        //    if (tbCargos == null)
        //    {
        //        return HttpNotFound();
        //    }
        //    ViewBag.rep_UsuarioCreador = new SelectList(db.tbUsuarios, "usu_ID", "usu_Usuario", tbCargos.rep_UsuarioCreador);
        //    ViewBag.rep_UsuarioMod = new SelectList(db.tbUsuarios, "usu_ID", "usu_Usuario", tbCargos.rep_UsuarioMod);
        //    return View(tbCargos);
        //}

        //// POST: Cargos/Edit/5
        //// Para protegerse de ataques de publicación excesiva, habilite las propiedades específicas a las que quiere enlazarse. Para obtener 
        //// más detalles, vea https://go.microsoft.com/fwlink/?LinkId=317598.
        //[HttpPost]
        //[ValidateAntiForgeryToken]
        //public ActionResult Edit([Bind(Include = "carg_Id,carg_Description,rep_UsuarioCreador,rep_FechaCreacion,rep_UsuarioMod,rep_FechaMod,rep_Estado")] tbCargos tbCargos)
        //{
        //    ModelState.Remove("rep_UsuarioCreador");
        //    ModelState.Remove("rep_FechaCreacion");
        //    ModelState.Remove("rep_FechaMod");
        //    ModelState.Remove("rep_Estado");

        //    if (ModelState.IsValid)
        //    {
        //        db.UDP_Editar_Cargos(tbCargos.carg_Id, tbCargos.carg_Description, UsuarioModi);
        //        return RedirectToAction("Index");
        //    }
        //    ViewBag.rep_UsuarioCreador = new SelectList(db.tbUsuarios, "usu_ID", "usu_Usuario", tbCargos.rep_UsuarioCreador);
        //    ViewBag.rep_UsuarioMod = new SelectList(db.tbUsuarios, "usu_ID", "usu_Usuario", tbCargos.rep_UsuarioMod);
        //    return View(tbCargos);
        //}

        // GET: Cargos/Delete/5
        public ActionResult Delete(int id)
        {
            db.UDP_Eliminar_Cargos(id, UsuarioModi);
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


