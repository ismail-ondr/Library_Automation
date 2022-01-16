using Library_Automation.Models;
using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Authentication.Cookies;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Library_Automation.Controllers
{
    public class UserInterfaceController : Controller
    {
        Context _context = new Context();

        
        public IActionResult MainPageIndex(string search)
        {
            IQueryable<Book> allBooks = _context.Books.Select(x => new Book
            {
                BookId = x.BookId,
                BookName = x.BookName,
                BookWriter = x.BookWriter,
                BookPublisher = x.BookPublisher,
                BookNumberOfPage = x.BookNumberOfPage,
                BookCoverUrl = x.BookCoverUrl
            });

            if (search != null)
            {
                allBooks = allBooks.Select(x => new Book
                {
                    BookId = x.BookId,
                    BookName = x.BookName,
                    BookWriter = x.BookWriter,
                    BookPublisher = x.BookPublisher,
                    BookNumberOfPage = x.BookNumberOfPage,
                    BookCoverUrl = x.BookCoverUrl
                }).Where(x => x.BookName.ToLower() == search.ToLower() ||
                              x.BookWriter.ToLower() == search.ToLower() ||
                              x.BookPublisher.ToLower() == search.ToLower());
            }
            
            

            var userId = HttpContext.Session.GetString("userId");
            if(userId != null)
            {
                var loggedUser = _context.Users.Find(Convert.ToInt32(userId));
                ViewBag.loggedUserName = loggedUser.UserName;
                ViewBag.loggedUserId = userId;
            }

            return View(allBooks);
        }
        
        public IActionResult DetailsPage(int id)    
        {
            Book findBook = _context.Books.Find(id);
            var userId = HttpContext.Session.GetString("userId");

            if (userId != null)
            {
                var loggedUser = _context.Users.Find(Convert.ToInt32(userId));
                ViewBag.loggedUserName = loggedUser.UserName;
                ViewBag.loggedUserId = userId;
            }
            return View(findBook);
        }

        [Authorize(Roles = "User")]
        public IActionResult AddBorrow(int bookId, int userId)
        {
            var findBook = _context.Books.Find(bookId);
            findBook.BarrowDate = DateTime.Now;
            findBook.ReturnDate = DateTime.Now.AddDays(20);
            findBook.IsBorrowed = true;
            findBook.UserId = userId;
            _context.SaveChanges();

            return RedirectToAction("MainPageIndex", "UserInterface");
        }

        [Authorize(Roles = "User")]
        public async Task<IActionResult> LogOut()
        {
            await HttpContext.SignOutAsync(CookieAuthenticationDefaults.AuthenticationScheme);
            HttpContext.Session.Clear();
            return RedirectToAction("MainPageIndex", "UserInterface");
        }

        [Authorize(Roles = "User")]
        public IActionResult UserProfile()
        {
            var userId = HttpContext.Session.GetString("userId");
            if (userId != null)
            {
                var loggedUser = _context.Users.Find(Convert.ToInt32(userId));
                ViewBag.loggedUserName = loggedUser.UserName;
                ViewBag.loggedUserId = userId;
            }

            IQueryable<Book> myBook = _context.Books.Where(x => x.UserId == Convert.ToInt32(userId)).Select(y => new Book
            {
                BookName = y.BookName,
                BookWriter = y.BookWriter,
                BarrowDate = y.BarrowDate,
                ReturnDate = y.ReturnDate,
                BookPublisher = y.BookPublisher,
                BookNumberOfPage = y.BookNumberOfPage
            });

            return View(myBook);
        }

    }
}
