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
    public class DepartamentosController : Controller
    {
        private DBArticulosEncargosEntities db = new DBArticulosEncargosEntities();

        // GET: Departamentos
        public ActionResult Index()
        {
            var tbDepartamentos = db.tbDepartamentos.Include(t => t.tbUsuarios).Include(t => t.tbUsuarios1);
            return View(tbDepartamentos.ToList());
        }

        // GET: Departamentos/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            tbDepartamentos tbDepartamentos = db.tbDepartamentos.Find(id);
            if (tbDepartamentos == null)
            {
                return HttpNotFound();
            }
            return View(tbDepartamentos);
        }

        // GET: Departamentos/Create
        public ActionResult Create()
        {
            ViewBag.usu_UsuarioCreador = new SelectList(db.tbUsuarios, "usu_ID", "usu_Usuario");
            ViewBag.usu_UsuarioMod = new SelectList(db.tbUsuarios, "usu_ID", "usu_Usuario");
            return View();
        }

        // POST: Departamentos/Create
        // Para protegerse de ataques de publicación excesiva, habilite las propiedades específicas a las que quiere enlazarse. Para obtener 
        // más detalles, vea https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "depto_ID,depto_Descripcion,usu_UsuarioCreador,usu_FechaCreacion,usu_UsuarioMod,depto_FechaMod")] tbDepartamentos tbDepartamentos)
        {
            if (ModelState.IsValid)
            {
                db.tbDepartamentos.Add(tbDepartamentos);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.usu_UsuarioCreador = new SelectList(db.tbUsuarios, "usu_ID", "usu_Usuario", tbDepartamentos.usu_UsuarioCreador);
            ViewBag.usu_UsuarioMod = new SelectList(db.tbUsuarios, "usu_ID", "usu_Usuario", tbDepartamentos.usu_UsuarioMod);
            return View(tbDepartamentos);
        }

        // GET: Departamentos/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            tbDepartamentos tbDepartamentos = db.tbDepartamentos.Find(id);
            if (tbDepartamentos == null)
            {
                return HttpNotFound();
            }
            ViewBag.usu_UsuarioCreador = new SelectList(db.tbUsuarios, "usu_ID", "usu_Usuario", tbDepartamentos.usu_UsuarioCreador);
            ViewBag.usu_UsuarioMod = new SelectList(db.tbUsuarios, "usu_ID", "usu_Usuario", tbDepartamentos.usu_UsuarioMod);
            return View(tbDepartamentos);
        }

        // POST: Departamentos/Edit/5
        // Para protegerse de ataques de publicación excesiva, habilite las propiedades específicas a las que quiere enlazarse. Para obtener 
        // más detalles, vea https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "depto_ID,depto_Descripcion,usu_UsuarioCreador,usu_FechaCreacion,usu_UsuarioMod,depto_FechaMod")] tbDepartamentos tbDepartamentos)
        {
            if (ModelState.IsValid)
            {
                db.Entry(tbDepartamentos).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.usu_UsuarioCreador = new SelectList(db.tbUsuarios, "usu_ID", "usu_Usuario", tbDepartamentos.usu_UsuarioCreador);
            ViewBag.usu_UsuarioMod = new SelectList(db.tbUsuarios, "usu_ID", "usu_Usuario", tbDepartamentos.usu_UsuarioMod);
            return View(tbDepartamentos);
        }

        // GET: Departamentos/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            tbDepartamentos tbDepartamentos = db.tbDepartamentos.Find(id);
            if (tbDepartamentos == null)
            {
                return HttpNotFound();
            }
            return View(tbDepartamentos);
        }

        // POST: Departamentos/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            tbDepartamentos tbDepartamentos = db.tbDepartamentos.Find(id);
            db.tbDepartamentos.Remove(tbDepartamentos);
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
