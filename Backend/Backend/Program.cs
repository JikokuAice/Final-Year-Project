using Backend.Infrasturcture;
using Backend.Infrasturcture.Extensions;
using Backend.Application.Extensions;
using System.Text.Json.Serialization;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.


builder.WebHost.ConfigureKestrel(serverOpt =>
{
    serverOpt.ListenAnyIP(5000);
    serverOpt.ListenAnyIP(5001, listenOpt =>
    {
        listenOpt.UseHttps();
    });


});


builder.Services.AddCors(policy =>
policy.AddPolicy("MyPolicy", builder => { 
builder.AllowAnyOrigin();
    builder.AllowAnyMethod();
    builder.AllowAnyHeader();
    builder.AllowCredentials();
})
);



builder.Services.AddControllers().AddJsonOptions(options =>
{
options.JsonSerializerOptions.ReferenceHandler = ReferenceHandler.IgnoreCycles;
options.JsonSerializerOptions.WriteIndented = true;


});
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
app.UseStaticFiles();
app.MapControllers();

app.Run();