using Backend.Application.Authentication.DTOs;
using Backend.Application.User.Entity;
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
