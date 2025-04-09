import 'package:frontend/Features/Profile/Data/Data_Source/Profile_Data_Source.dart';
import 'package:frontend/Features/Profile/Domain/Entity/user_activity_entity.dart';
import 'package:frontend/Features/Profile/Domain/Repository/Profile_domain_Repository.dart';

class ProfileRepoImp extends ProfileDomainRepository {
  ProfileDataSource profileDataSource;
  ProfileRepoImp(this.profileDataSource);

  @override
  Future<List<UserActivityEntity?>> fetchUserActivity(String token) async {
    var res = await profileDataSource.fetchUserActivity(token);
    List<UserActivityEntity?> data = [];
    for (var e in res) {
      data.add(UserActivityEntity(
          trailName: e!.trailName,
          distanceCovered: e.distanceCovered,
          avgSpeed: e.avgSpeed,
          timeElapsed: e.timeElapsed,
          activityDate: e.activityDate,
          difficulty: e.difficulty,
          images: e.images,
          location: e.location,
          trailType: e.trailType));
    }
    return data;
  }
}
