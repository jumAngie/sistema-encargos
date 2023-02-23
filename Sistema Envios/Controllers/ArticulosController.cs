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
    public class ArticulosController : Controller
    {
        private DBArticulosEncargosEntities db = new DBArticulosEncargosEntities();

        // GET: Articulos
        public ActionResult Index()
        {
            var tbArticulos = db.tbArticulos.Include(t => t.tbFabricas).Include(t => t.tbUsuarios).Include(t => t.tbUsuarios1);
            return View(tbArticulos.ToList());
        }

        // GET: Articulos/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            tbArticulos tbArticulos = db.tbArticulos.Find(id);
            if (tbArticulos == null)
            {
                return HttpNotFound();
            }
            return View(tbArticulos);
        }

        // GET: Articulos/Create
        public ActionResult Create()
        {
            ViewBag.fab_ID = new SelectList(db.tbFabricas, "fab_ID", "fab_Descripcion");
            ViewBag.art_UsuarioCreador = new SelectList(db.tbUsuarios, "usu_ID", "usu_Usuario");
            ViewBag.art_UsuarioMod = new SelectList(db.tbUsuarios, "usu_ID", "usu_Usuario");
            return View();
        }

        // POST: Articulos/Create
        // Para protegerse de ataques de publicación excesiva, habilite las propiedades específicas a las que quiere enlazarse. Para obtener 
        // más detalles, vea https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "art_ID,art_Descripcion,fab_ID,art_Stock,art_UsuarioCreador,art_FechaCreacion,art_UsuarioMod,art_FechaMod,art_Estado")] tbArticulos tbArticulos)
        {
            if (ModelState.IsValid)
            {
                db.tbArticulos.Add(tbArticulos);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.fab_ID = new SelectList(db.tbFabricas, "fab_ID", "fab_Descripcion", tbArticulos.fab_ID);
            ViewBag.art_UsuarioCreador = new SelectList(db.tbUsuarios, "usu_ID", "usu_Usuario", tbArticulos.art_UsuarioCreador);
            ViewBag.art_UsuarioMod = new SelectList(db.tbUsuarios, "usu_ID", "usu_Usuario", tbArticulos.art_UsuarioMod);
            return View(tbArticulos);
        }

        // GET: Articulos/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            tbArticulos tbArticulos = db.tbArticulos.Find(id);
            if (tbArticulos == null)
            {
                return HttpNotFound();
            }
            ViewBag.fab_ID = new SelectList(db.tbFabricas, "fab_ID", "fab_Descripcion", tbArticulos.fab_ID);
            ViewBag.art_UsuarioCreador = new SelectList(db.tbUsuarios, "usu_ID", "usu_Usuario", tbArticulos.art_UsuarioCreador);
            ViewBag.art_UsuarioMod = new SelectList(db.tbUsuarios, "usu_ID", "usu_Usuario", tbArticulos.art_UsuarioMod);
            return View(tbArticulos);
        }

        // POST: Articulos/Edit/5
        // Para protegerse de ataques de publicación excesiva, habilite las propiedades específicas a las que quiere enlazarse. Para obtener 
        // más detalles, vea https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "art_ID,art_Descripcion,fab_ID,art_Stock,art_UsuarioCreador,art_FechaCreacion,art_UsuarioMod,art_FechaMod,art_Estado")] tbArticulos tbArticulos)
        {
            if (ModelState.IsValid)
            {
                db.Entry(tbArticulos).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.fab_ID = new SelectList(db.tbFabricas, "fab_ID", "fab_Descripcion", tbArticulos.fab_ID);
            ViewBag.art_UsuarioCreador = new SelectList(db.tbUsuarios, "usu_ID", "usu_Usuario", tbArticulos.art_UsuarioCreador);
            ViewBag.art_UsuarioMod = new SelectList(db.tbUsuarios, "usu_ID", "usu_Usuario", tbArticulos.art_UsuarioMod);
            return View(tbArticulos);
        }

        // GET: Articulos/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            tbArticulos tbArticulos = db.tbArticulos.Find(id);
            if (tbArticulos == null)
            {
                return HttpNotFound();
            }
            return View(tbArticulos);
        }

        // POST: Articulos/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            tbArticulos tbArticulos = db.tbArticulos.Find(id);
            db.tbArticulos.Remove(tbArticulos);
            db.SaveChanges();
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