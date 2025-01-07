

import '../entities/user_entity.dart';

abstract class AuthRepository{
 Future<AppUser?> loginWithEmailAndPassword(String email,String password);
  Future<AppUser?> register(String name, String email,String password);
  Future<void> logOut();
  Future<AppUser?> getCurrentUser();

}