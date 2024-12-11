using Backend.Infrasturcture;
using Backend.Infrasturcture.Extensions;
using Backend.Application.Extensions;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.

builder.Services.AddControllers();
builder.Services.AddApplicationServices();
builder.Services.AddInfrastructureServices(builder.Configuration);
builder.Services.AddSwaggerGen();

var app = builder.Build();
// Configure the HTTP request pipeline. 
//configuration for Devlopment Environment.
if (app.Environment.IsDevelopment())
{
   app.UseSwagger();
   app.UseSwaggerUI();
}

if (app.Environment.IsProduction())
{
   app.UseSwagger();
   app.UseSwaggerUI();
}

app.UseHttpsRedirection();

app.UseAuthentication();
app.UseAuthorization();

app.MapControllers();

app.Run();