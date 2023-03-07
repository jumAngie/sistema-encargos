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
    public class PedidoDetallesController : Controller
    {
        private DBArticulosEncargosEntities1 db = new DBArticulosEncargosEntities1();

        // GET: PedidoDetalles
        public ActionResult Index()
        {   if (Session.Count > 0)
            {
                var tbPedidoDetallesIndex = db.V_INDEX_PEDIDOS_DETALLES;
                return View(tbPedidoDetallesIndex.ToList());
            }
            else
            {
                return RedirectToAction("Index", "Login");
            }
        }

        // GET: PedidoDetalles/Details/5
        public ActionResult Details(int? id)
        {
            try
            {
                if (id == null)
                {
                    return RedirectToAction("Index");
                }
                tbPedidoDetalles tbPedidoDetalles = db.tbPedidoDetalles.Find(id);
                if (tbPedidoDetalles == null)
                {
                    return HttpNotFound(); // página 404
                }
                return View(tbPedidoDetalles);
            }
            catch (Exception)
            {

                return RedirectToAction("Index");
            }
            
        }

        
        [HttpPost]
       
        public ActionResult Create(string txtPedi, string txtArticulo, string txtCant)
        {

            try
            {
                if (ModelState.IsValid)
                {
                    
                    int Pedi = Int32.Parse(txtPedi);
                    int Articulo = Int32.Parse(txtArticulo);
                    int Cantidad = Int32.Parse(txtCant);
                    db.UDP_PEDIDO_DETALLE(Pedi, Articulo, Cantidad, Int32.Parse(Session["UsuarioID"].ToString()));
                    return RedirectToAction("Index");
                }
            }
            catch (Exception)
            {
                return RedirectToAction("Index");

            }

            return RedirectToAction("Index");


        }


        // GET: PedidoDetalles/Delete/5
        public ActionResult Delete(int id)
        {
            try
            {
                db.UDP_Eliminar_PedidosDetalles(id, Session["UsuarioID"].ToString());
                return RedirectToAction("Index");
            }
            catch (Exception)
            {

                return RedirectToAction("Index"); // página 404
            }
            
        }

        public JsonResult CargarPedidos()
        {
            var ddl = db.UDP_CargarPedidos().ToList();

            return Json(ddl, JsonRequestBehavior.AllowGet);

        }

        public JsonResult CargarArticulos()
        {
            var ddl = db.UDP_CargarArticulos().ToList();

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
