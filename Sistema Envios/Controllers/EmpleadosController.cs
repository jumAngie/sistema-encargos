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
    public class EmpleadosController : Controller
    {
        private DBArticulosEncargosEntities1 db = new DBArticulosEncargosEntities1();
        public string Usu = "1";

        // GET: Empleados
        public ActionResult Index()
        {if (Session.Count > 0)
            {
                var tbEmpleadosIndex = db.V_INDEX_EMPLEADOS;
                return View(tbEmpleadosIndex.ToList());
            }
            else
            {
                return RedirectToAction("Index", "Login");
            }
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

        [HttpPost]
        public JsonResult CargarCargos()
        {
            var ddl = db.UDP_DDLCargos().ToList();
            return Json(ddl, JsonRequestBehavior.AllowGet);
        }
        // GET: Empleados/Create
        public ActionResult Create()
        {
            ViewBag.depto_ID = new SelectList(db.UDP_CargarDepartamentos(), "depto_ID", "depto_Descripcion");
            ViewBag.est_ID = new SelectList(db.UDP_CargarEstadosCiviles(), "est_ID", "est_Descripcion");
            ViewBag.carg_Id = new SelectList(db.tbCargos, "carg_Id", "carg_Description");
            return View();
        }

        // POST: Empleados/Create
        // Para protegerse de ataques de publicación excesiva, habilite las propiedades específicas a las que quiere enlazarse. Para obtener 
        // más detalles, vea https://go.microsoft.com/fwlink/?LinkId=317598.

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create(string emp_Name, string emp_Apellido, string emp_DNI, DateTime? emp_FechaNac, string ciu_ID, string depto_ID, string emp_Sexo, string carg_Id, string Id_Estado)
        {
            int UsuCrea = int.Parse(Session["UsuarioID"].ToString());
            try
            {
                if (ModelState.IsValid)
                {
                   

                    if (emp_Name    == ""){ ModelState.AddModelError("ValidacionN", "El Campo Nombre no debe estar vacio!");}
                    if (emp_Apellido  == "") { ModelState.AddModelError("ValidacionA", "El Campo Apellido no debe estar vacio!"); }
                    if (emp_DNI   == "") { ModelState.AddModelError("ValidacionD", "El Campo Identidad no debe estar vacio!"); }
                    if (emp_FechaNac == null) { ModelState.AddModelError("ValidacionF", "El Campo Fecha Nacimiento no debe estar vacio!"); }
                    if (ciu_ID  == "0") { ModelState.AddModelError("ValidacionCIU", "El Campo Ciudad no debe estar vacio!"); }
                    if (emp_Sexo == "") { ModelState.AddModelError("ValidacionSEX", "El Campo no debe estar vacio1"); }
                    if (carg_Id  == "0") { ModelState.AddModelError("ValidacionCARG", "El Campo Cargo no debe estar vacio!"); }
                    if (Id_Estado  == "0") { ModelState.AddModelError("ValidacionEST", "El Campo EStado Civil no debe estar vacio!"); }
                    if(depto_ID == "0") { ModelState.AddModelError("ValidacionDEP", "El Campo Departamento es requerido!"); }
                    if(emp_Name != "" && emp_Apellido != "" && emp_FechaNac != null && emp_DNI != "" && ciu_ID != "0" && carg_Id != "0" && Id_Estado != "0" && emp_Sexo != "" && depto_ID != "0")
                    {
                        db.UDP_EMPLEADOS_INSERT(emp_Name, emp_Apellido, emp_DNI, emp_FechaNac, Convert.ToInt32(ciu_ID), Id_Estado, emp_Sexo, Convert.ToInt32(carg_Id), UsuCrea);
                        return RedirectToAction("Index");
                        
                    }
                }
            }
            catch (Exception)
            {
                return RedirectToAction("Index");
                throw;
            }
            //ViewBag.depto_ID = new SelectList(db.UDP_CargarDepartamentos(), "depto_ID", "depto_Descripcion");
            //ViewBag.ciu_ID = new SelectList(db.tbCiudades, "ciu_ID", "ciu_Descripcion", tbEmpleados.ciu_ID);
            //ViewBag.est_ID = new SelectList(db.UDP_CargarEstadosCiviles(), "est_ID", "est_Descripcion");
            return View();
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
        public ActionResult Edit([Bind(Include = "emp_Id,emp_Name,emp_Apellido,emp_DNI,emp_FechaNac,depto_ID,ciu_ID,est_ID,emp_Sexo,carg_Id,emp_UsuarioCrea,emp_FechaCrea,emp_UsuModif,emp_FechaModif,emp_Estado")] tbEmpleados tbEmpleados)
        {

            ModelState.Remove("emp_UsuarioCrea");
            ModelState.Remove("emp_FechaCrea");
            ModelState.Remove("emp_FechaModif");
            ModelState.Remove("emp_Estado");
           

            if (ModelState.IsValid)
            {
                db.UDP_Editar_Empleados(tbEmpleados.emp_Id, tbEmpleados.emp_Name, tbEmpleados.emp_Apellido, tbEmpleados.emp_DNI, tbEmpleados.emp_FechaNac, tbEmpleados.ciu_ID, tbEmpleados.est_ID, tbEmpleados.emp_Sexo, tbEmpleados.carg_Id, Usu).ToString();
                return RedirectToAction("Index");
            }
            ViewBag.ciu_ID = new SelectList(db.tbCiudades, "ciu_ID", "ciu_Descripcion", tbEmpleados.ciu_ID);
            ViewBag.est_ID = new SelectList(db.tbEstadosCiviles, "est_ID", "est_Descripcion", tbEmpleados.est_ID);
            return View(tbEmpleados);
        }

        // GET: Empleados/Delete/5
        public ActionResult Delete(int id)
        {
            db.UDP_Eliminar_Empleados(id, Usu);
            return RedirectToAction("Index");
        }

        public JsonResult cargarDeptos()
        {
            var ddl = db.UDP_CargarDepartamentos().ToList();
            return Json(ddl, JsonRequestBehavior.AllowGet);
        }



        public JsonResult CargarMunicipios (string depto_ID)
        {
            var ddl = db.UDP_CargarCiudades(depto_ID).ToList();

            return Json(ddl, JsonRequestBehavior.AllowGet);

        }


        public JsonResult CargarEstadosCiviles()
        {
            var ddlEs = db.UDP_CargarEstadosCiviles().ToList();
            return Json(ddlEs, JsonRequestBehavior.AllowGet);
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
