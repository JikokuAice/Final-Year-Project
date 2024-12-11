using Backend.Application.Authentication.DTOs;
using Backend.Domain.Repository;
using MediatR;

namespace Backend.Application.Authentication.Command.LoginUser;

public class LoginUserCommandHandler:IRequestHandler<LoginUserCommand,TokenDto?>
{
   private readonly IAuthenticationRepoServices _authRepoServices;
   public LoginUserCommandHandler(IAuthenticationRepoServices authRepoServices)
   {
      _authRepoServices = authRepoServices;
   }
   
   public async Task<TokenDto?> Handle(LoginUserCommand request, CancellationToken cancellationToken)
   {
      
   var result = await   _authRepoServices.Login(request.Email, request.Password);
   
   return result;
   }
}