using System.ComponentModel.DataAnnotations;

namespace Backend.Domain.Entity;

public class User
{
   [Key]
   public int Id { get; set; }
   
   public string? Name { get; set; }
   [Required]
   public string? Email { get; set; }
   [Required]
   public string? Password { get; set; }
   public string? Image { get; set; }
   
   public string? RefreshToken { get; set; }
   
   public DateTime? RefreshTokenExpiry { get; set; }
   
   public int? RoleId { get; set; }
   
   public Role? Role { get; set; }
   
   
   
   
}

