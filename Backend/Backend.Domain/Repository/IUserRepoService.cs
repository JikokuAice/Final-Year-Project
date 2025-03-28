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
    }
}
