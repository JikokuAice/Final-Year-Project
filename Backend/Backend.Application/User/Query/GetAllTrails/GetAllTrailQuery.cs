using Backend.Application.Authentication.DTOs;
using Backend.Application.User.Dtos;
using MediatR;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Backend.Application.User.Query.GetAllTrails
{
   public class GetAllTrailQuery : IRequest<List<UserTrailDtos?>>
    {

    }
}
