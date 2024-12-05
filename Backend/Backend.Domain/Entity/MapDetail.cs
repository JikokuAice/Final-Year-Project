using System.ComponentModel.DataAnnotations;
using System.Runtime.InteropServices.JavaScript;

namespace Backend.Domain.Entity;

public class MapDetail
{
 [Key]
   public int Id { get; set; }
   [Required]
   public string MapName { get; set; }
   [Required]
   public double Latitude  { get; set; }
   [Required]
   public double Longitude  { get; set; }
   public double? Altitude  { get; set; }
   [Required]
   public double Distance  { get; set; }
   public TimeOnly AverageTime { get; set; } 
   [Required]
   public string polypoint { get; set; }
}