using Backend.Infrasturcture.AppContext;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;

namespace Backend.Infrasturcture.Extensions;

public static  class ServiceCollectionExtension
{ 
   
   public static void  AddInfrastructureServices(this IServiceCollection services,IConfiguration configuration)
   { 
  var key = configuration.GetConnectionString("ConnectionKey"); 
  services.AddDbContext<AppDbContext>(option=>option.UseSqlServer(connectionString:key)
     );
   }
}