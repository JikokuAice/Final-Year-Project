using Backend.Application.User.Dtos;
using Backend.Domain.Entity;
using Backend.Domain.Repository;
using MediatR;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Backend.Application.User.Commands.AddComment
{
    public class AddCommentCommandHandler : IRequestHandler<AddCommentCommand, bool?>

    {

        public IUserRepoService _repo;

        public AddCommentCommandHandler(IUserRepoService repo)
        {
            _repo = repo;
            
        }

        public Task<bool?> Handle(AddCommentCommand request, CancellationToken cancellationToken)
        {
           Comments convertedComment = new InfraCommentDtos().ConvertFromDtos(request.Comments!);
            var result = _repo.AddComments(convertedComment);
            return result;

        }
    }
}
