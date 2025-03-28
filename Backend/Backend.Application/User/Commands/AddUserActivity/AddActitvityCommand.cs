using Backend.Application.User.Dtos;
using MediatR;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Backend.Application.User.Commands.AddUserActivity
{
    public class AddActitvityCommand:IRequest<bool>
    {
       public UserActivitiesDtos? userActivitiesDtos { get; set; }

    }
}
