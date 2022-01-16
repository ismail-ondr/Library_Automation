using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Library_Automation.Models
{
    public class Context: DbContext
    {
        protected override void OnConfiguring(DbContextOptionsBuilder dbContextOptionsBuilder)
        {
            dbContextOptionsBuilder.UseSqlServer("server=DESKTOP-55PMU5M; database=Library_Db; integrated security=true");
        }

        public DbSet<Book> Books { get; set; }
        public DbSet<Auth> Auths { get; set; }
        public DbSet<User> Users { get; set; }

    }
}
