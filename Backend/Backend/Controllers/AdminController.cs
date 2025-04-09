using Backend.Application.Admin.Command.CreateTrails;
using Backend.Application.Admin.Command.DeleteTrail;
using Backend.Application.Admin.Command.EditTrail;
using Backend.Domain.Entity;
using MediatR;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Filters;
using System.IO;

namespace Backend.Controllers;


[ApiController]
[Route("/[controller]")]
public class AdminController:ControllerBase
{
    private readonly IWebHostEnvironment _env;

    private readonly IMediator _mediator;
   public AdminController(IMediator mediator, IWebHostEnvironment env)
   {
      _mediator = mediator;
        _env = env;

   }
   
 

   [HttpPost("/AddTrail")]
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


    [HttpPut("/UpdateTrail")]
    public async Task<IActionResult> UpdateTrail([FromBody] EditTrailCommand editTrail)
    {
        var result = await _mediator.Send(editTrail);

        if (result)
        {
            return Ok("Trial and Map Edited Successfully");
        }
        else
        {
            return BadRequest("Failed to Update Trail With Map");
        }
    }

    [HttpDelete("/DeleteTrail/{id}")]
    public async Task<IActionResult> DeleteTrail([FromRoute] DeleteTrailCommand deleteTrail)
    {

        if (deleteTrail.Id == 0 || deleteTrail.Id == null)
        {
            return BadRequest("where is gone ");
        }
        var result = await _mediator.Send(deleteTrail);
        return Ok( "Deleted trail with map"+ result);


    }


    [HttpPost("imageUpload")]
    public async Task<IActionResult> UploadImage([FromForm] List<IFormFile> file)
    {
        var Paths = new List<string>();
        var fileUrls = new List<string>();

        if (file == null)
        {
            return BadRequest("hell nah");

        }

       
        
        foreach (var fileItem in file)
        {
            if (fileItem == null || fileItem.Length == 0)
            {
                return NotFound("Please upload correct image file");
            }
            var uploadsFolder = Path.Combine(_env.WebRootPath, "uploads");
            if (!Directory.Exists(uploadsFolder))
            {
                Directory.CreateDirectory(uploadsFolder); 
            }
            var path = Path.Combine(uploadsFolder, fileItem.FileName);
            Paths.Add(path);
            using (FileStream stream = new FileStream(path, FileMode.Create))
            {
               await fileItem.CopyToAsync(stream);
              
            }
            fileUrls.Add($"uploads/{fileItem.FileName}");
        }


        return Ok(fileUrls);


    }

    }
   
   
 