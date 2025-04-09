using Backend.Domain.Repository;
using MediatR;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Backend.Application.User.Commands.UpdateComment
{
    public class UpdateCommentCommandHandler : IRequestHandler<UpdateCommentCommand, bool>
    {

        private readonly IUserRepoService _repo;
        public UpdateCommentCommandHandler(IUserRepoService repo) {  

        _repo = repo;   

          }
        public async Task<bool> Handle(UpdateCommentCommand request, CancellationToken cancellationToken)
        {
            var result = await _repo.UpdateComment(request.userId, request.commentId,request.CommentDto);
            return result;
        }
    }
}
