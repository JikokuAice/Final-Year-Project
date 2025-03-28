using Backend.Domain.Entity;

namespace Backend.Application.Authentication.DTOs;




public class TrailDtos
{
   public string? Name { get; set; }
   public List<string>? Images { get; set; }
   public string? Description { get; set; }
   public string? TrailType { get; set; }
   public string? Difficulty { get; set; }
    public double? Rating { get; set; } = 0;
    public string? Location { get; set; }

      
   public static Trail TrailDtoToTrail(TrailDtos trailDtos)
   {
      return new Trail()
      {
      Description   = trailDtos.Description, 
      TrailType = trailDtos.TrailType,
      Images = trailDtos.Images,
      Name = trailDtos.Name,
      Difficulty = trailDtos.Difficulty,
      Rating = trailDtos.Rating,
      Location = trailDtos.Location,
      };
   }
   
}
