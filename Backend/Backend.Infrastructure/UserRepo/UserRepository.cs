
using Backend.Domain.Entity;
using Backend.Domain.Repository;
using Backend.Infrasturcture.AppContext;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.ComponentModel.Design;
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

        public async Task<bool?> AddComments(Comments comments)
        {

            var userExist =await  _db.Users.FindAsync(comments.UserId);
            var trailExist = await _db.Trails.FindAsync(comments.TrailId);

            if (userExist == null || trailExist == null)
            {
                return false;
            }

            var commentAdded =  _db.Comments.Add(comments);
            await _db.SaveChangesAsync();
            if (commentAdded.Entity != null) {
                return true;
            }
            return false;
             
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

        public async Task<bool> DeleteComment(int userId, int commentId)
        {
            var userComment = await _db.Comments.FirstOrDefaultAsync(e=>e.Id==commentId&&e.UserId==userId);
            if(userComment == null) { return false; }
            _db.Comments.Remove(userComment);
            await _db.SaveChangesAsync();
            return true;
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
            var map = await _db.Maps.FirstOrDefaultAsync(e=>e.Id==trailResult!.MapId);

            return trailResult;
        }

        public async Task<List<CommentDtos>> GetTrailComments(int trailId)
        {
            var trailComments = await _db.Comments.Include(e=>e.User).Where(e=>e.TrailId==trailId).Select(e=>new CommentDtos { CommentText=e.CommentText,createdAt=e.createdAt,
               Id=e.Id,
               likes=e.likes,
               UserId=e.UserId,
               User=new UserDtos
{
    Image=e.User!.Image,
    Name=e.User.Name
}

            }).ToListAsync();  
            return trailComments;
        }

        public async Task<bool> UpdateComment(int userId, int commentId, UpdateCommentDto updateCommentDto)
        {
        
            var trailComment = await _db.Comments.FirstOrDefaultAsync(e => e.Id == commentId && e.UserId == userId);
            if (trailComment == null)
            {
                return false;
            }

           trailComment.CommentText=updateCommentDto.CommentText;

            _db.Comments.Update(trailComment);
            _db.SaveChanges();
            return true;

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
            var Acitvities = _db.UserActivity.Include(e=>e.Trail).Where(e=>e.UserId==userId);
            return Acitvities.ToList();
        }
    }
}
