using System.ComponentModel.DataAnnotations;

namespace Backend.Domain.Entity;

public class Trail
{
   [Key]
   public int?  Id { get; init; }
   public string? Name { get; set; }
   public List<string>? Images { get; set; }
   public string? Description { get; set; }
   public string? TrailType { get; set; }
   public string? Location { get; set; }
   public double? Rating { get; set; }
   public string? Difficulty { get; set; }
  
 public int? MapId;
public Map? Maps { get; set; }

public UserActivites? UserActivites { get; set; }
public List<Comments>? Comments { get; set; }

}


