using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace Backend.Infrasturcture.Migrations
{
    /// <inheritdoc />
    public partial class RemoveUniqueConstraint : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropIndex(
                name: "IX_UserActivity_TrailId",
                table: "UserActivity");

            migrationBuilder.CreateIndex(
                name: "IX_UserActivity_TrailId",
                table: "UserActivity",
                column: "TrailId");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropIndex(
                name: "IX_UserActivity_TrailId",
                table: "UserActivity");

            migrationBuilder.CreateIndex(
                name: "IX_UserActivity_TrailId",
                table: "UserActivity",
                column: "TrailId",
                unique: true);
        }
    }
}
