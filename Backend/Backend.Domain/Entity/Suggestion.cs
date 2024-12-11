namespace Backend.Domain.Entity;

public class Suggestion
{
   public int Id { get; set; }  // Primary key for uniqueness

   // List of suggested clothing items
   public List<string>? Clothing { get; set; } = new List<string>();

   // List of suggested gear items
   public List<string>? Gear { get; set; } = new List<string>();

   // Optional description or additional notes
   public string? Notes { get; set; }
}