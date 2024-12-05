using System.ComponentModel.DataAnnotations;

namespace Backend.Domain.Entity;

public class UserActivites
{
   [Key]
   public int Id { get; set; }
   public string Name { get; set; }
   public string route { get; set; }
   public double DistanceCovered { get; set; }
   public double AvgSpeed { get; set; }
  public string TimeElapsed { get; set; }  // Total time taken for the activity
  public DateTime ActivityDate { get; set; }  // Date of the activity

}