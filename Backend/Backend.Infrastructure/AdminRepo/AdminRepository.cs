using Backend.Domain.Entity;
using Backend.Domain.Repository;
using Backend.Infrasturcture.AppContext;

namespace Backend.Infrasturcture.AdminRepo;

internal class AdminRepository:IAdminRepoServices
{
   
   private readonly AppDbContext _db;
   
   public AdminRepository(AppDbContext db)
   {
      _db = db;
   }

   private int trailId;
   public async Task<bool> CreateTrailsAsync(Trail trail)
   {
      var createTrail = await _db.Trails.AddAsync(trail);
    await  _db.SaveChangesAsync();
    
    if (createTrail.Entity.Id != 0  || createTrail.Entity.Id != null)
    {
       trailId= createTrail.Entity.Id;
       return true;
    }

    return false;
   }

   public async Task<bool> CreateMapAsync(Map map)
   {
      var createMap = await _db.Maps.AddAsync(map);
      await _db.SaveChangesAsync();

      if (createMap.Entity.Id != 0 )
      {
         var trail = await _db.Trails.FindAsync(trailId);
         if (trail == null)
         {
            return false;
         }
          trail.MapId = createMap.Entity.Id;
          _db.Trails.Update(trail);
          await _db.SaveChangesAsync();
          return true;
      }

      return false;

   }
   
   
}