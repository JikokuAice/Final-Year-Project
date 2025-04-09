using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Security.Cryptography;
using System.Text;
using Backend.Application.Authentication.DTOs;
using Backend.Domain.Entity;
using Backend.Domain.Services;
using Backend.Infrasturcture.AppContext;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.IdentityModel.Tokens;

namespace Backend.Infrasturcture.Services;

internal class AuthServices:IAuthServices
{

   private readonly AppDbContext _db;
   private readonly IConfiguration _configuration;
   public AuthServices(AppDbContext db,IConfiguration configuration)
   {
      _db = db;
      _configuration = configuration;
   }
   public async Task<bool> UserExistVerifcation(string email, string password)
   {
    var user = await _db.Users.FirstOrDefaultAsync(e => e.Email == email && e.Password == password);
    
    if (user == null)
    {
       return true;
    }
    return false;
   }

   public async Task<User?> Authenticate(string email, string password)
   {
   User? user = await _db.Users.Include(e=>e.Role).FirstOrDefaultAsync(e => e.Email == email && e.Password == password);
   return user;
   }
   
   
   public string GenerateRefreshToken()
   {
      var randomNumber = new byte[32];
      using (var rng = RandomNumberGenerator.Create())
      {
         rng.GetBytes(randomNumber);
         return Convert.ToBase64String(randomNumber);
      }
   }

   public async Task<TokenDto> GenerateToken(User user)
   {
      var securityKey  = _configuration.GetSection("Backend_Secret_Key").Value;
      var issuer = _configuration["Jwt:Issuer"];
      var audience = _configuration["Jwt:Audience"];
      
 SymmetricSecurityKey symmetricKey = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(securityKey)); 
 var credentials = new SigningCredentials(symmetricKey, SecurityAlgorithms.HmacSha256);
string? refreshToken = GenerateRefreshToken();
user.RefreshToken = refreshToken;
user.RefreshTokenExpiry=DateTime.Now.AddDays(1);

 _db.Users.Update(user);
await _db.SaveChangesAsync();
 
Claim[] claim = new Claim[]
{
   new Claim(ClaimTypes.PrimarySid, user.Id.ToString()),
   new Claim(ClaimTypes.Role, user.Role.Name.ToString()),
};
var token = new JwtSecurityToken(issuer:issuer,audience:audience,claims: claim,signingCredentials: credentials,expires: DateTime.Now.AddDays(1));
string? accessToken = new JwtSecurityTokenHandler().WriteToken(token);

      return new TokenDto()
      {
         AccessToken = accessToken,
         RefreshToken = refreshToken,
         role = user.Role.Name.ToString(),
      };
      
   }
}