
using Backend.Domain.Entity;
using Backend.Domain.Repository;
using Backend.Infrasturcture.AppContext;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Backend.Infrasturcture.UserRepo
{

    public class UserRepository : IUserRepoService
    {

        private readonly AppDbContext _db;
        public UserRepository(AppDbContext db)
        {
            _db = db;
        }

        public async Task<bool> AddUserActivity(UserActivites userActivites)
        {
           var user = await _db.Users.AnyAsync(e=>e.Id==userActivites.UserId);
            var trail =await _db.Trails.AnyAsync(e=>e.Id==userActivites.TrailId);
            if(user && trail)
            {
                _db.UserActivity.Add(userActivites); 
                await _db.SaveChangesAsync();
                return true;
            }
            return false;

        }

     

        public async Task<Map?> GetSpecificMap(int Id)
        {
            var trail =await _db.Trails.FindAsync(Id);
            var mapId = trail!.MapId;
            if (mapId == null)
            {
                return null;
            }
            var map = await _db.Maps.FindAsync(mapId);
            return map;
        }

        public  async Task<Trail> GetSpecificTrail(int Id)
        {
            var trailResult = await _db.Trails.FindAsync(Id);
            var map = await _db.Maps.FindAsync(trailResult!.MapId);

            return trailResult;
        }
        

        //this is for all trails
        List<Trail> IUserRepoService.GetAllTrail()
        {
            var trails = _db.Trails.ToList();
            Console.WriteLine(trails);
            return trails;
        }

        List<UserActivites> IUserRepoService.GetAllUserActivity(int userId)
        {
            var Acitvities = _db.UserActivity.Where(e=>e.UserId==userId);
            return Acitvities.ToList();
        }
    }
}
