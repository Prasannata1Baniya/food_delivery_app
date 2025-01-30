import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/features/auth/domain/entities/user_entity.dart';
import 'package:e_commerce_app/features/auth/domain/repos/auth_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthRepoImpl implements AuthRepository{
  final FirebaseAuth _firebaseAuth=FirebaseAuth.instance;
  final  FirebaseFirestore firebaseFirestore=FirebaseFirestore.instance;


  @override
  Future<AppUser?> getCurrentUser() async {
    try {
      User? user = _firebaseAuth.currentUser;

      if (user != null) {
        return AppUser(
          uid: user.uid,
          email: user.email ?? '',
          name: user.displayName ?? '',
        );
      }
    } catch (e) {
      debugPrint("Error fetching current user: $e");
      throw Exception("Failed to fetch current user");
    }
    return null;
    /*
    final firebaseUser=_firebaseAuth.currentUser;
    if(firebaseUser==null){
      return null;
    }
    return AppUser(uid: firebaseUser.uid,
        email: firebaseUser.email!,
        name: '',
    );
    */
  }

  @override
  Future<void> logOut() async{
    await _firebaseAuth.signOut();
  }

  @override
  Future<AppUser?> loginWithEmailAndPassword(String email, String password) async {

    try{
      UserCredential userCredential=await _firebaseAuth.signInWithEmailAndPassword
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
    try {
      UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword
        (email: email, password: password);

      if (userCredential.user != null) {
        AppUser user = AppUser(
          uid: userCredential.user!.uid, email: email, name: name,
        );
        await firebaseFirestore
            .collection("users")
            .doc(user.uid)
            .set(user.toJson());
        return user;
      }
    }
    catch(e){
      throw Exception("$e");
    }
    return null;
  }
}
