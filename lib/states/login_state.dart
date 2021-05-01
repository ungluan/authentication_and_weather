import 'package:equatable/equatable.dart';

class LoginState extends Equatable{

  final bool isValidEmail;
  final bool isValidPassword;
  final bool isLoading;
  final bool isSuccess;
  final bool isFailure;


  LoginState({this.isLoading, this.isSuccess, this.isFailure, this.isValidEmail, this.isValidPassword });

  bool isValidEmailAndPassword() => isValidEmail && isValidPassword;
  factory LoginState.initialize(){
    return LoginState(
      isValidEmail: false,
      isValidPassword: false,
      isLoading: false,
      isSuccess: false,
      isFailure: false,
    );
  }
  factory LoginState.loading(){
    return LoginState(
      isValidEmail: true,
      isValidPassword: true,
      isLoading: true,
      isSuccess: false,
      isFailure: false,
    );
  }
  factory LoginState.success(){
    return LoginState(
      isValidEmail: true,
      isValidPassword: true,
      isLoading: false,
      isSuccess: true,
      isFailure: false,
    );
  }
  factory LoginState.failure(){
    return LoginState(
      isValidEmail: true,
      isValidPassword: true,
      isLoading: false,
      isSuccess: false,
      isFailure: true,
    );
  }

  LoginState copyWith({bool isValidEmail, bool isValidPassword, bool isLoading, bool isSuccess, bool isFailure}){
    return LoginState(
      isValidEmail: isValidEmail ?? this.isValidEmail ,
      isValidPassword: isValidPassword ?? this.isValidPassword,
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
    );
  }

  // Dùng để cập nhật lại password và email
  LoginState cloneAndUpdate({
    bool isValidEmail,
    bool isValidPassword,
  }){
    return copyWith(
      isValidEmail: isValidEmail,
      isValidPassword: isValidPassword,
      isLoading: false,
      isFailure: false,
      isSuccess: false,
    );
  }

  @override
  // TODO: implement props
  List<Object> get props => [isValidEmail, isValidPassword, isLoading, isSuccess, isFailure];
}