
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entity/profile_user_entity.dart';
import '../../domain/repo/user_profile_repo.dart';

class UserProfileImpl implements UserProfileRepo{
  final FirebaseFirestore _firebaseFirestore;
  UserProfileImpl(this._firebaseFirestore);

  @override
  Future<UserProfile> fetchUserProfile(String userId) async{
    final userDoc= await _firebaseFirestore.collection('users').doc(userId).get();
    if(userDoc.exists){
      final data=userDoc.data()!;
      return UserProfile.fromJson(data);
    }
    else{
      throw Exception("User not found");
    }
  }

  @override
  Future<void> saveUserProfile(String userId,UserProfile profile) async{
   await _firebaseFirestore.collection('users').doc(userId)
       .set(profile.toJson());
  }
}