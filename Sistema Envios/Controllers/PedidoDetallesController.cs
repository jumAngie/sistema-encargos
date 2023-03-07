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
                if (Session["Rol_ID"].ToString() == "2")
                {
                    return RedirectToAction("Principal", "Login");
                }
                else
                {
                    var tbPedidoDetallesIndex = db.V_INDEX_PEDIDOS_DETALLES;
                    return View(tbPedidoDetallesIndex.ToList());
                }
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
                    tbPedidoDetalles tbPedidoDetalles = db.tbPedidoDetalles.Find(id);
                    if (tbPedidoDetalles == null)
                    {
                        return HttpNotFound(); // página 404
                    }
                    return View(tbPedidoDetalles);
                }
            }
            catch (Exception)
            {

                return RedirectToAction("Index");
            }
            
        }

        [HttpPost]
        public JsonResult CARGARCODIGOS()
        {
            var Codigos = db.UDP_CARGARCODIGOSDet().ToList();

            return Json(Codigos, JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public JsonResult CARGARARTICULOSdet()
        {
            var Articulos = db.UDP_CARGARARTICULOSDet().ToList();

            return Json(Articulos, JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public JsonResult Cargar(string det_ID)
        {

            var tbArticulos = db.UDP_CARGARDETALLE(int.Parse(det_ID)).ToList();
            return Json(tbArticulos, JsonRequestBehavior.AllowGet);

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

        [HttpPost, ActionName("Editores")]
     
        public ActionResult Edito(string det_ID, string txtCantid, string txtArticuloID, string txtPedidoCode)

        {
            try
            {
                
                if (ModelState.IsValid)
                {
                    if (txtCantid != "")
                    {
                        string UsuarioModi = Session["UsuarioID"].ToString();
                        var Edit = db.UDP_Editar_PedidosDetalles(int.Parse(det_ID), int.Parse(txtPedidoCode), int.Parse(txtArticuloID), int.Parse(txtCantid), UsuarioModi);

                    }

                }
                else
                {
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
