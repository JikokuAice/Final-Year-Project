using Backend.Domain.Entity;
using Microsoft.EntityFrameworkCore;

namespace Backend.Infrasturcture.AppContext;


//internal means only ascessable within Backend.Infrasturcture Assembly.
internal class AppDbContext:DbContext
{
   private readonly DbContextOptions<AppDbContext> _options;
   public AppDbContext(DbContextOptions<AppDbContext> options):base(options)
   {
      _options = options;
   }
// //Acess only within Class or class that inherit it.
//    protected override void OnModelCreating(ModelBuilder modelBuilder)
//    {
//       base.OnModelCreating(modelBuilder);
//    }
//    
   
public DbSet<Test> Tests { get; set; }
   
}