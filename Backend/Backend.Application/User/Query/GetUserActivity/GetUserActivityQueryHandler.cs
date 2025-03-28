using Backend.Domain.Entity;
using Backend.Domain.Repository;
using MediatR;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Backend.Application.User.Query.GetUserActivity
{
    public class GetUserActivityQueryHandler : IRequestHandler<GetUserActivityQuery, List<UserActivites>>
    {


        public IUserRepoService _userRepoService;
       public GetUserActivityQueryHandler(IUserRepoService userRepoService)
        {
            _userRepoService = userRepoService;
        }

        public async Task<List<UserActivites>> Handle(GetUserActivityQuery request, CancellationToken cancellationToken)
        {
            var result = _userRepoService.GetAllUserActivity(request.Id);
            return result;
        }
    }
}
