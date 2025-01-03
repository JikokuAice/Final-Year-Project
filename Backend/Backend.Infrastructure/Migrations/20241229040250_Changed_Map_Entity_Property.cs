using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace Backend.Infrasturcture.Migrations
{
    /// <inheritdoc />
    public partial class Changed_Map_Entity_Property : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Trails_Maps_MapId",
                table: "Trails");

            migrationBuilder.DropIndex(
                name: "IX_Trails_MapId",
                table: "Trails");

            migrationBuilder.AlterColumn<int>(
                name: "MapId",
                table: "Trails",
                type: "int",
                nullable: true,
                oldClrType: typeof(int),
                oldType: "int");

            migrationBuilder.AlterColumn<string>(
                name: "Polypoints",
                table: "Maps",
                type: "nvarchar(max)",
                nullable: true,
                oldClrType: typeof(string),
                oldType: "nvarchar(max)");

            migrationBuilder.AlterColumn<string>(
                name: "MapName",
                table: "Maps",
                type: "nvarchar(max)",
                nullable: true,
                oldClrType: typeof(string),
                oldType: "nvarchar(max)");

            migrationBuilder.AlterColumn<double>(
                name: "Longitude",
                table: "Maps",
                type: "float",
                nullable: true,
                oldClrType: typeof(double),
                oldType: "float");

            migrationBuilder.AlterColumn<double>(
                name: "Latitude",
                table: "Maps",
                type: "float",
                nullable: true,
                oldClrType: typeof(double),
                oldType: "float");

            migrationBuilder.AlterColumn<string>(
                name: "AverageTime",
                table: "Maps",
                type: "nvarchar(max)",
                nullable: true,
                oldClrType: typeof(TimeOnly),
                oldType: "time");

            migrationBuilder.UpdateData(
                table: "Users",
                keyColumn: "Id",
                keyValue: -1,
                column: "Password",
                value: "$2a$13$r7KCrtp1urxL.LAp6fameOrtQmy6pNREhqBJ99Oi5kRRMcyjpgapS");

            migrationBuilder.CreateIndex(
                name: "IX_Trails_MapId",
                table: "Trails",
                column: "MapId",
                unique: true,
                filter: "[MapId] IS NOT NULL");

            migrationBuilder.AddForeignKey(
                name: "FK_Trails_Maps_MapId",
                table: "Trails",
                column: "MapId",
                principalTable: "Maps",
                principalColumn: "Id");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Trails_Maps_MapId",
                table: "Trails");

            migrationBuilder.DropIndex(
                name: "IX_Trails_MapId",
                table: "Trails");

            migrationBuilder.AlterColumn<int>(
                name: "MapId",
                table: "Trails",
                type: "int",
                nullable: false,
                defaultValue: 0,
                oldClrType: typeof(int),
                oldType: "int",
                oldNullable: true);

            migrationBuilder.AlterColumn<string>(
                name: "Polypoints",
                table: "Maps",
                type: "nvarchar(max)",
                nullable: false,
                defaultValue: "",
                oldClrType: typeof(string),
                oldType: "nvarchar(max)",
                oldNullable: true);

            migrationBuilder.AlterColumn<string>(
                name: "MapName",
                table: "Maps",
                type: "nvarchar(max)",
                nullable: false,
                defaultValue: "",
                oldClrType: typeof(string),
                oldType: "nvarchar(max)",
                oldNullable: true);

            migrationBuilder.AlterColumn<double>(
                name: "Longitude",
                table: "Maps",
                type: "float",
                nullable: false,
                defaultValue: 0.0,
                oldClrType: typeof(double),
                oldType: "float",
                oldNullable: true);

            migrationBuilder.AlterColumn<double>(
                name: "Latitude",
                table: "Maps",
                type: "float",
                nullable: false,
                defaultValue: 0.0,
                oldClrType: typeof(double),
                oldType: "float",
                oldNullable: true);

            migrationBuilder.AlterColumn<TimeOnly>(
                name: "AverageTime",
                table: "Maps",
                type: "time",
                nullable: false,
                defaultValue: new TimeOnly(0, 0, 0),
                oldClrType: typeof(string),
                oldType: "nvarchar(max)",
                oldNullable: true);

            migrationBuilder.UpdateData(
                table: "Users",
                keyColumn: "Id",
                keyValue: -1,
                column: "Password",
                value: "$2a$13$IGG88zBYcSYhItBrtjwF2.fQm8srV3fjFoLpc1Ots7j/RBOllAqwG");

            migrationBuilder.CreateIndex(
                name: "IX_Trails_MapId",
                table: "Trails",
                column: "MapId",
                unique: true);

            migrationBuilder.AddForeignKey(
                name: "FK_Trails_Maps_MapId",
                table: "Trails",
                column: "MapId",
                principalTable: "Maps",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);
        }
    }
}
