using Backend.Application.Authentication.DTOs;
using Backend.Domain.Entity;

namespace Backend.Domain.Services;

public interface IAuthServices
{
   Task<bool>  UserExistVerifcation (string email, string password);

   Task<User?> Authenticate(string email, string password);
   
   string GenerateRefreshToken();
   
   Task<TokenDto> GenerateToken(User user);
   
}