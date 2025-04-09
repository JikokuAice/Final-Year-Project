using Backend.Domain.Entity;
using Backend.Domain.Repository;
using MediatR;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Backend.Application.User.Query.GetTrailComments
{
    public class GetTraiLCommentQueryHandler : IRequestHandler<GetTrailCommentQuery, List<CommentDtos>>
    {
        private readonly IUserRepoService _userRepoService;
        public GetTraiLCommentQueryHandler(IUserRepoService userRepoService) {         
        _userRepoService = userRepoService;
        }


        public async Task<List<CommentDtos>>  Handle(GetTrailCommentQuery request, CancellationToken cancellationToken)
        {

            var result = await _userRepoService.GetTrailComments(request.trailId);
            return result;

        }
    }
}
