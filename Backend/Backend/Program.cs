using Backend.Infrasturcture;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.

builder.Services.AddControllers();
// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();
builder.Services.AddInfrasturctureServices();

var app = builder.Build();

// Configure the HTTP request pipeline.
//configuration for Devlopment Environment
if (app.Environment.IsDevelopment())
{
   app.UseSwagger();
   app.UseSwaggerUI();
}

if (app.Environment.IsProduction())
{
   //To Do 
   app.UseSwagger();
   app.UseSwaggerUI();
   
}


app.UseHttpsRedirection();

app.UseAuthorization();

app.MapControllers();

app.Run();