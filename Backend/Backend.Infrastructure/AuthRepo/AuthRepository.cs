using Backend.Application.Authentication.DTOs;
using Backend.Domain.Entity;
using Backend.Domain.Repository;
using Backend.Domain.Services;
using Backend.Infrasturcture.AppContext;
using Backend.Infrasturcture.Services;
using Microsoft.AspNetCore.Authentication;

namespace Backend.Infrasturcture.AuthRepo;

internal class AuthRepository:IAuthenticationRepoServices
{

   private readonly AppDbContext _db;
   private readonly IAuthServices _authServices;
   public AuthRepository(AppDbContext db,IAuthServices authServices)
   {
      _db = db;
      _authServices = authServices;
   }
   
   public async Task<bool> RegisterUser(User user)
   {
            
var verifyUserRegistered = await _authServices.UserExistVerifcation(user.Email, user.Password);
if (!verifyUserRegistered)
{
   return false;
}

var userCreated = await _db.Users.AddAsync(user);
await _db.SaveChangesAsync();

if (userCreated.Entity.Id == 0)
{
         return false;
}
      return true;
   }

   public async Task<TokenDto?> Login(string email, string password)
   {
      var fetchUserByEmail = await _authServices.Authenticate(email, password);

      if (fetchUserByEmail == null)
      {
         return null;
      }
      
      var generatedToken = await _authServices.GenerateToken(fetchUserByEmail);
      return generatedToken;
   }
}
