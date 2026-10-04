using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace Atlas.Infrastructure.Migrations
{
    /// <inheritdoc />
    public partial class AddUserProfile : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "user_profiles",
                columns: table => new
                {
                    user_id = table.Column<Guid>(type: "uuid", nullable: false),
                    first_name = table.Column<string>(type: "character varying(100)", maxLength: 100, nullable: false),
                    sex = table.Column<string>(type: "character varying(20)", maxLength: 20, nullable: true),
                    weight_kg = table.Column<int>(type: "integer", nullable: true),
                    height_cm = table.Column<int>(type: "integer", nullable: true),
                    experience_level = table.Column<string>(type: "character varying(50)", maxLength: 50, nullable: true),
                    primary_goal = table.Column<string>(type: "character varying(50)", maxLength: 50, nullable: true),
                    locations = table.Column<List<string>>(type: "text[]", nullable: false),
                    equipment = table.Column<List<string>>(type: "text[]", nullable: false),
                    frequency = table.Column<string>(type: "character varying(50)", maxLength: 50, nullable: true),
                    session_length = table.Column<string>(type: "character varying(20)", maxLength: 20, nullable: true),
                    injuries = table.Column<List<string>>(type: "text[]", nullable: false),
                    assessment_pull_ups = table.Column<int>(type: "integer", nullable: true),
                    assessment_push_ups = table.Column<int>(type: "integer", nullable: true),
                    assessment_dips = table.Column<int>(type: "integer", nullable: true),
                    completed_at = table.Column<DateTimeOffset>(type: "timestamp with time zone", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("pk_user_profiles", x => x.user_id);
                    table.ForeignKey(
                        name: "fk_user_profiles_users_user_id",
                        column: x => x.user_id,
                        principalTable: "users",
                        principalColumn: "id",
                        onDelete: ReferentialAction.Cascade);
                });
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "user_profiles");
        }
    }
}
