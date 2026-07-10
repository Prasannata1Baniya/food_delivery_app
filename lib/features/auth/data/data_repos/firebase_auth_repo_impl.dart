import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/features/auth/domain/entities/user_entity.dart';
import 'package:e_commerce_app/features/auth/domain/repos/auth_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthRepoImpl implements AuthRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  @override
  Future<AppUser?> loginWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user != null) {
        final uid = userCredential.user!.uid;

        final userDoc = await _firebaseFirestore.collection('users').doc(uid).get();

        String fetchedName = userCredential.user!.displayName ?? '';
        if (userDoc.exists && userDoc.data() != null) {
          fetchedName = userDoc.data()?['name'] ?? fetchedName;
        }

        return AppUser(
          uid: uid,
          name: fetchedName,
          email: userCredential.user!.email ?? email,
        );
      }
    } on FirebaseAuthException catch (e) {
      debugPrint("Firebase Login Error: ${e.code} - ${e.message}");
      if (e.code == 'user-not-found' || e.code == 'wrong-password' || e.code == 'invalid-credential') {
        throw Exception("Incorrect email or password. Please try again.");
      }
      throw Exception(e.message ?? "An error occurred during sign in.");
    } catch (e) {
      debugPrint("General Login Error: $e");
      throw Exception("Something went wrong. Please check your internet connection.");
    }
    return null;
  }

  @override
  Future<AppUser?> register(String name, String email, String password) async {
    try {
      UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user != null) {
        await userCredential.user!.updateDisplayName(name);

        AppUser user = AppUser(
          uid: userCredential.user!.uid,
          name: name,
          email: email,
        );

        await _firebaseFirestore.collection('users').doc(user.uid).set({
          'uid': user.uid,
          'name': user.name,
          'email': user.email,
          'createdAt': FieldValue.serverTimestamp(),
          'deliveryAddresses': [],
        });

        return user;
      }
    } on FirebaseAuthException catch (e) {
      debugPrint("Firebase Registration Error: ${e.code} - ${e.message}");
      if (e.code == 'email-already-in-use') {
        throw Exception("This email address is already registered.");
      } else if (e.code == 'weak-password') {
        throw Exception("The password provided is too weak.");
      }
      throw Exception(e.message ?? "Failed to create account.");
    } catch (e) {
      debugPrint("General Registration Error: $e");
      throw Exception("An unexpected error occurred during signup.");
    }
    return null;
  }

  @override
  Future<AppUser?> getCurrentUser() async {
    try {
      User? user = _firebaseAuth.currentUser;

      if (user != null) {
        final userDoc = await _firebaseFirestore.collection('users').doc(user.uid).get();
        String currentName = user.displayName ?? '';

        if (userDoc.exists && userDoc.data() != null) {
          currentName = userDoc.data()?['name'] ?? currentName;
        }

        return AppUser(
          uid: user.uid,
          email: user.email ?? '',
          name: currentName,
        );
      }
    } catch (e) {
      debugPrint("Error fetching current user: $e");
      return null;
    }
    return null;
  }

  @override
  Future<void> logOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      debugPrint("Error logging out: $e");
      throw Exception("Failed to log out cleanly.");
    }
  }
}