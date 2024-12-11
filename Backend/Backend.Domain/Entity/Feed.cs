using System.ComponentModel.DataAnnotations;

namespace Backend.Domain.Entity;

public class Feed
{
   public int Id { get; set; }
   [Range(1,5)]
   public int Rating { get; set; }
   public int Likes { get; set; }
   [MaxLength(500)]
   public string? Comment { get; set; }
   
}


