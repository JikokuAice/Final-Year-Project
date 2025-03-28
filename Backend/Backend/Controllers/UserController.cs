using Backend.Application.User.Query.GetAllTrails;
using Backend.Application.User.Query.GetSpecificTrailDetail;
using Backend.Application.User.Query.GetSpecificMapDetail;
using MediatR;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Backend.Application.User.Commands.AddUserActivity;
using Backend.Application.User.Query.GetUserActivity;

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

        //new route 
        [HttpGet("GetTrailDetail/{Id}")]
        public async Task<IActionResult> GetSpecificTrailDetail([FromRoute]GetSpecificTrailQuery query)
        {
            var result = await _mediator.Send(query);
            if(result == null)
            {
                return BadRequest("Trail Doesnt Exist");
            }
            return Ok(result);

        }


        [HttpGet("GetSpecificMap/{Id}")]
        public async Task<IActionResult> GetMapDetaill([FromRoute] GetSpecificMapDetailQuery query)
        {

            var result = await _mediator.Send(query);
            if (result == null)
            {
                return BadRequest("Map Doesnot Exist For followinf Trail");
            }
            return Ok(result);

        }


        [HttpPost("/AddUserActivity")]
        public async Task<IActionResult> AddUserActivity([FromBody] AddActitvityCommand addActitvityCommand)
        {
            try
            {
                var result = await _mediator.Send(addActitvityCommand);
                if (result)
                {
                    return Ok("User Acitivty Added Successfully");
                }
              
            }
            catch (Exception e)
            {
                Console.WriteLine(e);
            }
            return BadRequest("Recheck userID and trailId!");

        }


        [HttpGet("/GetUserActivity/{Id}")]
        public async Task<IActionResult> GetUserActivity([FromRoute] GetUserActivityQuery query)
        {
          
            var result = await _mediator.Send(query);
            return Ok(result);

        }

    }
}
