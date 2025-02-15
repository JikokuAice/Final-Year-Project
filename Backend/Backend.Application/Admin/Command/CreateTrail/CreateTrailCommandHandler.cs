using Backend.Application.Admin.DTOs;
using Backend.Application.Authentication.DTOs;
using Backend.Domain.Repository;
using MediatR;

namespace Backend.Application.Admin.Command.CreateTrails;

public class CreateTrailCommandHandler : IRequestHandler<CreateTrailCommand, bool>
{

    private readonly IAdminRepoServices _adminRepos;

    public CreateTrailCommandHandler(IAdminRepoServices adminRepoServices)
    {
        _adminRepos = adminRepoServices;
    }

    public async Task<bool> Handle(CreateTrailCommand request, CancellationToken cancellationToken)
    {

        var map = MapDtos.MapDtoToMap(request.MapDtos);
        var trail = TrailDtos.TrailDtoToTrail(request.TrailDtos);


        var trailCreateResult = await _adminRepos.CreateTrailsAsync(trail);
        var mapCreateResult = await _adminRepos.CreateMapAsync(map);

        if (trailCreateResult && mapCreateResult)
        {
            return true;
        }

        return false;

    }
}