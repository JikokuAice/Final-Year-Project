using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace Backend.Infrasturcture.Migrations
{
    /// <inheritdoc />
    public partial class Adding_One_to_One_relationship_Maps_And_Trails : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Trails_Maps_MapsId",
                table: "Trails");

            migrationBuilder.DropIndex(
                name: "IX_Trails_MapsId",
                table: "Trails");

            migrationBuilder.DropColumn(
                name: "MapsId",
                table: "Trails");

            migrationBuilder.AddColumn<int>(
                name: "MapId",
                table: "Trails",
                type: "int",
                nullable: false,
                defaultValue: 0);

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

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Trails_Maps_MapId",
                table: "Trails");

            migrationBuilder.DropIndex(
                name: "IX_Trails_MapId",
                table: "Trails");

            migrationBuilder.DropColumn(
                name: "MapId",
                table: "Trails");

            migrationBuilder.AddColumn<int>(
                name: "MapsId",
                table: "Trails",
                type: "int",
                nullable: true);

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
    }
}
