import 'package:authentication_and_weather/events/register_event.dart';
import 'package:authentication_and_weather/states/register_state.dart';
import 'package:authentication_and_weather/user_repository/user_repository.dart';
import 'package:authentication_and_weather/validator/validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  UserRepository _userRepository;
  RegisterBloc({@required UserRepository userRepository})
      : assert(userRepository != null),
        this._userRepository = userRepository,
        super(RegisterState.initialize());

  @override
  Stream<RegisterState> mapEventToState(RegisterEvent registerEvent) async* {
    if (registerEvent is RegisterEventEmailChanged) {
      String email = registerEvent.email;
      yield state.cloneAndUpdate(
        isValidEmail: Validator.isValidEmail(email),
      );
    } else if (registerEvent is RegisterEventPasswordChanged) {
      String password = registerEvent.password;
      yield state.cloneAndUpdate(
        isValidPassword: Validator.isValidPassword(password),
      );
    } else if (registerEvent is RegisterEventWithEmailAndPassword) {
      if (state.isValidEmailAndPassword()) {
        yield RegisterState.loading();
        try {
          await _userRepository.createUserWithEmailAndPassword(
            registerEvent.email,
            registerEvent.password,
          );
          await _userRepository.signInWithEmailAndPassword(
            registerEvent.email,
            registerEvent.password,
          );
          yield RegisterState.success();
        } catch (e) {
          yield RegisterState.failure();
        }
      }
    } else {
      print('Email or password is incorrect format');
      yield RegisterState.failure();
    }
  }
}
