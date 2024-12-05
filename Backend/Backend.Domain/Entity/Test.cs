using System.ComponentModel.DataAnnotations;

namespace Backend.Domain.Entity;

public class Test
{
   [Key]
   public int Id { get; set; }
   public string TestName { get; set; }
   public bool TestStatus { get; set; }
}