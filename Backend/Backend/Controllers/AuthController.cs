using Backend.Application.Authentication.Command.LoginUser;
using Backend.Application.Authentication.Command.RegisterUser;
using Backend.Domain.Entity;
using MediatR;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace Backend.Controllers;

[ApiController]
[Route("[controller]")]
public class AuthController:ControllerBase
{

   private readonly IMediator _mediator;
   public AuthController(IMediator mediator)
   {
      _mediator = mediator;
   }
   
   [HttpPost("/Register")]
   public async Task<IActionResult> Regsiter([FromBody] RegisterUserCommand userCommand )
   {
      var result = await _mediator.Send(userCommand);
      if (result)
      {
         return Ok($"user registered successfully");
      }
      return BadRequest("user is already registered");
   }



   [HttpPost("/Login")]
   public async Task<IActionResult> Login([FromBody] LoginUserCommand userCommand)
   {
      if (string.IsNullOrEmpty(userCommand.Email) || string.IsNullOrEmpty(userCommand.Password))
      {
         return BadRequest("Credentials can't be empty");
      }
      
      var result = await _mediator.Send(userCommand);
      if (result==null)
      {
         return BadRequest("Incorrect credentials");
      }
      return Ok(result);
   }


   [Authorize(Roles = "Admin")]
   [HttpGet("/GetAdminSecret")]
   public IActionResult GetSecert()
   {
      return Ok("admin sir we have incoming attack from section 21 side .Act asap");
   }
   
   
    
   
}