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
    public class DireccionesController : Controller
    {
        private DBArticulosEncargosEntities1 db = new DBArticulosEncargosEntities1();
        public string Usu = "1";

        // GET: Direcciones
        public ActionResult Index()
        {
            var tbDireccionesIndex = db.V_INDEX_DIRECCIONES;
            return View(tbDireccionesIndex.ToList());
        }

        // GET: Direcciones/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            tbDirecciones tbDirecciones = db.tbDirecciones.Find(id);
            if (tbDirecciones == null)
            {
                return HttpNotFound();
            }
            return View(tbDirecciones);
        }

        // GET: Direcciones/Create
        public ActionResult Create()
        {
            ViewBag.direc_CiudadID = new SelectList(db.tbCiudades, "ciu_ID", "ciu_Descripcion");
            ViewBag.direc_ClienteID = new SelectList(db.tbClientes, "client_ID", "client_Nombre");
            ViewBag.direc_UsuarioCreador = new SelectList(db.tbUsuarios, "usu_ID", "usu_Usuario");
            ViewBag.direc_UsuarioMod = new SelectList(db.tbUsuarios, "usu_ID", "usu_Usuario");
            return View();
        }

        // POST: Direcciones/Create
        // Para protegerse de ataques de publicación excesiva, habilite las propiedades específicas a las que quiere enlazarse. Para obtener 
        // más detalles, vea https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        //[ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "direc_ID,direc_ClienteID,direc_DireccionExacta,direc_CiudadID,direc_UsuarioCreador,direc_FechaCreacion,direc_UsuarioMod,direc_FechaMod,direc_Estado")] tbDirecciones tbDirecciones)
        {
            // AÑADIR UN MODEL STATE ERROR Y LLENARLO EN EL MODAL
            if (ModelState.IsValid)
            {
                db.tbDirecciones.Add(tbDirecciones);
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            //ViewBag.direc_CiudadID = new SelectList(db.tbCiudades, "ciu_ID", "ciu_Descripcion", tbDirecciones.direc_CiudadID);
            //ViewBag.direc_ClienteID = new SelectList(db.tbClientes, "client_ID", "client_Nombre", tbDirecciones.direc_ClienteID);
            //ViewBag.direc_UsuarioCreador = new SelectList(db.tbUsuarios, "usu_ID", "usu_Usuario", tbDirecciones.direc_UsuarioCreador);
            //ViewBag.direc_UsuarioMod = new SelectList(db.tbUsuarios, "usu_ID", "usu_Usuario", tbDirecciones.direc_UsuarioMod);
            return View();
        }


        public JsonResult CargarClienteEdit()
        {
            var ddlC = db.UDP_CARGARCLIENTES_DIRECCIONESEdit().ToList();

            return Json(ddlC, JsonRequestBehavior.AllowGet);

        }


        public JsonResult CargarDepartamentosEdit()
        {
            var ddlD = db.UDP_CARGARDEPTOS_DIRECCIONEDIT().ToList();

            return Json(ddlD, JsonRequestBehavior.AllowGet);

        }





        public JsonResult CargarMunicipiosEdit()
        {
            var ddlM = db.UDP_CARGAR_MUNICIPIO().ToList();

            return Json(ddlM, JsonRequestBehavior.AllowGet);

        }

        //[HttpPost]
        //public JsonResult CargarMunicipiosDEPA(string depto)
        //{
        //    var ddlMM= db.UDP_CargarCiudades(depto).ToList();

        //    return Json(ddlMM, JsonRequestBehavior.AllowGet);

        //}



        //[HttpPost]

        //public JsonResult CargarMunicipiosEdit(int dep_ID)
        //{
        //    var ddlM = db.UDP_CARGARCIIUDAD_DIRECCONEDIT(dep_ID).ToList();

        //    return Json(ddlM, JsonRequestBehavior.AllowGet);

        //}




        [HttpPost]
        public JsonResult Cargar(string direc_ID)
        {


            var direc= db.UDP_CARGAR_DIRECCIONESEdit(int.Parse(direc_ID)).ToList();

            return Json(direc, JsonRequestBehavior.AllowGet);
        }




        [HttpPost, ActionName("Editores")]
        //[ValidateAntiForgeryToken]
        public ActionResult Edito(string ID, string cliente, string ciudad, string direccion)

        {
            if (ModelState.IsValid)
            {
                try
                {
                    if (cliente != "" || ciudad != "" || direccion != "")
                    {
                        //string id = Session["IdUsuario"].ToString();
                        var Edit = db.UDP_Editar_Direcciones(int.Parse(ID), int.Parse(cliente), direccion, int.Parse(ciudad), "1");
                        
                    }
                }
                catch(Exception)
                {
                    return RedirectToAction("Index");
                }
            }

            return RedirectToAction("Index");
        }




        //// GET: Direcciones/Edit/5
        //public ActionResult Edit(int? id)
        //{
        //    if (id == null)
        //    {
        //        return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
        //    }
        //    tbDirecciones tbDirecciones = db.tbDirecciones.Find(id);
        //    if (tbDirecciones == null)
        //    {
        //        return HttpNotFound();
        //    }
        //    ViewBag.direc_CiudadID = new SelectList(db.tbCiudades, "ciu_ID", "ciu_Descripcion", tbDirecciones.direc_CiudadID);
        //    ViewBag.direc_ClienteID = new SelectList(db.tbClientes, "client_ID", "client_Nombre", tbDirecciones.direc_ClienteID);
        //    ViewBag.direc_UsuarioCreador = new SelectList(db.tbUsuarios, "usu_ID", "usu_Usuario", tbDirecciones.direc_UsuarioCreador);
        //    ViewBag.direc_UsuarioMod = new SelectList(db.tbUsuarios, "usu_ID", "usu_Usuario", tbDirecciones.direc_UsuarioMod);
        //    return View(tbDirecciones);
        //}

        //// POST: Direcciones/Edit/5
        //// Para protegerse de ataques de publicación excesiva, habilite las propiedades específicas a las que quiere enlazarse. Para obtener 
        //// más detalles, vea https://go.microsoft.com/fwlink/?LinkId=317598.
        //[HttpPost]
        //[ValidateAntiForgeryToken]
        //public ActionResult Edit([Bind(Include = "direc_ID,direc_ClienteID,direc_DireccionExacta,direc_CiudadID,direc_UsuarioCreador,direc_FechaCreacion,direc_UsuarioMod,direc_FechaMod,direc_Estado")] tbDirecciones tbDirecciones)
        //{
        //    // ,,direc_UsuarioMod,,
        //    ModelState.Remove("direc_UsuarioCreador");
        //    ModelState.Remove("direc_FechaCreacion");
        //    ModelState.Remove("direc_FechaMod");
        //    ModelState.Remove("direc_Estado");

        //    if (ModelState.IsValid)
        //    {
        //        db.UDP_Editar_Direcciones(tbDirecciones.direc_ID, tbDirecciones.direc_ClienteID, tbDirecciones.direc_DireccionExacta, tbDirecciones.direc_CiudadID, Usu).ToString();
        //        return RedirectToAction("Index");
        //    }
        //    ViewBag.direc_CiudadID = new SelectList(db.tbCiudades, "ciu_ID", "ciu_Descripcion", tbDirecciones.direc_CiudadID);
        //    ViewBag.direc_ClienteID = new SelectList(db.tbClientes, "client_ID", "client_Nombre", tbDirecciones.direc_ClienteID);
        //    ViewBag.direc_UsuarioCreador = new SelectList(db.tbUsuarios, "usu_ID", "usu_Usuario", tbDirecciones.direc_UsuarioCreador);
        //    ViewBag.direc_UsuarioMod = new SelectList(db.tbUsuarios, "usu_ID", "usu_Usuario", tbDirecciones.direc_UsuarioMod);
        //    return View(tbDirecciones);
        //}

        // GET: Direcciones/Delete/5
        public ActionResult Delete(int id)
        {
            db.UDP_Eliminar_Direcciones(id, Usu);
            return RedirectToAction("Index");
        }

        public JsonResult CargarCliente()
        {
            var ddl = db.UDP_CargarCliente().ToList();

            return Json(ddl, JsonRequestBehavior.AllowGet);

        }


        public JsonResult CargarDepartamentos()
        {
            var ddl = db.UDP_CargarDepartamentos().ToList();

            return Json(ddl, JsonRequestBehavior.AllowGet);

        }

        public JsonResult CargarMunicipios(string dep_ID)
        {
            var ddl = db.UDP_CargarCiudades(dep_ID).ToList();

            return Json(ddl, JsonRequestBehavior.AllowGet);

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
