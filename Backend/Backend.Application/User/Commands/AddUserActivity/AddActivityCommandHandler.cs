using Backend.Application.User.Dtos;
using Backend.Domain.Repository;
using MediatR;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Backend.Application.User.Commands.AddUserActivity
{
    public class AddActivityCommandHandler : IRequestHandler<AddActitvityCommand, bool>
    {

        private readonly IUserRepoService _userRepoService;
        public AddActivityCommandHandler(IUserRepoService userRepoService) {
        _userRepoService = userRepoService;
        }
        public Task<bool> Handle(AddActitvityCommand request, CancellationToken cancellationToken)
        {
           var userActivity = new UserActivitiesDtos().ConvertUserActivitiesDto(request.userActivitiesDtos!);
            var result = _userRepoService.AddUserActivity(userActivity);
            return result;
        }
    }
}
