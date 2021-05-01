import 'package:equatable/equatable.dart';

class RegisterState extends Equatable {
  final bool isValidEmail;
  final bool isValidPassword;
  final bool isLoading;
  final bool isSuccess;
  final bool isFailure;

  bool isValidEmailAndPassword() => isValidEmail && isValidPassword;

  RegisterState({
    this.isValidPassword,
    this.isValidEmail,
    this.isLoading,
    this.isSuccess,
    this.isFailure,
  });

  factory RegisterState.initialize() {
    return RegisterState(
      isValidEmail: false,
      isValidPassword: false,
      isLoading: false,
      isSuccess: false,
      isFailure: false,
    );
  }

  factory RegisterState.loading() {
    return RegisterState(
      isValidEmail: true,
      isValidPassword: true,
      isLoading: true,
      isSuccess: false,
      isFailure: false,
    );
  }

  factory RegisterState.success() {
    return RegisterState(
      isValidEmail: true,
      isValidPassword: true,
      isLoading: false,
      isSuccess: true,
      isFailure: false,
    );
  }
  factory RegisterState.failure() {
    return RegisterState(
      isValidEmail: true,
      isValidPassword: true,
      isLoading: false,
      isSuccess: false,
      isFailure: true,
    );
  }

  RegisterState copyWith({
    bool isValidEmail,
    bool isValidPassword,
    bool isLoading,
    bool isSuccess,
    bool isFailure,
  }) {
    return RegisterState(
      isValidEmail: isValidEmail ?? this.isValidEmail,
      isValidPassword: isValidPassword ?? this.isValidPassword,
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
    );
  }

  RegisterState cloneAndUpdate({bool isValidEmail, bool isValidPassword}) {
    return copyWith(
      isValidEmail: isValidEmail ?? this.isValidEmail,
      isValidPassword: isValidPassword ?? this.isValidPassword,
      isLoading: false,
      isSuccess: false,
      isFailure: false,
    );
  }

  @override
  // TODO: implement props
  List<Object> get props =>
      [isValidEmail, isValidPassword, isLoading, isSuccess, isFailure];
}
