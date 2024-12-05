namespace Backend.Domain.Entity;

public class Review
{
   public int Id { get; set; }
  // public string? UserId
  public int? UserRating { get; set; }
  public string? Experience { get; set; }
  public string? Conditions { get; set; }
  public string? Suggestions { get; set; }
  public List<string?>? Images { get; set; }
}