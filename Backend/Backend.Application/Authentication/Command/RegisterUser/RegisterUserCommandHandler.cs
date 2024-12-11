using Backend.Domain.Repository;
using MediatR;

namespace Backend.Application.Authentication.Command.RegisterUser;

public class RegisterUserCommandHandler:IRequestHandler<RegisterUserCommand,bool>
{
   private readonly IAuthenticationRepoServices _authenticationRepoServices;
   public RegisterUserCommandHandler(IAuthenticationRepoServices authenticationRepoServices)
   {
      _authenticationRepoServices = authenticationRepoServices;
   }
   public async Task<bool> Handle(RegisterUserCommand request, CancellationToken cancellationToken)
   {
      var user = RegisterUserCommand.ConvertToUserFromRegisterUserCommand(request);
      var result = await _authenticationRepoServices.RegisterUser(user);
      return result;
   }
}