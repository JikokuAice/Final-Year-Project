using Backend.Application.Admin.Command.CreateTrails;
using Backend.Domain.Entity;
using MediatR;
using Microsoft.AspNetCore.Mvc;

namespace Backend.Controllers;


[ApiController]
[Route("/[controller]")]
public class AdminController:ControllerBase
{
   
   private readonly IMediator _mediator;
   public AdminController(IMediator mediator)
   {
      _mediator = mediator;
   }
   
   
   [HttpGet]
   public IActionResult Index()
   {
      return Ok();
   }

   [HttpPost]
   public async Task<IActionResult> CreateTrail([FromBody]CreateTrailCommand createTrail)
   {
      var result = await _mediator.Send(createTrail);
      if (result)
      {
         return Ok("Trail with Map Created Successfully");
      }
      else
      {
         return BadRequest("Trail with Map Creation Failed");
      }
   }
   
   
   
   
}