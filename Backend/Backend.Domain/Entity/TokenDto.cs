namespace Backend.Application.Authentication.DTOs;



public class TokenDto
{ 
   public string? AccessToken { get; set; }
   public string? RefreshToken { get; set; }
 
    public string? role {  get; set; }
    public string? primarySid { get; set; }
}