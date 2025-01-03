using Backend.Domain.Entity;

namespace Backend.Application.Authentication.DTOs;




public class TrailDtos
{
   public string? Name { get; set; }
   public List<string>? Images { get; set; }
   public string? Description { get; set; }
   public string? TrailType { get; set; }
   public int? Length { get; set; }
   public int? Elevation { get; set; }
   
   public static Trail TrailDtoToTrail(TrailDtos trailDtos)
   {
      return new Trail()
      {
      Description   = trailDtos.Description, 
      Elevation = trailDtos.Elevation,
      TrailType = trailDtos.TrailType,
      Images = trailDtos.Images,
      Length = trailDtos.Length,
      Name = trailDtos.Name
      };
   }
   
   
   
   
   
}
