using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace Backend.Infrasturcture.Migrations
{
    /// <inheritdoc />
    public partial class changes_Name_of_MapDetail_Table_to_Map : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "MapDetails");

            migrationBuilder.AddColumn<int>(
                name: "MapsId",
                table: "Trails",
                type: "int",
                nullable: true);

            migrationBuilder.CreateTable(
                name: "Maps",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    MapName = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    Latitude = table.Column<double>(type: "float", nullable: false),
                    Longitude = table.Column<double>(type: "float", nullable: false),
                    Altitude = table.Column<double>(type: "float", nullable: true),
                    Distance = table.Column<double>(type: "float", nullable: false),
                    AverageTime = table.Column<TimeOnly>(type: "time", nullable: false),
                    Polypoints = table.Column<string>(type: "nvarchar(max)", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Maps", x => x.Id);
                });

            migrationBuilder.UpdateData(
                table: "Users",
                keyColumn: "Id",
                keyValue: -1,
                column: "Password",
                value: "$2a$13$Jympzj4JUBCYgdf9e93jDuxTX3wh5RCaHzQ895SqF0BI2GcPfMZYK");

            migrationBuilder.CreateIndex(
                name: "IX_Trails_MapsId",
                table: "Trails",
                column: "MapsId");

            migrationBuilder.AddForeignKey(
                name: "FK_Trails_Maps_MapsId",
                table: "Trails",
                column: "MapsId",
                principalTable: "Maps",
                principalColumn: "Id");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Trails_Maps_MapsId",
                table: "Trails");

            migrationBuilder.DropTable(
                name: "Maps");

            migrationBuilder.DropIndex(
                name: "IX_Trails_MapsId",
                table: "Trails");

            migrationBuilder.DropColumn(
                name: "MapsId",
                table: "Trails");

            migrationBuilder.CreateTable(
                name: "MapDetails",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Altitude = table.Column<double>(type: "float", nullable: true),
                    AverageTime = table.Column<TimeOnly>(type: "time", nullable: false),
                    Distance = table.Column<double>(type: "float", nullable: false),
                    Latitude = table.Column<double>(type: "float", nullable: false),
                    Longitude = table.Column<double>(type: "float", nullable: false),
                    MapName = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    Polypoints = table.Column<string>(type: "nvarchar(max)", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_MapDetails", x => x.Id);
                });

            migrationBuilder.UpdateData(
                table: "Users",
                keyColumn: "Id",
                keyValue: -1,
                column: "Password",
                value: "$2a$13$/7ZeBkFx2y6gw076NUlqAOPPwhN1rf54cuuVBZHNgVWtinIG8MjEq");
        }
    }
}
