using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;

namespace Library_Automation.Models
{
    public class Book
    {
        [Key]
        public int BookId { get; set; }
        public string BookName { get; set; }
        public string BookWriter { get; set; }
        public string BookPublisher { get; set; }
        public DateTime BarrowDate { get; set; }
        public DateTime ReturnDate { get; set; }
        public int BookNumberOfPage { get; set; }
        public string? BookCoverUrl { get; set; }
        public bool IsBorrowed { get; set; }
        public int? UserId { get; set; }
        public User User { get; set; }


    }
}
