using Library_Automation.Models;
using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Claims;
using System.Security.Cryptography;
using System.Text;
using System.Threading.Tasks;

namespace Library_Automation.Controllers
{
    public class AuthorizedController : Controller
    {
        Context _context = new Context();
        public IActionResult Index()
        {
            return View();
        }

        [HttpPost]
        public async Task<IActionResult> SignIn(Auth auth)
        {
            using (var sha256provider = new SHA256CryptoServiceProvider())
            {
                var hash = sha256provider.ComputeHash(Encoding.UTF8.GetBytes(auth.AuthPassword));
                auth.AuthPassword = BitConverter.ToString(hash).Replace("-", "");
            }
            var info = _context.Auths.FirstOrDefault(x => x.AuthMail == auth.AuthMail &&
            x.AuthPassword == auth.AuthPassword);
            if (info != null)
            {
                var claims = new List<Claim>
                {
                    new Claim(ClaimTypes.Name, auth.AuthMail),
                    new Claim(ClaimTypes.Role, "Admin")
                };
                var userIdentity = new ClaimsIdentity(claims, "Login");
                ClaimsPrincipal principal = new ClaimsPrincipal(userIdentity);
                await HttpContext.SignInAsync(principal);

                HttpContext.Session.SetString("adminId", info.AuthId.ToString());
                return RedirectToAction("DashboardIndex", "Dashboard");
            }
            return RedirectToAction("Index", "Authorized");
        }

        [HttpPost]
        public async Task<IActionResult> SignUp(Auth auth)
        {
            using (var sha256provider = new SHA256CryptoServiceProvider())
            {
                var hash = sha256provider.ComputeHash(Encoding.UTF8.GetBytes(auth.AuthPassword));
                auth.AuthPassword = BitConverter.ToString(hash).Replace("-", "");
            }
            _context.Auths.Add(auth);
            await _context.SaveChangesAsync();
            return RedirectToAction("Index", "Authorized");
        }

        
    }
}

//using(var sha256provider = new SHA256CryptoServiceProvider())
//    {
//        var hash = sha256provider.ComputeHash(Encoding.UTF8.GetBytes(user.UserPassword));
//user.UserPassword = BitConverter.ToString(hash).Replace("-", "");
//            }