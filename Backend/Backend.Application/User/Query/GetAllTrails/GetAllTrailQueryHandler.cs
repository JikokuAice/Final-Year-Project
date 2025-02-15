using Backend.Application.Authentication.DTOs;
using Backend.Application.User.Dtos;
using Backend.Domain.Repository;
using MediatR;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Backend.Application.User.Query.GetAllTrails
{
    internal class GetAllTrailQueryHandler : IRequestHandler<GetAllTrailQuery, List<UserTrailDtos?>>
    {

        private readonly IUserRepoService _userRepoService;
        public GetAllTrailQueryHandler(IUserRepoService userRepoService)
        {
            _userRepoService = userRepoService;
        }

     

        async Task<List<UserTrailDtos?>> IRequestHandler<GetAllTrailQuery, List<UserTrailDtos?>>.Handle(GetAllTrailQuery request, CancellationToken cancellationToken)
        {
            var result =  _userRepoService.GetAllTrail();
            List<UserTrailDtos?> resultConvertedToDto = result.Select(e => UserTrailDtos.TrailToUserTrailDto(e)).ToList();
            return resultConvertedToDto;
        }
    }
}
