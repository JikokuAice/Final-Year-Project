using Backend.Application.Admin.DTOs;
using Backend.Application.Authentication.DTOs;
using Backend.Domain.Entity;
using MediatR;
using System.ComponentModel.DataAnnotations;

namespace Backend.Application.Admin.Command.EditTrail;

public class EditTrailCommand:IRequest<bool>
{
   
    public  EditTrailDtos? Trail { get; set; }
  
    public  Map? Map { get; set; }
}