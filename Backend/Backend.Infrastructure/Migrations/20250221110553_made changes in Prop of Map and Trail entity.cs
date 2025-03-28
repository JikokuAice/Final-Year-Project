using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace Backend.Infrasturcture.Migrations
{
    /// <inheritdoc />
    public partial class madechangesinPropofMapandTrailentity : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "Elevation",
                table: "Trails");

            migrationBuilder.DropColumn(
                name: "Length",
                table: "Trails");

            migrationBuilder.DropColumn(
                name: "Latitude",
                table: "Maps");

            migrationBuilder.DropColumn(
                name: "Longitude",
                table: "Maps");

            migrationBuilder.AddColumn<string>(
                name: "destinationLatlang",
                table: "Maps",
                type: "nvarchar(max)",
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "startLatlang",
                table: "Maps",
                type: "nvarchar(max)",
                nullable: true);

            migrationBuilder.UpdateData(
                table: "Users",
                keyColumn: "Id",
                keyValue: -1,
                column: "Password",
                value: "$2a$13$fpNvRwAeI1uVQIcA8ZKCUueoZGGO5YCDzAFNZo9ImARB.U/zfUiSW");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "destinationLatlang",
                table: "Maps");

            migrationBuilder.DropColumn(
                name: "startLatlang",
                table: "Maps");

            migrationBuilder.AddColumn<double>(
                name: "Elevation",
                table: "Trails",
                type: "float",
                nullable: true);

            migrationBuilder.AddColumn<double>(
                name: "Length",
                table: "Trails",
                type: "float",
                nullable: true);

            migrationBuilder.AddColumn<double>(
                name: "Latitude",
                table: "Maps",
                type: "float",
                nullable: true);

            migrationBuilder.AddColumn<double>(
                name: "Longitude",
                table: "Maps",
                type: "float",
                nullable: true);

            migrationBuilder.UpdateData(
                table: "Users",
                keyColumn: "Id",
                keyValue: -1,
                column: "Password",
                value: "$2a$13$TxLBsoPN/MOtDELZlkfDyO7WykVW1hDMBk.RM21dBzrRi7WIP3Vc2");
        }
    }
}
