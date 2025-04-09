import 'package:frontend/Features/Profile/Domain/Entity/user_activity_entity.dart';
import 'package:frontend/Features/Profile/Domain/Repository/Profile_domain_Repository.dart';

class GetUseractivityUsecase {
  ProfileDomainRepository repository;

  GetUseractivityUsecase({required this.repository});

  Future<List<UserActivityEntity?>> call(String token) async {
    var res = await repository.fetchUserActivity(token);
    print("hitting daddy profile");
    return res;
  }
}
