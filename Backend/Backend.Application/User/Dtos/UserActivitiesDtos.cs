using Backend.Domain.Entity;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Backend.Application.User.Dtos
{
    public class UserActivitiesDtos
    {
        public string? TrailName { get; set; }
        public string? DistanceCovered { get; set; }
        public string? AvgSpeed { get; set; }
        public string? TimeElapsed { get; set; }
        public DateTime ActivityDate { get; set; }
        public int TrailId { get; set; }
        public int UserId { get; set; }

        public UserActivites ConvertUserActivitiesDto(UserActivitiesDtos userActivitiesDtos)
        {
            return new UserActivites()
            {
                TrailName = userActivitiesDtos.TrailName,
                DistanceCovered = userActivitiesDtos.DistanceCovered,
                ActivityDate = userActivitiesDtos.ActivityDate,
                AvgSpeed = userActivitiesDtos.AvgSpeed,
                TimeElapsed = userActivitiesDtos.TimeElapsed,
                TrailId = userActivitiesDtos.TrailId,
                UserId = userActivitiesDtos.UserId
            }; 

        }
    }
     
    
}
