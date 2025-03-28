using Backend.Domain.Entity;
using Backend.Domain.Repository;
using MediatR;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Backend.Application.User.Query.GetSpecificMapDetail
{
    internal class GetSpecificMapDetailQueryHadler : IRequestHandler<GetSpecificMapDetailQuery, Map?>
    {

        private readonly IUserRepoService _userRepoService;
        public GetSpecificMapDetailQueryHadler(IUserRepoService userRepoService)
        {
            _userRepoService = userRepoService;
        }


        public async Task<Map?> Handle(GetSpecificMapDetailQuery request, CancellationToken cancellationToken)
        {
            var result =await  _userRepoService.GetSpecificMap(request.Id);
            return result;
        }
    }
}
