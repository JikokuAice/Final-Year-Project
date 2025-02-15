using Backend.Application.User.Query.GetAllTrails;
using MediatR;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace Backend.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class UserController : ControllerBase
    {
        private readonly IMediator _mediator;

        public UserController(IMediator mediator)
        {
            _mediator = mediator;
        }


        [HttpGet("GetAllTrial")]
       public async Task<IActionResult> GetAllTrails()
        {
            var query = new GetAllTrailQuery();

            var result = await _mediator.Send(query);

            return Ok(result);
        }

    }
}
