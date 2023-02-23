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
    public class EmpleadosController : Controller
    {
        private DBArticulosEncargosEntities db = new DBArticulosEncargosEntities();

        // GET: Empleados
        public ActionResult Index()
        {
            var tbEmpleados = db.tbEmpleados.Include(t => t.tbCiudades).Include(t => t.tbEstadosCiviles);
            return View(tbEmpleados.ToList());
        }

        // GET: Empleados/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            tbEmpleados tbEmpleados = db.tbEmpleados.Find(id);
            if (tbEmpleados == null)
            {
                return HttpNotFound();
            }
            return View(tbEmpleados);
        }

        // GET: Empleados/Create
        public ActionResult Create()
        {
            ViewBag.ciu_ID = new SelectList(db.tbCiudades, "ciu_ID", "ciu_Descripcion");
            ViewBag.est_ID = new SelectList(db.tbEstadosCiviles, "est_ID", "est_Descripcion");
            return View();
        }

        // POST: Empleados/Create
        // Para protegerse de ataques de publicación excesiva, habilite las propiedades específicas a las que quiere enlazarse. Para obtener 
        // más detalles, vea https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "emp_Id,emp_Name,emp_Apellido,emp_DNI,emp_FechaNac,ciu_ID,est_ID,emp_Sexo,carg_Id,emp_UsuarioCrea,emp_FechaCrea,emp_UsuModif,emp_FechaModif,emp_Estado")] tbEmpleados tbEmpleados)
        {
            if (ModelState.IsValid)
            {
                db.tbEmpleados.Add(tbEmpleados);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.ciu_ID = new SelectList(db.tbCiudades, "ciu_ID", "ciu_Descripcion", tbEmpleados.ciu_ID);
            ViewBag.est_ID = new SelectList(db.tbEstadosCiviles, "est_ID", "est_Descripcion", tbEmpleados.est_ID);
            return View(tbEmpleados);
        }

        // GET: Empleados/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            tbEmpleados tbEmpleados = db.tbEmpleados.Find(id);
            if (tbEmpleados == null)
            {
                return HttpNotFound();
            }
            ViewBag.ciu_ID = new SelectList(db.tbCiudades, "ciu_ID", "ciu_Descripcion", tbEmpleados.ciu_ID);
            ViewBag.est_ID = new SelectList(db.tbEstadosCiviles, "est_ID", "est_Descripcion", tbEmpleados.est_ID);
            return View(tbEmpleados);
        }

        // POST: Empleados/Edit/5
        // Para protegerse de ataques de publicación excesiva, habilite las propiedades específicas a las que quiere enlazarse. Para obtener 
        // más detalles, vea https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "emp_Id,emp_Name,emp_Apellido,emp_DNI,emp_FechaNac,ciu_ID,est_ID,emp_Sexo,carg_Id,emp_UsuarioCrea,emp_FechaCrea,emp_UsuModif,emp_FechaModif,emp_Estado")] tbEmpleados tbEmpleados)
        {
            if (ModelState.IsValid)
            {
                db.Entry(tbEmpleados).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.ciu_ID = new SelectList(db.tbCiudades, "ciu_ID", "ciu_Descripcion", tbEmpleados.ciu_ID);
            ViewBag.est_ID = new SelectList(db.tbEstadosCiviles, "est_ID", "est_Descripcion", tbEmpleados.est_ID);
            return View(tbEmpleados);
        }

        // GET: Empleados/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            tbEmpleados tbEmpleados = db.tbEmpleados.Find(id);
            if (tbEmpleados == null)
            {
                return HttpNotFound();
            }
            return View(tbEmpleados);
        }

        // POST: Empleados/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            tbEmpleados tbEmpleados = db.tbEmpleados.Find(id);
            db.tbEmpleados.Remove(tbEmpleados);
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