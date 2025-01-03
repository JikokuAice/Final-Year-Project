using System.ComponentModel.DataAnnotations;
using System.Runtime.InteropServices.JavaScript;

namespace Backend.Domain.Entity;

public class Map
{
 [Key]
   public int Id { get; set; }
   public string? MapName { get; set; }
   public double? Latitude  { get; set; }
   public double? Longitude  { get; set; }
   public double? Altitude  { get; set; }
   public double Distance  { get; set; }
   public string? AverageTime { get; set; } 
   public string? Polypoints { get; set; }
}