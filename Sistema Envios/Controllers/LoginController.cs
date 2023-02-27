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
        private DBArticulosEncargosEntities db = new DBArticulosEncargosEntities();
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
                        return RedirectToAction("Index", "Home");
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
                ModelState.AddModelError("Validacion", "Los campos no deben estar vacios");
                return View();
            }
            else
            {
                if (txtNewPass != txtConfirmNewPass)
                {
                    ModelState.AddModelError("Validacion", "La nueva contraseña no coincide con la confirmación de contraseña");
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
                            return RedirectToAction("Index", "Home");
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
                ModelState.AddModelError("Validacion", "Los campos no deben estar vacios");
                return View();
            }
            else
            {
                if (txtNewPass != txtConfirmNewPass)
                {
                    ModelState.AddModelError("Validacion", "La nueva contraseña no coincide con la confirmación de contraseña");
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
                        ModelState.AddModelError("Validacion", "El usuario o la contraseña son incorrectos");
                        return View();
                    }
                }

                return RedirectToAction("Index", "Login");
            }
        }
    }
}