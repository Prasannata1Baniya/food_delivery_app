

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/features/auth/domain/entities/user_entity.dart';
import 'package:e_commerce_app/features/auth/domain/repos/auth_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepoImpl implements AuthRepository{
  FirebaseAuth firebaseAuth=FirebaseAuth.instance;
  final  FirebaseFirestore firebaseFirestore=FirebaseFirestore.instance;


  @override
  Future<AppUser?> getCurrentUser() async {
    final firebaseUser=firebaseAuth.currentUser;

    if(firebaseUser==null){
      return null;
    }

    return AppUser(uid: firebaseUser.uid,
        email: firebaseUser.email!,
        name: '',
    );

  }

  @override
  Future<void> logOut() async{
    await firebaseAuth.signOut();
  }

  @override
  Future<AppUser?> loginWithEmailAndPassword(String email, String password) async {

    try{
      UserCredential userCredential=await firebaseAuth.signInWithEmailAndPassword
        (email: email, password: password);
      AppUser user=AppUser(
          uid: userCredential.user!.uid, email: email, name: ''
      );
      return user;
    }
    catch(e){
      throw Exception("$e");
    }
  }

  @override
  Future<AppUser?> register(String name, String email, String password) async{
    try{
      UserCredential userCredential=await firebaseAuth.createUserWithEmailAndPassword
        (email: email, password: password);

      AppUser user=AppUser(
          uid: userCredential.user!.uid, email: email, name: name,
      );
      await firebaseFirestore
          .collection("users")
          .doc(user.uid)
          .set(user.toJson());
      return user;
    }
    catch(e){
      throw Exception("$e");
    }
  }
}
