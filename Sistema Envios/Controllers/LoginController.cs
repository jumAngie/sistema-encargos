using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Sistema_Envios.Models;

namespace Sistema_Envios.Controllers
{
    public class LoginController : Controller
    {
        private DBArticulosEncargosEntities1 db = new DBArticulosEncargosEntities1();
        // GET: Login
        public ActionResult Index()
        {

            return View();
            
        }
        // POST: Login
        [HttpPost]
        public ActionResult Index(string txtUsuario, string txtPass)
        {
            if (txtUsuario == "" && txtPass == "")
            {
                ModelState.AddModelError("Validacion", "Los campos no deben estar vacios");
                return View();
            }
            else
            {
                var result = db.UDP_VALIDAR_LOGIN(txtUsuario, txtPass).ToList();

                if (result.Count > 0)
                {
                    foreach (var item in result)
                    {
                        Session["Usuario"] = item.emp_Name;
                        Session["UsuarioID"] = item.usu_ID;
                        return RedirectToAction("Principal");
                    }
                }
                else
                {
                    ModelState.AddModelError("Validacion", "El usuario o la contraseña son incorrectos");
                    return View();
                }

                return RedirectToAction("Index", "Home");
            }
        }

        //public class AuthorizeAttribute : ActionFilterAttribute
        //{
        //    public override void OnActionExecuting(ActionExecutingContext filterContext)
        //    {
        //        // Aquí verificamos si el usuario ha iniciado sesión
        //        if (filterContext.HttpContext.Session["IsAuthenticated"] == null)
        //        {
        //            // Si el usuario no ha iniciado sesión, redirigimos al usuario a la página de inicio de sesión
        //            filterContext.Result = new RedirectResult("Login/Index");
        //        }

        //        base.OnActionExecuting(filterContext);
        //    }
        //}

        public ActionResult Principal()
        {
            if(Session.Count > 0)
            {
                return View();
            }
            else
            {
                return RedirectToAction("Index", "Login");
            }
            
        }

        //GET: Olvidar Contra
        public ActionResult OlvidarContraseña()
        {
            return View();
        }
        //POST: Olvidar Contra
        [HttpPost]
        public ActionResult OlvidarContraseña(string txtUsuario, string txtNewPass, string txtConfirmNewPass)
        {
            if (txtUsuario == "" || txtNewPass == "" || txtConfirmNewPass == "")
            {
                ModelState.AddModelError("Validacion2", "Los campos no deben estar vacios");
                return View();
            }
            else
            {
                if (txtNewPass != txtConfirmNewPass)
                {
                    ModelState.AddModelError("Validacion2", "La nueva contraseña no coincide con la confirmación de contraseña");
                    return View();
                }
                else
                {
                    var result = db.UDP_USUARIO_VALIDAR(txtUsuario).ToList();

                    if (result.Count > 0)
                    {
                        foreach (var item in result)
                        {
                            db.UDP_CambiarContraOlvidada(txtUsuario, txtNewPass);
                            return RedirectToAction("Index");
                        }
                    }
                    else
                    {
                        ModelState.AddModelError("Validacion2", "El usuario o la contraseña son incorrectos");
                        return View();
                    }

                    return RedirectToAction("Index");
                }
            }
        }

        //GET: Cambiar Contra
        public ActionResult CambiarContraseña()
        {
            return View();
        }
        //POST: Cambiar Contra
        [HttpPost]
        public ActionResult CambiarContraseña(string txtUsuario, string txtPass, string txtNewPass, string txtConfirmNewPass)
        {
            if (txtUsuario == "" || txtPass == "" || txtNewPass == "" || txtConfirmNewPass == "")
            {
                ModelState.AddModelError("Validacion3", "Los campos no deben estar vacios");
                return View();
            }
            else
            {
                if (txtNewPass != txtConfirmNewPass)
                {
                    ModelState.AddModelError("Validacion3", "La nueva contraseña no coincide con la confirmación de contraseña");
                }
                else
                {
                    var result = db.UDP_VALIDAR_LOGIN(txtUsuario, txtPass).ToList();

                    if (result.Count > 0)
                    {
                        foreach (var item in result)
                        {
                            db.UDP_PASSWORD_CAMBIAR(txtUsuario, txtPass, txtNewPass);
                            return RedirectToAction("Index", "Login");
                        }
                    }
                    else
                    {
                        ModelState.AddModelError("Validacion3", "El usuario o la contraseña son incorrectos");
                        return View();
                    }
                }

                return RedirectToAction("Index", "Login");
            }
        }
    }
}