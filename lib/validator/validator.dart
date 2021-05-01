import 'package:email_validator/email_validator.dart';

class Validator{
  static bool isValidEmail(String email){
    return EmailValidator.validate(email);
  }
  static bool isValidPassword(String password){
    return (password.isNotEmpty && password.length>6 && password.length<32);
  }
}