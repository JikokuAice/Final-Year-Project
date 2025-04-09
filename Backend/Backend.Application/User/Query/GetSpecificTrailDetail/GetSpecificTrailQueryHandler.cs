using Backend.Domain.Entity;
using Backend.Domain.Repository;
using MediatR;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Backend.Application.User.Query.GetSpecificTrailDetail
{
    internal class GetSpecificTrailQueryHandler : IRequestHandler<GetSpecificTrailQuery, Trail>
    {

        private readonly IUserRepoService _userRepoService;
        public GetSpecificTrailQueryHandler(IUserRepoService userRepoService)
        {
            _userRepoService = userRepoService;

        }
        public async Task<Trail> Handle(GetSpecificTrailQuery request, CancellationToken cancellationToken)
        {
            var result =await _userRepoService.GetSpecificTrail(request.Id);
            return result;
        }

    }
}
