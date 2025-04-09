using Backend.Domain.Entity;
using Backend.Domain.Repository;
using Backend.Infrasturcture.AppContext;
using System.Diagnostics;

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
            //i think i need to change this in future
       trailId= createTrail.Entity.Id??0;
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

    public async Task<bool> DeleteMapAndTrail(int Id)
    {
        var deleteTrail= await _db.Trails.FindAsync(Id);
        if(deleteTrail == null)
        {
            return false;
        }

        var deleteMap = await _db.Maps.FindAsync(deleteTrail.MapId);

        if(deleteMap == null)
        {
            return false;
        }

         _db.Trails.Remove(deleteTrail);
        _db.Maps.Remove(deleteMap);
        await _db.SaveChangesAsync();
        return true;
        

    }

    public async Task<bool> EditTrailAsync(Trail trail)
    {
        try
        {
            var result = _db.Trails.Update(trail);
            await _db.SaveChangesAsync();
            if (result == null || result.Entity == null || result.Entity.Id == 0 || result.Entity.Id == null)
            {
                return false;
            };
            return true;
        }
        catch (Exception ex) {
            return false;
        }
    }

    public async Task<bool> EditMapAsync(Map map)
    {
        try
        {
            var result = _db.Maps.Update(map);
            await _db.SaveChangesAsync();
            if (result == null || result.Entity == null || result.Entity.Id == 0)
            {
                return false;
            };
            return true;
        }
        catch (Exception ex)
        {
            return false;
        }
    }
}