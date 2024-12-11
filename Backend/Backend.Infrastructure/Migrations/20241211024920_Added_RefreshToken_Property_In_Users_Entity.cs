using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace Backend.Infrasturcture.Migrations
{
    /// <inheritdoc />
    public partial class Added_RefreshToken_Property_In_Users_Entity : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<string>(
                name: "RefreshToken",
                table: "Users",
                type: "nvarchar(max)",
                nullable: true);

            migrationBuilder.AddColumn<DateTime>(
                name: "RefreshTokenExpiry",
                table: "Users",
                type: "datetime2",
                nullable: true);

            migrationBuilder.UpdateData(
                table: "Users",
                keyColumn: "Id",
                keyValue: -1,
                columns: new[] { "Password", "RefreshToken", "RefreshTokenExpiry" },
                values: new object[] { "$2a$13$/7ZeBkFx2y6gw076NUlqAOPPwhN1rf54cuuVBZHNgVWtinIG8MjEq", null, null });
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "RefreshToken",
                table: "Users");

            migrationBuilder.DropColumn(
                name: "RefreshTokenExpiry",
                table: "Users");

            migrationBuilder.UpdateData(
                table: "Users",
                keyColumn: "Id",
                keyValue: -1,
                column: "Password",
                value: "$2a$13$.fWgzVPWz2aFVjJZ27AKbOZH/BT1UObbeXGcnXLb53KTvqlxcInIS");
        }
    }
}
