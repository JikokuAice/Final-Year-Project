using Backend.Domain.Entity;

namespace Backend.Domain.Repository;

public interface IAdminRepoServices
{
   Task<bool> CreateTrailsAsync(Trail trail);
   Task<bool> CreateMapAsync(Map map); 
}
