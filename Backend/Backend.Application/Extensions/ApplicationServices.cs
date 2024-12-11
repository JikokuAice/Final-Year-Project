using Microsoft.Extensions.DependencyInjection;
using MediatR;

namespace Backend.Application.Extensions;

public static class ApplicationServices
{
 public static void AddApplicationServices(this IServiceCollection services)
 {
  var assembly = typeof(ApplicationServices).Assembly;
  services.AddMediatR(config =>
  {
   config.RegisterServicesFromAssembly(assembly) ;}
   );
 }
}