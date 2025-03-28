using MediatR;

namespace Backend.Application.Admin.Command.DeleteTrail;

public class DeleteTrailCommand:IRequest<bool>
{
    public int Id { get; set; }
   
}