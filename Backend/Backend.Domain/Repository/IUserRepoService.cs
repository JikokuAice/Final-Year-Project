using Backend.Domain.Entity;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Backend.Domain.Repository
{
   public interface  IUserRepoService
    {
       List<Trail> GetAllTrail();
       Task<Trail> GetSpecificTrail(int Id);
       Task<Map?> GetSpecificMap(int Id);
       Task<bool> AddUserActivity(UserActivites userActivites);
       List<UserActivites> GetAllUserActivity(int Id);

        Task<List<CommentDtos>> GetTrailComments(int trailId);

        Task<bool?> AddComments(Comments comments);

        Task<bool> DeleteComment(int userId, int commentId);
        Task<bool> UpdateComment(int userId,int commentId,UpdateCommentDto updateCommentDto);


    }
}
