using Backend.Domain.Entity;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Backend.Application.User.Dtos
{
    public class InfraCommentDtos
    {

        [Required]
        public string? CommentText { get; set; }
     
        public int UserId { get; set; }
      
        public int TrailId { get; set; }


        public Comments ConvertFromDtos(InfraCommentDtos commentDtos)
        {
            return new Comments
            {
                TrailId=commentDtos.TrailId,
                UserId=commentDtos.UserId,  
                CommentText=commentDtos.CommentText,
            };
        }

    }
}
