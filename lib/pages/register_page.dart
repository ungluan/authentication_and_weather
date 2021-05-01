import 'package:authentication_and_weather/Constants/colors_app.dart';
import 'package:authentication_and_weather/Widget/primary_button.dart';
import 'package:authentication_and_weather/blocs/authentication_bloc.dart';
import 'package:authentication_and_weather/blocs/register_bloc.dart';
import 'package:authentication_and_weather/events/authentication_event.dart';
import 'package:authentication_and_weather/events/register_event.dart';
import 'package:authentication_and_weather/states/register_state.dart';
import 'package:authentication_and_weather/validator/validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool enable = false;
  final formStateKey = GlobalKey<FormState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    emailController.addListener(() {
      BlocProvider.of<RegisterBloc>(context).add(
        RegisterEventEmailChanged(email: emailController.text),
      );
    });
    passwordController.addListener(() {
      BlocProvider.of<RegisterBloc>(context).add(
        RegisterEventPasswordChanged(password: passwordController.text),
      );
    });
  }
  String emailValidator(String email){
    if(Validator.isValidEmail(email)) return null;
    return 'Invalid email' ;
  }
  String passwordValidator(String password){
    if(Validator.isValidEmail(password)) return null;
    return 'Invalid password' ;
  }
  // Nếu equatable không xét đến isValidEmail và isValidPassword thì có tối ưu hơn không?
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, RegisterState>(
        builder: (context, registerState){
          if(registerState.isSuccess){
            enable = false;
            context.read<AuthenticationBloc>().add(AuthenticationEventLoggedIn(),);
            Navigator.pop(context);
          }
          else if(registerState.isFailure){
            enable = true;
            emailController.clear();
            passwordController.clear();
          }
          return Scaffold(
            resizeToAvoidBottomInset: false,
            body: Container(
              margin: EdgeInsets.symmetric(
                vertical: 50,
                horizontal: 32,
              ),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(
                      bottom: 20,
                    ),
                    child: Column(
                      children: [
                        Center(
                          child: Text(
                            'Register Page',
                            style: TextStyle(
                              color: ColorsApp.primaryColor,
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          padding: EdgeInsets.all(
                            20,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(300),
                            border: Border.all(
                              width: 2,
                              color: ColorsApp.primaryColor,
                            ),
                          ),
                          child: Image.asset(
                            'assets/images/water_drop.png',
                            color: ColorsApp.primaryColor,
                            scale: 3.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Form(
                    key: formStateKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: emailController,
                          validator: emailValidator,
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.email,
                              color: ColorsApp.primaryColor,
                            ),
                            hintText: 'Enter email',
                            labelText: 'Email',
                            hintStyle: TextStyle(
                              color: ColorsApp.primaryColor.withOpacity(0.6),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                50,
                              ),
                              borderSide: const BorderSide(
                                width: 2,
                                color: Colors.white54,
                                style: BorderStyle.solid,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.lock,
                              color: ColorsApp.primaryColor,
                            ),
                            hintText: 'Enter password',
                            labelText: 'Password',
                            hintStyle: TextStyle(
                              color: ColorsApp.primaryColor.withOpacity(0.6),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                50,
                              ),
                              borderSide: const BorderSide(
                                width: 2,
                                style: BorderStyle.solid,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  registerState.isLoading ? CircularProgressIndicator(
                    backgroundColor: ColorsApp.primaryColor,
                  ) : Container(),
                  SizedBox(height: 40,),
                  Padding(
                    padding: EdgeInsets.only(left: 16),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        enable
                            ? 'Email already exists':'' , style: TextStyle(fontSize: 14, color: Colors.red.shade600),
                      ),
                    ),
                  ),
                  SizedBox(height: 40,),
                  PrimaryButton(
                    btnText: 'Register',
                    function: () {
                      BlocProvider.of<RegisterBloc>(context).add(
                        RegisterEventWithEmailAndPassword(
                          email: emailController.text,
                          password: passwordController.text,
                        ),
                      );
                    },
                  ),
                  Expanded(
                    child: SizedBox(
                      height: 20,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Already have an account?'),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          'Login',
                          style: TextStyle(
                            color: ColorsApp.primaryColor,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
    );
  }
}
