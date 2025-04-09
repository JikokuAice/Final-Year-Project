using Backend.Domain.Entity;

namespace Backend.Domain.Repository;

public interface IAdminRepoServices
{
   Task<bool> CreateTrailsAsync(Trail trail);
   Task<bool> CreateMapAsync(Map map);
    Task<bool> DeleteMapAndTrail(int Id);
    Task<bool> EditTrailAsync(Trail trail);
    Task<bool> EditMapAsync(Map map);
   
}
