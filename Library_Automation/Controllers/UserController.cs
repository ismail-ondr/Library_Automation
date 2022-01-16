using Library_Automation.Models;
using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Claims;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;
using System.Security.Cryptography;
using System.Text;

namespace Library_Automation.Controllers
{
    public class UserController : Controller
    {
        Context _context = new Context();

        [HttpGet]
        public IActionResult Index(int isSignup)
        {
            if (isSignup == 1)
            {
                ViewBag.isSignup = true;
            }
            else
                ViewBag.isSignup = false;
            return View();
        }

        [HttpPost]
        public async Task<IActionResult> Index(User user)
        {
            using (var sha256provider = new SHA256CryptoServiceProvider())
            {
                var hash = sha256provider.ComputeHash(Encoding.UTF8.GetBytes(user.UserPassword));
                user.UserPassword = BitConverter.ToString(hash).Replace("-", "");
            }
            var userInfo = _context.Users.FirstOrDefault(x => x.UserMail == user.UserMail &&
            x.UserPassword == user.UserPassword);
            if(userInfo != null)
            {
                var claims = new List<Claim>
                {
                    new Claim(ClaimTypes.Name, user.UserMail),
                    new Claim(ClaimTypes.Role, "User")
                };
                var userIdentity = new ClaimsIdentity(claims, "Login");
                ClaimsPrincipal principal = new ClaimsPrincipal(userIdentity);
                await HttpContext.SignInAsync(principal);
                HttpContext.Session.SetString("userId", userInfo.UserId.ToString());
                return RedirectToAction("MainPageIndex", "UserInterface");
            }   
        return View();
        }

        [HttpPost]
        public async Task<IActionResult> SignUp(User user)
        {
            using (var sha256provider = new SHA256CryptoServiceProvider())
            {
                var hash = sha256provider.ComputeHash(Encoding.UTF8.GetBytes(user.UserPassword));
                user.UserPassword = BitConverter.ToString(hash).Replace("-", "");
            }
            _context.Users.Add(user);
            await _context.SaveChangesAsync();
            return RedirectToAction("Index","User");
        }
        
    }
}
