import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

abstract class AuthenticationState extends Equatable{}

class AuthenticationStateInitialize extends AuthenticationState{
  @override
  // TODO: implement props
  List<Object> get props => [];
}
class AuthenticationStateSuccess extends AuthenticationState{
  final User _user;
  AuthenticationStateSuccess({@required User user}):
      assert(user!=null),
      this._user = user;

  @override
  // TODO: implement props
  List<Object> get props => [_user , DateTime.now()];
}
class AuthenticationStateFailure extends AuthenticationState{
  @override
  // TODO: implement props
  List<Object> get props => [];
}