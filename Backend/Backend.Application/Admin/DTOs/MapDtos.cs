using System.ComponentModel.DataAnnotations;
using Backend.Domain.Entity;

namespace Backend.Application.Admin.DTOs;

public class MapDtos
{
   public string? MapName { get; set; }
   public double? Latitude  { get; set; }
   public double? Longitude  { get; set; }
   public double? Altitude  { get; set; }
   public double Distance  { get; set; }
   public string? AverageTime { get; set; } 
   public string? Polypoints { get; set; }
   
   public static Map MapDtoToMap(MapDtos mapDtos)
   {
      return new Map()
      {
         MapName = mapDtos.MapName,
      };
   }
}
