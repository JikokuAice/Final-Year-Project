using System.ComponentModel.DataAnnotations;

namespace Backend.Domain.Entity;

public class Role
{
  [Key]
   public int Id { get; set; }
   public string? Name { get; set; }
   public ICollection<User>? Users { get; set; }
}