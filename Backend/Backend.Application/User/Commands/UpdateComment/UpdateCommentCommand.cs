using Backend.Domain.Entity;
using MediatR;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Backend.Application.User.Commands.UpdateComment
{
   public class UpdateCommentCommand:IRequest<bool>
    {

        public int userId;

        public int commentId;
        public UpdateCommentDto CommentDto {  get; set; }
    }
}
