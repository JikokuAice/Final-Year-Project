using Backend.Application.User.Query.GetAllTrails;
using Backend.Application.User.Query.GetSpecificTrailDetail;
using Backend.Application.User.Query.GetSpecificMapDetail;
using MediatR;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Backend.Application.User.Commands.AddUserActivity;
using Backend.Application.User.Query.GetUserActivity;
using Microsoft.AspNetCore.Authorization;
using System.Security.Claims;
using Backend.Application.User.Query.GetTrailComments;
using Backend.Application.User.Dtos;
using Backend.Application.User.Commands.AddComment;
using Backend.Application.User.Commands.DeleteComment;
using Backend.Domain.Entity;
using Backend.Application.User.Commands.UpdateComment;

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
        public async Task<IActionResult> GetSpecificTrailDetail([FromRoute] GetSpecificTrailQuery query)
        {
            var result = await _mediator.Send(query);
            if (result == null)
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

        [Authorize]
        [HttpGet("/GetUserActivity")]
        public async Task<IActionResult> GetUserActivity()
        {
            // [FromRoute] GetUserActivityQuery query
            var user = User.FindFirst(ClaimTypes.PrimarySid)?.Value;
            Console.WriteLine(user);

            if (user == null || user == "0")
            {
                return NotFound("Please Authorize Correctly");
            }

            GetUserActivityQuery query = new GetUserActivityQuery();
            query.Id = int.Parse(user);

            var result = await _mediator.Send(query);
            return Ok(result);

        }

        [HttpPost("/imageUpload")]
        public async Task<IActionResult> UploadImage([FromForm] List<IFormFile> file)
        {
            var Paths = new List<string>();

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
                var path = Path.Combine("C:\\Users\\Ayush\\Music\\Final-Year-Project\\Backend\\Backend\\Images\\", fileItem.FileName);
                Paths.Add(path);
                using (FileStream stream = new FileStream(path, FileMode.Create))
                {
                    fileItem.CopyTo(stream);
                    stream.Close();
                }
            }

            return Ok(Paths);

        }


        [HttpPost("AddComment")]
        public async Task<IActionResult> Comment(AddCommentCommand addComment)
        {

            bool result = await _mediator.Send(addComment) ?? false;
            if (!result)
            {
                return BadRequest("ERR! Please Try To Add Comment Again");

            }
            return Ok(result);

        }


        [HttpGet("GetTrailComments/{trailId}")]
        public async Task<IActionResult> Comment([FromRoute] int trailId)
        {
            var query = new GetTrailCommentQuery();
            query.trailId = trailId;
            var result = await _mediator.Send(query);

            return Ok(result);

        }


        [HttpDelete("DeleteComment")]

        public async Task<IActionResult> DeleteComment([FromQuery] int commentId, [FromQuery] int userId)
        {
            if (commentId == 0 || userId == 0)
            {
                return BadRequest("Please provide CommentId and UserId");
            }
            DeleteCommentCommand deleteCommentCommand = new DeleteCommentCommand();
            deleteCommentCommand.CommentId = commentId;
            deleteCommentCommand.UserId = userId;
            var result = await _mediator.Send(deleteCommentCommand);

            if (!result)
            {
                return Conflict($"ERR! Comment with Id : {commentId} doesnt exist");
            }
            return Ok("Comment Deletion Sucessfull");
        }



        [HttpPut("UpdateComment")]
        public async Task<IActionResult> UpdateComment([FromQuery] int commentId, [FromQuery] int userId, [FromBody] UpdateCommentDto updateCommentDto)
        {
            if (updateCommentDto.CommentText == null || updateCommentDto.CommentText == "")
            {
                return BadRequest("please insert Upadte comment text");
            }

            if (userId == 0 )
            {
                return BadRequest("Id of User are Required");

            }

            if (commentId == 0 )
            {
                return BadRequest("Id of Comment are  Required");
            }

            UpdateCommentCommand updateCommentCommand = new UpdateCommentCommand();
            updateCommentCommand.CommentDto = updateCommentDto;
            updateCommentCommand.userId = userId;
            updateCommentCommand.commentId = commentId;

            var result = await _mediator.Send(updateCommentCommand);

            if (!result)
            {
                return NotFound();
                
            }

            return Ok($"Comment with Id : {commentId} upadted sucessfully");


        }






    }
    }
