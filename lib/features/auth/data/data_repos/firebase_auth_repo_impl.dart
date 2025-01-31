import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/features/auth/domain/entities/user_entity.dart';
import 'package:e_commerce_app/features/auth/domain/repos/auth_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthRepoImpl implements AuthRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;




  @override
  Future<AppUser?> loginWithEmailAndPassword(String email,
      String password) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user != null) {
        return AppUser(
          uid: userCredential.user!.uid,
          name: userCredential.user!.displayName ?? '',
          email: userCredential.user!.email ?? '',
        );
      }
    } catch (e) {
      debugPrint("Error logging in: $e");
      throw Exception("Invalid email or password");
    }
    return null;
  }

  @override
  Future<AppUser?> register(String name, String email, String password) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user != null) {
        AppUser user = AppUser(
          uid: userCredential.user!.uid,
          name: name,
          email: email,
        );

        // Optionally, save user data to Firestore
        await firebaseFirestore.collection('users').doc(user.uid).set({
          'uid': user.uid,
          'name': user.name,
          'email': user.email,
        });

        return user;
      }
    } catch (e) {
      debugPrint("Error creating user: $e");
      throw Exception("Failed to create user");
    }
    return null;
  }

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
  }

  @override
  Future<void> logOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      debugPrint("Error logging out: $e");
      throw Exception("Failed to log out");
    }
  }
}