using System.ComponentModel.DataAnnotations;
using Backend.Application.Authentication.DTOs;
using MediatR;

namespace Backend.Application.Authentication.Command.LoginUser;



public class LoginUserCommand:IRequest<TokenDto?> 
{
   [Required]
   [EmailAddress]
   public string? Email { get; set; }
   
   [Required] 
   public  string? Password { get; set; }
}