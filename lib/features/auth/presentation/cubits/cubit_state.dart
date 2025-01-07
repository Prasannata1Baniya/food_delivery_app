import 'package:e_commerce_app/features/auth/domain/entities/user_entity.dart';
import 'package:flutter/cupertino.dart';

abstract class AuthState{}

class AuthInitialState extends AuthState{}

class LoadingState extends AuthState{}

class AuthenticatedState extends AuthState{
  final AppUser user;
  AuthenticatedState(this.user);
}

class UnAuthenticatedState extends AuthState{}

class  ErrorState extends AuthState{
  final String error;
  ErrorState(this.error);
}


