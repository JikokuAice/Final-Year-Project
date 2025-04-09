using Backend.Domain.Repository;
using MediatR;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Backend.Application.User.Commands.DeleteComment
{
    public class DeleteCommentCommandHandler : IRequestHandler<DeleteCommentCommand, bool>
    {

        public IUserRepoService _repo;
        public DeleteCommentCommandHandler(IUserRepoService repo) {
        _repo = repo;
        
        }
        public async Task<bool> Handle(DeleteCommentCommand request, CancellationToken cancellationToken)
        {
          var result =await _repo.DeleteComment(request.UserId, request.CommentId);
            return result;
        }
    }
}
