using Library_Automation.Models;
using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Authentication.Cookies;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Threading.Tasks;


namespace Library_Automation.Controllers
{
    [Authorize(Roles ="Admin")]
    public class DashboardController : Controller
    {
        Context _context = new Context();
        
        public IActionResult VisualizeChart()
        {

            List<ChartDto> book = new List<ChartDto>();
            book.Add(new ChartDto()
            {
                Date = "Kalan kitap sayısı",
                Count = _context.Books.ToList().Count() - _context.Books.Where(x => x.IsBorrowed == true).ToList().Count
            });
            book.Add(new ChartDto()
            {
                Date = "Ödünç verilen kitap sayısı",
                Count = _context.Books.Where(x => x.IsBorrowed == true).ToList().Count
            });

            return Json(book);
            
        }
        
        public IActionResult DashboardIndex(int selectbox)
        {
            int userCount = _context.Users.ToList().Count();
            int authCount = _context.Auths.ToList().Count();
            int bookCount = _context.Books.ToList().Count();
            int borrowedBookCount = _context.Books.Where(x => x.IsBorrowed == true).Count();

            ViewBag.userCount = userCount;
            ViewBag.authCount = authCount;
            ViewBag.bookCount = bookCount;
            ViewBag.borrowedBookCount = borrowedBookCount;

            int remainTime;
            if ( selectbox == 0) { remainTime = 5; }
            else if(selectbox == 1) { remainTime = 10; }
            else { remainTime = 0; }
            
            IQueryable<BorrowDto> upcomingBooks = from e in _context.Books
                            join d in _context.Users on e.UserId equals d.UserId
                            where (e.IsBorrowed == true &&
                                
                                (e.ReturnDate.Month - DateTime.Now.Month) * 30 +
                                (e.ReturnDate.Day - DateTime.Now.Day) < remainTime
                            )
                            select new BorrowDto 
                            {
                                BookName = e.BookName,
                                UserName = d.UserName,
                                ReturnDate = e.ReturnDate
                            };
            
            ViewBag.upcomingBooks = upcomingBooks;

            

            return View();
        }
        // Kitap işlemleri
        public IActionResult BookTransactions(string property, Book book)
        {
            
            if(property != null)
            {
                var foundBooks = _context.Books.Select(x => new Book
                {
                    BookId = x.BookId,
                    BookName = x.BookName,
                    BookWriter = x.BookWriter,
                    BookPublisher = x.BookPublisher,
                    BookNumberOfPage = x.BookNumberOfPage
                }).Where(x => x.BookName.ToLower() == property.ToLower() ||
                         x.BookWriter.ToLower() == property.ToLower() ||
                         x.BookPublisher.ToLower() == property.ToLower()).ToList();
                ViewBag.foundBooksList = foundBooks;
            }

            else
            {
                var foundBooks = _context.Books.Select(x => new Book
                {
                    BookId = x.BookId,
                    BookName = x.BookName,
                    BookWriter = x.BookWriter,
                    BookPublisher = x.BookPublisher,
                    BookNumberOfPage = x.BookNumberOfPage
                });
                ViewBag.foundBooksList = foundBooks;
            }
            return View(book);
        }

        public async Task<IActionResult> AddBook(Book book)
        {
            Book isFind = _context.Books.Find(book.BookId);
            if(isFind == null)
            {
                _context.Books.Add(book);
                await _context.SaveChangesAsync();
            }
            else
            {
                isFind.BookName = book.BookName;
                isFind.BookWriter = book.BookWriter;
                isFind.BookPublisher = book.BookPublisher;
                isFind.BookNumberOfPage = book.BookNumberOfPage;
                isFind.BookCoverUrl = book.BookCoverUrl;
                _context.SaveChanges();
            }
            
            return RedirectToAction("BookTransactions", "Dashboard");
        }

        public IActionResult RemoveBook(int id)
        {
            var book = _context.Books.Find(id);
            _context.Books.Remove(book);
            _context.SaveChanges();
            return RedirectToAction("BookTransactions", "Dashboard");
        }

        public IActionResult UpdateBook(int id)
        {
            Book book = _context.Books.Find(id);
            return RedirectToAction("BookTransactions", "Dashboard", book);
        }
        
        // Üye işlemleri
        public IActionResult MemberTransactions(string property, User user)
        {
            if (property != null)
            {
                var foundUsers = _context.Users.Select(x => new User
                {
                    UserId = x.UserId,
                    UserMail = x.UserMail,
                    UserName = x.UserName
                }).Where(x => x.UserName.ToLower() == property.ToLower() ||
                         x.UserMail.ToLower() == property.ToLower()).ToList();
                ViewBag.foundUsersList = foundUsers;
            }
            else
            {
                var foundUsers = _context.Users.Select(x => new User
                {
                    UserId = x.UserId,
                    UserMail = x.UserMail,
                    UserName = x.UserName
                });
                ViewBag.foundUsersList = foundUsers;
            }
            
            return View(user); 
        }

        public async Task<IActionResult> AddMember(User user)
        {
            User isFind = _context.Users.Find(user.UserId);
            if(isFind == null)
            {
                using (var sha256provider = new SHA256CryptoServiceProvider())
                {
                    var hash = sha256provider.ComputeHash(Encoding.UTF8.GetBytes(user.UserPassword));
                    user.UserPassword = BitConverter.ToString(hash).Replace("-", "");
                }
                _context.Users.Add(user);
                await _context.SaveChangesAsync();
            }
            else
            {
                if(isFind.UserPassword != user.UserPassword)
                {
                    using (var sha256provider = new SHA256CryptoServiceProvider())
                    {
                        var hash = sha256provider.ComputeHash(Encoding.UTF8.GetBytes(user.UserPassword));
                        user.UserPassword = BitConverter.ToString(hash).Replace("-", "");
                    }
                    isFind.UserPassword = user.UserPassword;
                }
                
                isFind.UserName = user.UserName;
                isFind.UserMail = user.UserMail;
                
                _context.SaveChanges();
            }
            
            return RedirectToAction("MemberTransactions", "Dashboard");
        }
        
        public IActionResult RemoveMember(int id)
        {
            var user = _context.Users.Find(id);
            _context.Users.Remove(user);
            _context.SaveChanges();
            return RedirectToAction("MemberTransactions", "Dashboard");
        }

        public IActionResult UpdateMember(int id)
        {
            User user = _context.Users.Find(id);
            return RedirectToAction("MemberTransactions", "Dashboard", user);
        }

        // Yetkili işlemleri (Admin)
        public IActionResult AuthTransactions(Auth auth)
        {
            var authList = _context.Auths.Select(x => new Auth
            {
                AuthId = x.AuthId,
                AuthName = x.AuthName,
                AuthMail = x.AuthMail
            });
            ViewBag.authList = authList;
            return View(auth);
        }

        public async Task<IActionResult> AddAuth(Auth auth)
        {
            Auth isFind = _context.Auths.Find(auth.AuthId);
            if(isFind == null)
            {
                using (var sha256provider = new SHA256CryptoServiceProvider())
                {
                    var hash = sha256provider.ComputeHash(Encoding.UTF8.GetBytes(auth.AuthPassword));
                    auth.AuthPassword = BitConverter.ToString(hash).Replace("-", "");
                }
                _context.Auths.Add(auth);
                await _context.SaveChangesAsync();
            }
            else
            {
                if(isFind.AuthPassword != auth.AuthPassword)
                {
                    using (var sha256provider = new SHA256CryptoServiceProvider())
                    {
                        var hash = sha256provider.ComputeHash(Encoding.UTF8.GetBytes(auth.AuthPassword));
                        auth.AuthPassword = BitConverter.ToString(hash).Replace("-", "");
                    }
                    isFind.AuthPassword = auth.AuthPassword;
                }
                
                isFind.AuthName = auth.AuthName;
                isFind.AuthMail = auth.AuthMail;
                
                _context.SaveChanges();
            }
            
            return RedirectToAction("AuthTransactions", "Dashboard");
        }

        public IActionResult RemoveAuth(int id)
        {
            var auth = _context.Auths.Find(id);
            _context.Auths.Remove(auth);
            _context.SaveChanges();
            return RedirectToAction("AuthTransactions", "Dashboard");
        }

        public IActionResult UpdateAuth(int id)
        {
            Auth auth = _context.Auths.Find(id);
            //Auth au = new Auth()
            //{
            //    AuthId = auth.AuthId,
            //    AuthName = auth.AuthName,
            //    AuthMail = auth.AuthMail
            //};
            return RedirectToAction("AuthTransactions", "Dashboard", auth);
        }

        // Ödünç alma işlemleri
        public IActionResult BorrowTransactions(string searchBook, string searchUser, string err)
        {
            
            if(searchUser != null)
            {
                List<User> foundUsers = _context.Users.Select(x => new User
                {
                    UserId = x.UserId,
                    UserMail = x.UserMail,
                    UserName = x.UserName
                }).Where(x => x.UserName.ToLower() == searchUser.ToLower() ||
                         x.UserMail.ToLower() == searchUser.ToLower()).ToList();
                ViewBag.foundUsersList = foundUsers;
            }
            else
            {
                List<User> foundUsers = _context.Users.Select(x => new User
                {
                    UserId = x.UserId,
                    UserMail = x.UserMail,
                    UserName = x.UserName
                }).ToList();
                ViewBag.foundUsersList = foundUsers;
            }
            
            if (searchBook != null)
            {
                List<Book> foundBooks = _context.Books.Select(x => new Book
                {
                    BookId = x.BookId,
                    BookName = x.BookName,
                    BookWriter = x.BookWriter,
                    BookPublisher = x.BookPublisher,
                    BookNumberOfPage = x.BookNumberOfPage,
                    IsBorrowed = x.IsBorrowed
                }).Where(x => x.BookName.ToLower() == searchBook.ToLower() ||
                         x.BookWriter.ToLower() == searchBook.ToLower() && x.IsBorrowed == false).ToList();
                ViewBag.foundBooksList = foundBooks;
            }
            else
            {
                List<Book> foundBooks = _context.Books.Select(x => new Book
                {
                    BookId = x.BookId,
                    BookName = x.BookName,
                    BookWriter = x.BookWriter,
                    BookPublisher = x.BookPublisher,
                    BookNumberOfPage = x.BookNumberOfPage,
                    IsBorrowed = x.IsBorrowed
                    
                }).Where(x => x.IsBorrowed == false).ToList();
                ViewBag.foundBooksList = foundBooks;
            }
            if(err == null || err == "noError")
            {
                ViewBag.errorType = "noError";
            }
            else if(err == "alreadyBorrowedError")
            {
                ViewBag.errorType = "alreadyBorrowedError";
            }
            else if(err == "idError")
            {
                ViewBag.errorType = "idError";
            }
            return View();
        }

        public IActionResult AddBorrow(int bookId, int userId)
        {
            string errorType = "noError";
            var member = _context.Users.FirstOrDefault(x => x.UserId == userId);
            var book = _context.Books.FirstOrDefault(x => x.BookId == bookId);
            if (member != null && book != null)
            {
                if (book.IsBorrowed != true)
                {
                    book.UserId = userId;
                    book.IsBorrowed = true;
                    book.BarrowDate = DateTime.Now;
                    book.ReturnDate = DateTime.Now.AddDays(20);
                    _context.SaveChanges();
                }
                else errorType = "alreadyBorrowedError";
            }
            else errorType = "idError";

            
            return RedirectToAction("BorrowTransactions", "Dashboard", new { err = errorType});
        }

        // İade işlemleri
        public IActionResult ReturnTransactions()
        {
            var allBorrowedBooks = from e in _context.Books
                                   join d in _context.Users on e.UserId equals d.UserId
                                   where e.IsBorrowed == true
                                   select new BorrowDto
                                   {
                                       BookId = e.BookId,
                                       BookName = e.BookName,
                                       UserName = d.UserName,
                                       ReturnDate = e.ReturnDate,
                                       BorrowDate = e.BarrowDate
                                   };
            
            return View(allBorrowedBooks);
        }

        public IActionResult ReturnBook(int id)
        {
            Book findBook = _context.Books.Find(id);
            findBook.UserId = null;
            findBook.IsBorrowed = false;
            findBook.ReturnDate = DateTime.MinValue;
            _context.SaveChanges();
            return RedirectToAction("ReturnTransactions", "Dashboard");
        }

        // Çıkış
        public async Task<IActionResult> LogOut()
        {
            await HttpContext.SignOutAsync(CookieAuthenticationDefaults.AuthenticationScheme);
            HttpContext.Session.Clear();
            return RedirectToAction("Index", "Authorized");
        }


    }
}
