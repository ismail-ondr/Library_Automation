using Microsoft.EntityFrameworkCore.Migrations;

namespace Library_Automation.Migrations
{
    public partial class mig3 : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "deneme",
                table: "Users");
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<int>(
                name: "deneme",
                table: "Users",
                type: "int",
                nullable: false,
                defaultValue: 0);
        }
    }
}
