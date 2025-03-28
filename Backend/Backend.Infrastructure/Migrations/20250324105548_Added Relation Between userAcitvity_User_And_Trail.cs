using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace Backend.Infrasturcture.Migrations
{
    /// <inheritdoc />
    public partial class AddedRelationBetweenuserAcitvity_User_And_Trail : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "Name",
                table: "UserActivity");

            migrationBuilder.RenameColumn(
                name: "Route",
                table: "UserActivity",
                newName: "TrailName");

            migrationBuilder.AlterColumn<string>(
                name: "DistanceCovered",
                table: "UserActivity",
                type: "nvarchar(max)",
                nullable: true,
                oldClrType: typeof(double),
                oldType: "float");

            migrationBuilder.AlterColumn<string>(
                name: "AvgSpeed",
                table: "UserActivity",
                type: "nvarchar(max)",
                nullable: true,
                oldClrType: typeof(double),
                oldType: "float");

            migrationBuilder.AddColumn<int>(
                name: "TrailId",
                table: "UserActivity",
                type: "int",
                nullable: false,
                defaultValue: 0);

            migrationBuilder.AddColumn<int>(
                name: "TrailId1",
                table: "UserActivity",
                type: "int",
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "UserId",
                table: "UserActivity",
                type: "int",
                nullable: false,
                defaultValue: 0);

            migrationBuilder.AddColumn<int>(
                name: "UserId1",
                table: "UserActivity",
                type: "int",
                nullable: true);

            migrationBuilder.CreateIndex(
                name: "IX_UserActivity_TrailId",
                table: "UserActivity",
                column: "TrailId",
                unique: true);

            migrationBuilder.CreateIndex(
                name: "IX_UserActivity_TrailId1",
                table: "UserActivity",
                column: "TrailId1",
                unique: true,
                filter: "[TrailId1] IS NOT NULL");

            migrationBuilder.CreateIndex(
                name: "IX_UserActivity_UserId",
                table: "UserActivity",
                column: "UserId");

            migrationBuilder.CreateIndex(
                name: "IX_UserActivity_UserId1",
                table: "UserActivity",
                column: "UserId1");

            migrationBuilder.AddForeignKey(
                name: "FK_UserActivity_Trails_TrailId",
                table: "UserActivity",
                column: "TrailId",
                principalTable: "Trails",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_UserActivity_Trails_TrailId1",
                table: "UserActivity",
                column: "TrailId1",
                principalTable: "Trails",
                principalColumn: "Id");

            migrationBuilder.AddForeignKey(
                name: "FK_UserActivity_Users_UserId",
                table: "UserActivity",
                column: "UserId",
                principalTable: "Users",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_UserActivity_Users_UserId1",
                table: "UserActivity",
                column: "UserId1",
                principalTable: "Users",
                principalColumn: "Id");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_UserActivity_Trails_TrailId",
                table: "UserActivity");

            migrationBuilder.DropForeignKey(
                name: "FK_UserActivity_Trails_TrailId1",
                table: "UserActivity");

            migrationBuilder.DropForeignKey(
                name: "FK_UserActivity_Users_UserId",
                table: "UserActivity");

            migrationBuilder.DropForeignKey(
                name: "FK_UserActivity_Users_UserId1",
                table: "UserActivity");

            migrationBuilder.DropIndex(
                name: "IX_UserActivity_TrailId",
                table: "UserActivity");

            migrationBuilder.DropIndex(
                name: "IX_UserActivity_TrailId1",
                table: "UserActivity");

            migrationBuilder.DropIndex(
                name: "IX_UserActivity_UserId",
                table: "UserActivity");

            migrationBuilder.DropIndex(
                name: "IX_UserActivity_UserId1",
                table: "UserActivity");

            migrationBuilder.DropColumn(
                name: "TrailId",
                table: "UserActivity");

            migrationBuilder.DropColumn(
                name: "TrailId1",
                table: "UserActivity");

            migrationBuilder.DropColumn(
                name: "UserId",
                table: "UserActivity");

            migrationBuilder.DropColumn(
                name: "UserId1",
                table: "UserActivity");

            migrationBuilder.RenameColumn(
                name: "TrailName",
                table: "UserActivity",
                newName: "Route");

            migrationBuilder.AlterColumn<double>(
                name: "DistanceCovered",
                table: "UserActivity",
                type: "float",
                nullable: false,
                defaultValue: 0.0,
                oldClrType: typeof(string),
                oldType: "nvarchar(max)",
                oldNullable: true);

            migrationBuilder.AlterColumn<double>(
                name: "AvgSpeed",
                table: "UserActivity",
                type: "float",
                nullable: false,
                defaultValue: 0.0,
                oldClrType: typeof(string),
                oldType: "nvarchar(max)",
                oldNullable: true);

            migrationBuilder.AddColumn<string>(
                name: "Name",
                table: "UserActivity",
                type: "nvarchar(max)",
                nullable: true);
        }
    }
}
