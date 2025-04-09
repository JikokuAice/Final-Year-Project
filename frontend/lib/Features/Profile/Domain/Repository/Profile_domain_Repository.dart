import 'package:frontend/Features/Profile/Domain/Entity/user_activity_entity.dart';

abstract class ProfileDomainRepository {
  Future<List<UserActivityEntity?>> fetchUserActivity(String token);
}
