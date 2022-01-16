using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Library_Automation.Models
{
    public class BorrowDto
    {
        public int BookId { get; set; }
        public string BookName { get; set; }
        public string UserName { get; set; }
        public DateTime ReturnDate { get; set; }
        public DateTime BorrowDate { get; set; }
    }
}
