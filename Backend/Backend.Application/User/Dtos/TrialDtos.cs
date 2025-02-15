using Backend.Domain.Entity;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Backend.Application.User.Dtos
{
    public class UserTrailDtos
    {
        public string? Name { get; set; }
        public List<string>? Images { get; set; }
        public int? Length { get; set; }
        public int? Rating { get; set; }
        public string? Difficulty { get; set; }

        public static Trail UserTrailDtoToTrail(UserTrailDtos trailDtos)
        {
           
            return new Trail()
            {
                Rating = trailDtos.Rating,
                Difficulty = trailDtos.Difficulty,
                Images = trailDtos.Images,
                Length = trailDtos.Length,
                Name = trailDtos.Name
            };
        }


        public static UserTrailDtos? TrailToUserTrailDto(Trail trail)
        {

            return new UserTrailDtos()
            {
                Rating = trail.Rating,
                Difficulty = trail.Difficulty,
                Images = trail.Images,
                Length = trail.Length,
                Name = trail.Name
            };
        }


    }

}
