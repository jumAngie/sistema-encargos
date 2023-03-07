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
    public class PedidosController : Controller
    {
        private DBArticulosEncargosEntities1 db = new DBArticulosEncargosEntities1();
       

        // GET: Pedidos
        public ActionResult Index()
        {if (Session.Count > 0)
            {
                if (Session["Rol_ID"].ToString() == "2")
                {
                    return RedirectToAction("Principal", "Login");
                }
                else
                {
                    var tbPedidos = db.V_INDEX_PEDIDOS;
                    return View(tbPedidos.ToList());
                }
            }
            else
            {
                return RedirectToAction("Index", "Login");
            }
        }

        // GET: Pedidos/Details/5
        public ActionResult Details(int? id)
        {
            try
            {
                if (Session["Rol_ID"].ToString() == "2")
                {
                    return RedirectToAction("Principal", "Login");
                }
                else
                {
                    if (id == null)
                    {
                        return RedirectToAction("Index");
                    }
                    tbPedidos tbPedidos = db.tbPedidos.Find(id);
                    if (tbPedidos == null)
                    {
                        return HttpNotFound(); // 404
                    }
                    return View(tbPedidos);
                }
            }
            catch (Exception)
            {
                return RedirectToAction("Index");

            }
            
        }

        // GET: Pedidos/Create
        public ActionResult Create()
        {
            //ViewBag.pedi_DireccionID = new SelectList(db.tbDirecciones, "direc_ID", "direc_DireccionExacta");
            //ViewBag.estv_Id = new SelectList(db.tbEstadoEnvios, "estv_Id", "estv_Description");
            //ViewBag.pedi_UsuarioCreador = new SelectList(db.tbUsuarios, "usu_ID", "usu_Usuario");
            //ViewBag.pedi_UsuarioMod = new SelectList(db.tbUsuarios, "usu_ID", "usu_Usuario");
            return View();
        }

        // POST: Pedidos/Create
        // Para protegerse de ataques de publicación excesiva, habilite las propiedades específicas a las que quiere enlazarse. Para obtener 
        // más detalles, vea https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        //[ValidateAntiForgeryToken]
        public ActionResult Guardar(string txtCodigo,string txtCosto, DateTime txtFecha, string encargado, string estado, string direccion)
        {
            int Usu = int.Parse(Session["UsuarioID"].ToString());
            try
            {
                if (ModelState.IsValid)
                {
                    db.UDP_PEDIDOS_INSERT(txtCodigo, int.Parse(direccion), decimal.Parse(txtCosto), int.Parse(estado), int.Parse(encargado), txtFecha, Usu);
                    db.SaveChanges();
                    return RedirectToAction("Index");
                }
            }
            catch(Exception)
            {
                return RedirectToAction("Index");
            }

            //ViewBag.pedi_DireccionID = new SelectList(db.tbDirecciones, "direc_ID", "direc_DireccionExacta");
            //ViewBag.estv_Id = new SelectList(db.tbEstadoEnvios, "estv_Id", "estv_Description");
            //ViewBag.emp_Id = new SelectList(db.tbEmpleados, "emp_Id", "emp_Name");
            return RedirectToAction("Index");
        }



        public JsonResult CargarEmpleados()
        {
            var ddl = db.UDP_CargarEmpleadosPedidos().ToList();

            return Json(ddl, JsonRequestBehavior.AllowGet);

        }



        //public JsonResult CargarDirecciones()
        //{
        //    var ddl = db.UDP_CargarDireccionPedidos().ToList();

        //    return Json(ddl, JsonRequestBehavior.AllowGet);

        //}


        public JsonResult CargarEstadoEnvio()
        {
            var ddl = db.UDP_CargarEstadoDeEnvio().ToList();

            return Json(ddl, JsonRequestBehavior.AllowGet);

        }



        public JsonResult CargarClientesCrear()
        {
            var Clientes = db.UDP_DDL_CLIENTE_PEDIDO().ToList();
            return Json(Clientes, JsonRequestBehavior.AllowGet);
            
        }

        //[HttpPost]
        public JsonResult cargarDireccionDeClienteCrear(string cliente)
        {
            var Direcciones = db.UDP_CARGAR_DIRECCIONES_PORCLIENTE_PEDIDO(int.Parse(cliente)).ToList();
            return Json(Direcciones, JsonRequestBehavior.AllowGet);
        }

        //EDITAR
        [HttpPost]
        public JsonResult CargarEmpleadosEditar(string emp)
        {
            var ddl = db.UDP_CARGAR_NOMBREEMP_PEDIDOS(int.Parse(emp)).ToList();

            return Json(ddl, JsonRequestBehavior.AllowGet);

        }

        public JsonResult CargarEncargadoEditar()
        {
            var ddl = db.UDP_CargarEmpleadosPedidosEdit().ToList();

            return Json(ddl, JsonRequestBehavior.AllowGet);

        }
        //[HttpPost]
        public JsonResult CargarClientesEditar()
        {
            var Clientes = db.UDP_DDL_CLIENTE_PEDIDO().ToList();
            return Json(Clientes, JsonRequestBehavior.AllowGet);

        }

        //[HttpPost]
        public JsonResult cargarDireccionDeClienteEditar(string client_Id)
        {
            var Direcciones = db.UDP_CARGAR_DIRECCIONES_PORCLIENTE_PEDIDO(int.Parse(client_Id)).ToList();
            return Json(Direcciones, JsonRequestBehavior.AllowGet);
        }

        public JsonResult CargarClientePorDirecEdit(string direc)
        {
            var Clie = db.UDP_CARGAR_CLIENTESPOR_PEDIDO(int.Parse(direc)).ToList();
            return Json(Clie, JsonRequestBehavior.AllowGet);
        }




        // GET: Pedidos/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            tbPedidos tbPedidos = db.tbPedidos.Find(id);
            if (tbPedidos == null)
            {
                return HttpNotFound();
            }
            //ViewBag.pedi_DireccionID = new SelectList(db.tbDirecciones, "direc_ID", "direc_DireccionExacta", tbPedidos.pedi_DireccionID);
            ViewBag.estv_Id = new SelectList(db.tbEstadoEnvios, "estv_Id", "estv_Description", tbPedidos.estv_Id);
            //ViewBag.emp_Id = new SelectList(db.tbEmpleados, "emp_Id", "emp_Nombre", tbPedidos.emp_Id);
            //ViewBag.pedi_UsuarioCreador = new SelectList(db.tbUsuarios, "usu_ID", "usu_Usuario", tbPedidos.pedi_UsuarioCreador);
            //ViewBag.pedi_UsuarioMod = new SelectList(db.tbUsuarios, "usu_ID", "usu_Usuario", tbPedidos.pedi_UsuarioMod);
            return View(tbPedidos);
        }

        // POST: Pedidos/Edit/5
        // Para protegerse de ataques de publicación excesiva, habilite las propiedades específicas a las que quiere enlazarse. Para obtener 
        // más detalles, vea https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "pedi_ID,pedi_Code,pedi_DireccionID,pedi_CostoEnvio,estv_Id,emp_Id,pedi_Fecha,pedi_UsuarioCreador,pedi_FechaCreacion,pedi_UsuarioMod,pedi_FechaMod,pedi_Estado")] tbPedidos tbPedidos)
        {
           string Usu = Session["UsuarioID"].ToString();
            ModelState.Remove("pedi_UsuarioCreador");
            ModelState.Remove("pedi_FechaCreacion");
            ModelState.Remove("pedi_FechaMod");
            ModelState.Remove("pedi_Estado");

            try
            {
                if (ModelState.IsValid)
                {
                    db.UDP_Editar_Pedidos(tbPedidos.pedi_ID, tbPedidos.pedi_Code, tbPedidos.pedi_DireccionID, tbPedidos.pedi_CostoEnvio, tbPedidos.estv_Id, tbPedidos.emp_Id, tbPedidos.pedi_Fecha, Usu).ToString();
                    return RedirectToAction("Index");
                }
            }
            catch(Exception)
            {
                return RedirectToAction("Index");
            }
           
            //ViewBag.pedi_DireccionID = new SelectList(db.tbDirecciones, "direc_ID", "direc_DireccionExacta", tbPedidos.pedi_DireccionID);
            ViewBag.estv_Id = new SelectList(db.tbEstadoEnvios, "estv_Id", "estv_Description", tbPedidos.estv_Id);
            //ViewBag.emp_Id = new SelectList(db.tbEmpleados, "emp_Id", "emp_Nombre", tbPedidos.emp_Id);
          
            return View(tbPedidos);
        }

        // GET: Pedidos/Delete/5
        public ActionResult Delete(int id)
        {
            string Usu = Session["UsuarioID"].ToString();
            db.UDP_Eliminar_Pedidos(id, Usu);
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
