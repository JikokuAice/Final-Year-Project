using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Backend.Domain.Entity
{
    public class Comments
    {
        [Key]
        public int Id { get; set; }
        [Required]
        public string? CommentText { get; set; }

        public int likes { get; set; } = 0;

     public   DateTime? createdAt { get; set; } = DateTime.Now.Date; 

        public int UserId { get; set; }
        public User? User { get; set; }


        public int TrailId { get; set; }    
        public Trail? Trail { get; set; }


        


    }
}

