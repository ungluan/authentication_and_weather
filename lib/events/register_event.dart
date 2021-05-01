import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class RegisterEvent extends Equatable{}

class RegisterEventEmailChanged extends RegisterEvent{
  final String email;
  RegisterEventEmailChanged({@required this.email});
  @override
  // TODO: implement props
  List<Object> get props => [email];
}
class RegisterEventPasswordChanged extends RegisterEvent{
  final String password;
  RegisterEventPasswordChanged({@required this.password});

  @override
  // TODO: implement props
  List<Object> get props => [password];
}
class RegisterEventWithEmailAndPassword extends RegisterEvent{
  final String email;
  final String password;

  RegisterEventWithEmailAndPassword({@required this.email,@required this.password});

  @override
  // TODO: implement props
  List<Object> get props => [email, password];
}