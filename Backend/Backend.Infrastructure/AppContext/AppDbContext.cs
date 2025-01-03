using Backend.Domain.Entity;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Activity = System.Diagnostics.Activity;

namespace Backend.Infrasturcture.AppContext;


//internal means only ascessable within Backend.Infrasturcture Assembly.
internal class AppDbContext:DbContext
{
   private readonly DbContextOptions<AppDbContext> _options;
   private readonly IConfiguration _configuration;
   public AppDbContext(DbContextOptions<AppDbContext> options,IConfiguration configuration):base(options)
   {
      _options = options;
      _configuration = configuration;
   }
   
   protected override void OnModelCreating(ModelBuilder modelBuilder)
   {
      var adminEmail = _configuration.GetSection("Backend_Admin_Email");
      var adminPassword = _configuration.GetSection("Backend_Admin_Password");
      var adminHashed = BCrypt.Net.BCrypt.EnhancedHashPassword(adminPassword.Value,13);
      
      User admin = new User()
      {
         Email = adminEmail.Value, Password = adminHashed, Name = "Admin", RoleId = 1, Image = "",Id = -1
      };
      
      modelBuilder.Entity<User>(e => e.HasData(admin)); 
      modelBuilder.Entity<Trail>().HasOne(e=>e.Maps).WithOne().HasForeignKey<Trail>(e=>e.MapId);
      
   }

   // public DbSet<Test> Tests { get; set; }
   public DbSet<User> Users { get; set; }
   public  DbSet<Role> Roles { get; set; }
   public DbSet<Feed> Feeds { get; set; }
   public DbSet<Map> Maps { get; set; }
   public DbSet<Suggestion> Suggestions { get; set; }
   public DbSet<Trail> Trails { get; set; }
   public DbSet<Review> Reviews { get; set; }
   public DbSet<UserActivites> UserActivity { get; set; }

 

}