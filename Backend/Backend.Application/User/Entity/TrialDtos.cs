using Backend.Domain.Entity;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Backend.Application.User.Entity
{
    public class UserTrailDtos
    {
        public int? Id { get; set; }
        public string? Name { get; set; }
        public List<string>? Images { get; set; }
        public double? Length { get; set; }
        public double? Rating { get; set; }
        public string? Difficulty { get; set; }

        

        public static Trail UserTrailDtoToTrail(UserTrailDtos trailDtos)
        {

            return new Trail()
            {
                Id = trailDtos.Id,
                Rating = trailDtos.Rating,
                Difficulty = trailDtos.Difficulty,
                Images = trailDtos.Images,
                Name = trailDtos.Name,
                
                
            };
        }


        public static UserTrailDtos? TrailToUserTrailDto(Trail trail)
        {

            return new UserTrailDtos()
            {
                Id = trail.Id,
                Rating = trail.Rating,
                Difficulty = trail.Difficulty,
                Images = trail.Images,
                Name = trail.Name,
              
                
            };
        }


    }

}
