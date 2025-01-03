using System.ComponentModel.DataAnnotations;
using Backend.Application.Admin.DTOs;
using Backend.Application.Authentication.DTOs;
using Backend.Domain.Entity;
using MediatR;

namespace Backend.Application.Admin.Command.CreateTrails;

public class CreateTrailCommand:IRequest<bool>
{
   [Required]
   public required TrailDtos TrailDtos { get; set; } 
   
   [Required] 
   public required MapDtos MapDtos { get; set; }
   
}
