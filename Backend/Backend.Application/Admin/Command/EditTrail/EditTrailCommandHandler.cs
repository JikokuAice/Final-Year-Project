using Backend.Application.Admin.DTOs;
using Backend.Domain.Repository;
using MediatR;

namespace Backend.Application.Admin.Command.EditTrail;

public class EditTrailCommandHandler : IRequestHandler<EditTrailCommand, bool>
{

    private readonly IAdminRepoServices _adminRepoServices;

   public EditTrailCommandHandler(IAdminRepoServices adminRepoServices)
    {
        _adminRepoServices = adminRepoServices;
    }

    public async Task<bool> Handle(EditTrailCommand request, CancellationToken cancellationToken)
    {
       var trailConvertedFromDtos = EditTrailDtos.TrailDtoToTrail(request.Trail!);
        trailConvertedFromDtos.MapId = request.Map.Id;
        var trail = await _adminRepoServices.EditTrailAsync(trailConvertedFromDtos!);
        var map =await _adminRepoServices.EditMapAsync(request.Map!);
        if (map && trail)
        {
            return true;
        }
        return false;
    }
}