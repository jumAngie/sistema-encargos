﻿using System;
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
        public string Usu = "1";

        // GET: Fabricas
        public ActionResult Index()
        {
            var tbFabricasIndex = db.V_INDEX_FABRICAS;
            return View(tbFabricasIndex.ToList());
        }

        // GET: Fabricas/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            tbFabricas tbFabricas = db.tbFabricas.Find(id);
            if (tbFabricas == null)
            {
                return HttpNotFound();
            }
            return View(tbFabricas);
        }

        // GET: Fabricas/Create
        public ActionResult Create()
        {
            ViewBag.fab_UsuarioCreador = new SelectList(db.tbUsuarios, "usu_ID", "usu_Usuario");
            ViewBag.fab_UsuarioMod = new SelectList(db.tbUsuarios, "usu_ID", "usu_Usuario");
            return View();
        }

        // POST: Fabricas/Create
        // Para protegerse de ataques de publicación excesiva, habilite las propiedades específicas a las que quiere enlazarse. Para obtener 
        // más detalles, vea https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        //[ValidateAntiForgeryToken]
        public ActionResult Create(string txtFabrica, string txtTelefono)
        {   int UsuarioModi = 1;
            if (ModelState.IsValid)
            {
                db.UDP_InsertFabrica(txtFabrica, txtTelefono, UsuarioModi);
                return RedirectToAction("Index");
            }

            return View();
        }


        [HttpPost]
        public JsonResult Cargar(string fab_ID)
        {
            var tbEstadosCiviles1 = db.UDP_CARGARDATOS_FABRICA(int.Parse(fab_ID)).ToList();
            return Json(tbEstadosCiviles1, JsonRequestBehavior.AllowGet);
        }





        [HttpPost, ActionName("Editores")]
        //[ValidateAntiForgeryToken]
        public ActionResult Edito(string ID, string Descripcion, string telefono)

        {
            if (ModelState.IsValid)
            {
                if (Descripcion != "" && telefono != "")
                {
                    ModelState.AddModelError("Validacion", "Los campos no deben estar vacios");


                    //string id = Session["IdUsuario"].ToString();
                    var Edit = db.UDP_Editar_Fabricas(int.Parse(ID), Descripcion, telefono, "1");


                    return RedirectToAction("Index");
                }

            }

            return RedirectToAction("Index");
        }

        // GET: Fabricas/Edit/5
        //public ActionResult Edit(int? id)
        //{
        //    if (id == null)
        //    {
        //        return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
        //    }
        //    tbFabricas tbFabricas = db.tbFabricas.Find(id);
        //    if (tbFabricas == null)
        //    {
        //        return HttpNotFound();
        //    }
        //    ViewBag.fab_UsuarioCreador = new SelectList(db.tbUsuarios, "usu_ID", "usu_Usuario", tbFabricas.fab_UsuarioCreador);
        //    ViewBag.fab_UsuarioMod = new SelectList(db.tbUsuarios, "usu_ID", "usu_Usuario", tbFabricas.fab_UsuarioMod);
        //    return View(tbFabricas);
        //}

        //// POST: Fabricas/Edit/5
        //// Para protegerse de ataques de publicación excesiva, habilite las propiedades específicas a las que quiere enlazarse. Para obtener 
        //// más detalles, vea https://go.microsoft.com/fwlink/?LinkId=317598.
        //[HttpPost]
        //[ValidateAntiForgeryToken]
        //public ActionResult Edit([Bind(Include = "fab_ID,fab_Descripcion,fab_Telefono,fab_UsuarioCreador,fab_FechaCreacion,fab_UsuarioMod,fab_FechaMod,fab_Estado")] tbFabricas tbFabricas)
        //{

        //    ModelState.Remove("fab_UsuarioCreador");
        //    ModelState.Remove(",fab_FechaCreacion");
        //    ModelState.Remove("fab_FechaMod");
        //    ModelState.Remove("fab_Estado");

        //    if (ModelState.IsValid)
        //    {
        //        db.UDP_Editar_Fabricas(tbFabricas.fab_ID, tbFabricas.fab_Descripcion, tbFabricas.fab_Telefono, Usu).ToString();
        //        return RedirectToAction("Index");
        //    }
        //    ViewBag.fab_UsuarioCreador = new SelectList(db.tbUsuarios, "usu_ID", "usu_Usuario", tbFabricas.fab_UsuarioCreador);
        //    ViewBag.fab_UsuarioMod = new SelectList(db.tbUsuarios, "usu_ID", "usu_Usuario", tbFabricas.fab_UsuarioMod);
        //    return View(tbFabricas);
        //}

        // GET: Fabricas/Delete/5
        public ActionResult Delete(int id)
        {
            db.UDP_Eliminar_Fabricas(id, Usu);
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
