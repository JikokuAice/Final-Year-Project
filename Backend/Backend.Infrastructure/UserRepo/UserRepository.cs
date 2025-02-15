using Backend.Domain.Entity;
using Backend.Domain.Repository;
using Backend.Infrasturcture.AppContext;
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


        List<Trail> IUserRepoService.GetAllTrail()
        {
            var trails = _db.Trails.ToList();
            Console.WriteLine(trails);
            return trails;
        }
    }
}
