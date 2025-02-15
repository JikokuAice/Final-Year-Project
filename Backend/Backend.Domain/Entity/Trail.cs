using System.ComponentModel.DataAnnotations;

namespace Backend.Domain.Entity;

public class Trail
{
   [Key]
   public int Id { get; init; }
   public string? Name { get; set; }
   public List<string>? Images { get; set; }
   public string? Description { get; set; }
   public string? TrailType { get; set; }
   public int? Length { get; set; }
   public int? Rating { get; set; }
   public string? Difficulty { get; set; }
   public int? Elevation { get; set; }

   public int? MapId;
   public Map? Maps { get; set; }
}


