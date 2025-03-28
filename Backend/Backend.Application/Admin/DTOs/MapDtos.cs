using System.ComponentModel.DataAnnotations;
using Backend.Domain.Entity;

namespace Backend.Application.Admin.DTOs;

public class MapDtos
{
   public string? MapName { get; set; }
   public string? destinationLatlang { get; set; }
 
    public string? startLatlang { get; set; }


   public double? Altitude  { get; set; }
   public double? Distance  { get; set; }
   public string? AverageTime { get; set; } 
   public string? Polypoints { get; set; }
   
   public static Map MapDtoToMap(MapDtos mapDtos)
   {
      return new Map()
      {
         MapName = mapDtos.MapName,
         destinationLatlang = mapDtos.destinationLatlang,
         startLatlang = mapDtos.startLatlang,
         Altitude=mapDtos.Altitude,
         AverageTime = mapDtos.AverageTime,
         Polypoints = mapDtos.Polypoints,
         Distance = mapDtos.Distance
      };
   }
}
