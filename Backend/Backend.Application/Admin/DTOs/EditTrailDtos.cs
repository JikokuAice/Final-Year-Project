using Backend.Application.Authentication.DTOs;
using Backend.Domain.Entity;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Backend.Application.Admin.DTOs
{
    public class EditTrailDtos
    {
        public int? Id { get; init; }
        public string? Name { get; set; }
        public List<string>? Images { get; set; }
        public string? Description { get; set; }
        public string? TrailType { get; set; }

        public double? Rating { get; set; }
        public string? Difficulty { get; set; }
        public string? Location { get; set; }

        public int? MapsId;
        public static Trail TrailDtoToTrail(EditTrailDtos trailDtos)
        {
            return new Trail()
            { 
                Id=trailDtos.Id,
                Description = trailDtos.Description,
                TrailType = trailDtos.TrailType,
                Images = trailDtos.Images,
                Name = trailDtos.Name,
                Difficulty = trailDtos.Difficulty,
                Rating = trailDtos.Rating,
                Location = trailDtos.Location,
                MapId = trailDtos.MapsId,
            };
        }

    }
}
