import 'package:authentication_and_weather/events/login_event.dart';
import 'package:authentication_and_weather/states/login_state.dart';
import 'package:authentication_and_weather/user_repository/user_repository.dart';
import 'package:authentication_and_weather/validator/validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepository _userRepository;
  LoginBloc({@required UserRepository userRepository})
      : assert(userRepository != null),
        this._userRepository = userRepository,
        super(LoginState.initialize());

  @override
  Stream<LoginState> mapEventToState(LoginEvent loginEvent) async* {
    if (loginEvent is LoginEventEmailChanged) {
      String email = loginEvent.email;
      yield state.cloneAndUpdate(
        isValidEmail: Validator.isValidEmail(email),
      );
    } else if (loginEvent is LoginEventPasswordChanged) {
      String password = loginEvent.password;
      yield state.cloneAndUpdate(
        isValidPassword: Validator.isValidPassword(password),
      );
    } else if (loginEvent is LoginEventWithEmailAndPassword) {
      if (state.isValidEmailAndPassword()) {
        yield LoginState.loading();
        final userCredential = await _userRepository.signInWithEmailAndPassword(
            loginEvent.email, loginEvent.password);
        if (userCredential != null)
          yield LoginState.success();
        else {
          print('Email or password is incorrect');
          yield LoginState.failure();
        }
      } else {
        print('Email or password is incorrect format');
        yield LoginState.failure();
      }
    } else if (loginEvent is LoginEventWithGoogleAccount) {
      yield LoginState.loading();
      var userCredential = await _userRepository.signInWithGoogle();
      if (userCredential != null) {
        yield LoginState.success();
      } else
        yield LoginState.failure();
    } else if (loginEvent is LoginEventWithFacebookAccount) {
      yield LoginState.loading();
      var user = await _userRepository.signInWithFacebook();
      if (user != null) {
        yield LoginState.success();
      } else
        yield LoginState.failure();
    }
  }
}
