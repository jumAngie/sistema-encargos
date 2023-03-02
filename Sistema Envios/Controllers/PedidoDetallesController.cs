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
        public string Usu = "1";

        // GET: PedidoDetalles
        public ActionResult Index()
        {if (Session.Count > 0)
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
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            tbPedidoDetalles tbPedidoDetalles = db.tbPedidoDetalles.Find(id);
            if (tbPedidoDetalles == null)
            {
                return HttpNotFound();
            }
            return View(tbPedidoDetalles);
        }

        // GET: PedidoDetalles/Create
        public ActionResult Create()
        {
            ViewBag.pedi_ID = new SelectList(db.tbPedidos, "pedi_ID", "pedi_Code");
            ViewBag.det_UsuarioCrea = new SelectList(db.tbUsuarios, "usu_ID", "usu_Usuario");
            ViewBag.det_UsuModif = new SelectList(db.tbUsuarios, "usu_ID", "usu_Usuario");
            return View();
        }

        // POST: PedidoDetalles/Create
        // Para protegerse de ataques de publicación excesiva, habilite las propiedades específicas a las que quiere enlazarse. Para obtener 
        // más detalles, vea https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        //[ValidateAntiForgeryToken]
        public ActionResult Create(string txtPedi, string txtArticulo, string txtCant)
        {
            if (txtPedi == "0")
            {
                
                ModelState.AddModelError("Vacio", "El campo es obligatorio.");
            }
            else
            {
                int Usuario = 1;
                int Pedi = Int32.Parse(txtPedi);
                int Articulo = Int32.Parse(txtArticulo);
                int Cantidad = Int32.Parse(txtCant);
                if (ModelState.IsValid)
                {
                    try
                    {
                        db.UDP_PEDIDO_DETALLE(Pedi, Articulo, Cantidad, Usuario);
                        return RedirectToAction("Index");
                    }
                    catch (Exception)
                    {
                        return RedirectToAction("Index");
                    }
                    
                }
                return View();
            }
            return View();
        }


        // GET: PedidoDetalles/Delete/5
        public ActionResult Delete(int id)
        {
            db.UDP_Eliminar_PedidosDetalles(id, Usu);
            return RedirectToAction("Index");
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
