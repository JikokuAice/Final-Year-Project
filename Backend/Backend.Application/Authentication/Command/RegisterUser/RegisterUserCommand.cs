using System.ComponentModel.DataAnnotations;
using Backend.Domain.Entity;
using MediatR;

namespace Backend.Application.Authentication.Command.RegisterUser;

public class RegisterUserCommand:IRequest<bool>
{
   [Required]
   [MinLength(3)]
   public string? Name { get; set; }
   [EmailAddress]  
   [Required]
   public string? Email { get; set; }
   [MinLength(6)]
   public string? Password { get; set; }
   public string? Image { get; set; }
   
   

   public static User ConvertToUserFromRegisterUserCommand(RegisterUserCommand registerUserCommand)
   {
      return new User()
      {
Email = registerUserCommand.Email,
Password = registerUserCommand.Password,
Name = registerUserCommand.Name,
RoleId = 2,
Image = registerUserCommand.Image
      }; 
   }
   
}