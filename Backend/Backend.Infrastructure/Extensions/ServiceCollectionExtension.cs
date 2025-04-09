using System.Text;
using Backend.Domain.Repository;
using Backend.Domain.Services;
using Backend.Infrasturcture.AdminRepo;
using Backend.Infrasturcture.AppContext;
using Backend.Infrasturcture.AuthRepo;
using Backend.Infrasturcture.Services;
using Backend.Infrasturcture.UserRepo;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Authorization;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Diagnostics;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Options;
using Microsoft.IdentityModel.Tokens;

namespace Backend.Infrasturcture.Extensions;
public static  class ServiceCollectionExtension
{ 
   public static void AddInfrastructureServices(this IServiceCollection services,IConfiguration configuration)
   { 
  var key = configuration.GetConnectionString("ConnectionKey");
  services.AddDbContext<AppDbContext>(option =>
  {
     option.UseSqlServer(connectionString: key);
     option.ConfigureWarnings(w => w.Ignore(RelationalEventId.PendingModelChangesWarning));
  });
  
  
  
     services.AddScoped<IAuthenticationRepoServices,AuthRepository>();
     services.AddScoped<IAuthServices,AuthServices>();
 
     services.AddAuthentication(JwtBearerDefaults.AuthenticationScheme).AddJwtBearer(option =>
     {
        var secretKey = configuration.GetSection("Backend_Secret_Key").Value;
        var issuer = configuration["Jwt:Issuer"];
        var audience = configuration["jwt:Audience"];
        
        option.TokenValidationParameters = new()
        {
           ValidateAudience = true,
           ValidateLifetime = true,
           ValidateIssuer = true,
           ValidateIssuerSigningKey = true,
           ValidIssuer = issuer,
           ValidAudience = audience,
           IssuerSigningKey = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(secretKey))
        };

     });
     
     services.AddScoped<IAdminRepoServices, AdminRepository>();
     services.AddScoped<IUserRepoService, UserRepository>();
     

    }
}