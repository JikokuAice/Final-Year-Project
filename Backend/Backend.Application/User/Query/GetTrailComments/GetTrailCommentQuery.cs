using Backend.Application.User.Dtos;
using Backend.Domain.Entity;
using MediatR;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Backend.Application.User.Query.GetTrailComments
{
    public class GetTrailCommentQuery : IRequest<List<CommentDtos>>
    {
        public int trailId { get; set; }

    }
}
