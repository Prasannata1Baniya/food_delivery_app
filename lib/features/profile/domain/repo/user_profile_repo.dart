
import '../entity/profile_user_entity.dart';

abstract class UserProfileRepo{
  Future<UserProfile> fetchUserProfile(String userId);
  Future<void> saveUserProfile(String userId,UserProfile profile);
}
