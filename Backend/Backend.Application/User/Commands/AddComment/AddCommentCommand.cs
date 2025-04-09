using Backend.Application.User.Dtos;
using MediatR;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Backend.Application.User.Commands.AddComment
{
   public class AddCommentCommand:IRequest<bool?>
    {
        public InfraCommentDtos? Comments { get; set; }
    }
}
