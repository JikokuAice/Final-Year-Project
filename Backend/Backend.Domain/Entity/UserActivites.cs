using System.ComponentModel.DataAnnotations;
using System.Numerics;

namespace Backend.Domain.Entity;

public class UserActivites
{
   [Key]
   public int Id { get; set; }
   public string? TrailName { get; set; }
   public string? DistanceCovered { get; set; }
   public string? AvgSpeed { get; set; }
  public string? TimeElapsed { get; set; }
    public DateTime ActivityDate { get; set; }
    public int TrailId { get; set; }
    public Trail? Trail { get; set; }
    public int UserId { get; set; }
    public User? User { get; set; }
} 