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
    public class ClientesController : Controller
    {
        private DBArticulosEncargosEntities1 db = new DBArticulosEncargosEntities1();
        public string Usu = "1";

        // GET: Clientes
        public ActionResult Index()
        {
            if(Session.Count > 0)
            {
                var tbClientesIndex = db.V_INDEX_CLIENTES;
                return View(tbClientesIndex.ToList());
            }
            else
            {
                return RedirectToAction("Index", "Login");
            }
            
        }

        // GET: Clientes/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            tbClientes tbClientes = db.tbClientes.Find(id);
            if (tbClientes == null)
            {
                return HttpNotFound();
            }
            return View(tbClientes);
        }

        // GET: Clientes/Create
        public ActionResult Create()
        {
            ViewBag.client_EstadoCivil = new SelectList(db.tbEstadosCiviles, "est_ID", "est_Descripcion");
            ViewBag.client_UsuarioCreador = new SelectList(db.tbUsuarios, "usu_ID", "usu_Usuario");
            ViewBag.client_UsuarioMod = new SelectList(db.tbUsuarios, "usu_ID", "usu_Usuario");
            return View();
        }

        // POST: Clientes/Create
        // Para protegerse de ataques de publicación excesiva, habilite las propiedades específicas a las que quiere enlazarse. Para obtener 
        // más detalles, vea https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "client_ID,client_Nombre,client_Identidad,client_EstadoCivil,client_Sexo,client_Telefono,client_Saldo,client_LimiteCredito,client_Descuento,client_UsuarioCreador,client_FechaCreacion,client_UsuarioMod,client_FechaMod,client_Estado")] tbClientes tbClientes)
        {
            if (ModelState.IsValid)
            {
                db.tbClientes.Add(tbClientes);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.client_EstadoCivil = new SelectList(db.tbEstadosCiviles, "est_ID", "est_Descripcion", tbClientes.client_EstadoCivil);
            ViewBag.client_UsuarioCreador = new SelectList(db.tbUsuarios, "usu_ID", "usu_Usuario", tbClientes.client_UsuarioCreador);
            ViewBag.client_UsuarioMod = new SelectList(db.tbUsuarios, "usu_ID", "usu_Usuario", tbClientes.client_UsuarioMod);
            return View(tbClientes);
        }

        // GET: Clientes/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            tbClientes tbClientes = db.tbClientes.Find(id);
            if (tbClientes == null)
            {
                return HttpNotFound();
            }
            ViewBag.client_EstadoCivil = new SelectList(db.tbEstadosCiviles, "est_ID", "est_Descripcion", tbClientes.client_EstadoCivil);
            ViewBag.client_UsuarioCreador = new SelectList(db.tbUsuarios, "usu_ID", "usu_Usuario", tbClientes.client_UsuarioCreador);
            ViewBag.client_UsuarioMod = new SelectList(db.tbUsuarios, "usu_ID", "usu_Usuario", tbClientes.client_UsuarioMod);
            return View(tbClientes);
        }

        // POST: Clientes/Edit/5
        // Para protegerse de ataques de publicación excesiva, habilite las propiedades específicas a las que quiere enlazarse. Para obtener 
        // más detalles, vea https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "client_ID,client_Nombre,client_Identidad,client_EstadoCivil,client_Sexo,client_Telefono,client_Saldo,client_LimiteCredito,client_Descuento,client_UsuarioCreador,client_FechaCreacion,client_UsuarioMod,client_FechaMod,client_Estado")] tbClientes tbClientes)
        {

            ModelState.Remove("client_UsuarioCreador");
            ModelState.Remove("client_FechaCreacion");
            ModelState.Remove("client_FechaMod");
            ModelState.Remove("client_Estado");

            if (ModelState.IsValid)
            {
                db.UDP_Editar_Clientes(tbClientes.client_ID, tbClientes.client_Nombre, tbClientes.client_Identidad, tbClientes.client_EstadoCivil, tbClientes.client_Sexo, tbClientes.client_Telefono,
                                        tbClientes.client_Saldo, tbClientes.client_LimiteCredito , tbClientes.client_Descuento, Usu).ToString();
                return RedirectToAction("Index");
            }
            ViewBag.client_EstadoCivil = new SelectList(db.tbEstadosCiviles, "est_ID", "est_Descripcion", tbClientes.client_EstadoCivil);
            ViewBag.client_UsuarioCreador = new SelectList(db.tbUsuarios, "usu_ID", "usu_Usuario", tbClientes.client_UsuarioCreador);
            ViewBag.client_UsuarioMod = new SelectList(db.tbUsuarios, "usu_ID", "usu_Usuario", tbClientes.client_UsuarioMod);
            return View(tbClientes);
        }

        // GET: Clientes/Delete/
        public ActionResult Delete(int id)
        {
            string UsuModi = "1";
            db.UDP_Eliminar_Cliente(id, UsuModi);
            return RedirectToAction("Index");
        }

        //[HttpPost]
        //public ActionResult InsertarDetalles(string id, string txtArticulo, string txtCant)
        ////{
        //    db.UDP_InsertarDetalle(id, Int32.Parse(txtArticulo), Int32.Parse(txtCant), "1");
        //    return RedirectToAction("Index");
        //}

        public ActionResult PedidosPorCliente(string id)
        {
            if (id == "")
            {
                return RedirectToAction("Index");
            }
            else
            {
                try
                {
                    var pedidos = db.UDF_PedidosPorCliente(Int32.Parse(id)).AsEnumerable();
                    return View(pedidos);
                }
                catch (Exception)
                {

                    return RedirectToAction("Index");
                }
            }
        }

        [HttpGet]
        public ActionResult ObtenerDatosTabla(string id)
        {
            if (id != null)
            {
                try
                {
                    using (var db = new DBArticulosEncargosEntities1())
                    {
                        var listaDatos = db.UDF_ArticulosPorPedido(id).ToList();
                        return Json(listaDatos, JsonRequestBehavior.AllowGet);
                    }

                }
                catch (Exception)
                {

                    return RedirectToAction("Index");
                }
            }
            else
            {
                return RedirectToAction("Index");
            }
            
            
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
