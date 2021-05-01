import 'package:authentication_and_weather/events/authentication_event.dart';
import 'package:authentication_and_weather/states/authentication_state.dart';
import 'package:authentication_and_weather/user_repository/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState>{
  // Cần user repository để thực hiện login _ logout
  final UserRepository _userRepository ;
  // State khi khởi tạo sẽ là Initialized
  AuthenticationBloc({@required UserRepository userRepository}) :
        assert(userRepository!=null),
        this._userRepository = userRepository,
        super(AuthenticationStateInitialize());

  @override
  Stream<AuthenticationState> mapEventToState(AuthenticationEvent authenticationEvent) async* {
    if(authenticationEvent is AuthenticationEventStarted){
      final isSignedIn = _userRepository.isSignedIn();
      if(isSignedIn){
        yield AuthenticationStateSuccess(user: _userRepository.getUser(),);
      }
      else{
        yield AuthenticationStateFailure();
      }
    }
    else if(authenticationEvent is AuthenticationEventLoggedIn){
      yield AuthenticationStateSuccess(user: _userRepository.getUser(),);
    }
    else if(authenticationEvent   is AuthenticationEventLoggedOut){
      try{
        await _userRepository.signOut();
        yield AuthenticationStateFailure();
      }
      catch(e){
        print(e);
      }
    }
  }
}