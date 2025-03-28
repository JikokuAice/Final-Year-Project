using Backend.Domain.Repository;
using MediatR;

namespace Backend.Application.Admin.Command.DeleteTrail;

public class DeleteTrailCommandHandler : IRequestHandler<DeleteTrailCommand, bool>
{

    private readonly IAdminRepoServices _repoServices;
   public  DeleteTrailCommandHandler(IAdminRepoServices repoServices)
    {

    _repoServices = repoServices;
    }

    public Task<bool> Handle(DeleteTrailCommand request, CancellationToken cancellationToken)
    {

        var result = _repoServices.DeleteMapAndTrail(request.Id);
        return result;
    }
}