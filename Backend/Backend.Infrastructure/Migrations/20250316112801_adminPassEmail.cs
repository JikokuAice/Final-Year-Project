using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace Backend.Infrasturcture.Migrations
{
    /// <inheritdoc />
    public partial class adminPassEmail : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.UpdateData(
                table: "Users",
                keyColumn: "Id",
                keyValue: -1,
                column: "Password",
                value: "Ayush025584216");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.UpdateData(
                table: "Users",
                keyColumn: "Id",
                keyValue: -1,
                column: "Password",
                value: "$2a$13$gk4.tHXFNCy4AnjA/CEEqeSxXavkdrxvRH7yqeP/r32MRzgLYjbFi");
        }
    }
}
