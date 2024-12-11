using System.Security.Principal;
using Backend.Application.Authentication.DTOs;
using Backend.Domain.Entity;

namespace Backend.Domain.Repository;

public interface IAuthenticationRepoServices
{
   Task<bool> RegisterUser(User user);
   Task<TokenDto?> Login(string username, string password);
   
}