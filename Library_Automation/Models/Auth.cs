using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;

namespace Library_Automation.Models
{
    public class Auth
    {
        [Key]
        public int AuthId { get; set; }
        public string AuthName { get; set; }
        public string AuthPassword { get; set; }
        public string AuthMail { get; set; }

    }
}
