import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable{}

// EmailChanged
class LoginEventEmailChanged extends LoginEvent {
  final String email;
  LoginEventEmailChanged({this.email});

  @override
  // TODO: implement props
  List<Object> get props => [email];
}
// PasswordChanged
class LoginEventPasswordChanged extends LoginEvent {
  final String password;
  LoginEventPasswordChanged({this.password});

  @override
  // TODO: implement props
  List<Object> get props => [password];
}
class LoginEventWithEmailAndPassword extends LoginEvent{
  final String email;
  final String password;
  LoginEventWithEmailAndPassword({this.email , this.password});
  @override
  // TODO: implement props
  List<Object> get props => [email,password];
}
class LoginEventWithGoogleAccount extends LoginEvent{
  @override
  // TODO: implement props
  List<Object> get props => [DateTime.now()];
}
class LoginEventWithFacebookAccount extends LoginEvent{
  @override
  // TODO: implement props
  List<Object> get props => [DateTime.now()];
}
