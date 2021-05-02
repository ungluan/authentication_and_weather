import 'package:authentication_and_weather/Constants/colors_app.dart';
import 'package:authentication_and_weather/Constants/size_config.dart';
import 'package:authentication_and_weather/Widget/primary_button.dart';
import 'package:authentication_and_weather/blocs/authentication_bloc.dart';
import 'package:authentication_and_weather/blocs/register_bloc.dart';
import 'package:authentication_and_weather/events/authentication_event.dart';
import 'package:authentication_and_weather/events/register_event.dart';
import 'package:authentication_and_weather/states/register_state.dart';
import 'package:authentication_and_weather/validator/validator.dart';
import 'package:flutter/cupertino.dart';
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
            body: ListView(
              children: [
                SafeArea(
                  child: Stack(
                    children: [
                      registerState.isLoading ? Positioned(
                        top: SizeConfig.blocHeight/2,
                        left: SizeConfig.blocWidth/2,
                        bottom: SizeConfig.blocWidth/2,
                        right: SizeConfig.blocHeight/2,
                        child: Center(
                          child: CircularProgressIndicator(
                            backgroundColor: ColorsApp.primaryColor,
                          ),
                        ),
                      ) : Text('') ,
                      Column(
                        children: [
                          Center(
                            child: Text(
                              'Register Page',
                              style: TextStyle(
                                color: ColorsApp.primaryColor,
                                fontSize: 6*SizeConfig.blocHeight,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 32, right: 32, top: 12, bottom: 12),
                            padding: EdgeInsets.all(12),
                            height: 25*SizeConfig.blocHeight,
                            decoration: BoxDecoration(
                              // borderRadius: BorderRadius.all(Radius.circular(300)),
                              border: Border.all(
                                width: 2,
                                color: ColorsApp.primaryColor,
                              ),
                              shape: BoxShape.circle,
                            ),
                            child: Image.asset(
                              'assets/images/water_drop.png',
                              color: ColorsApp.primaryColor,
                              fit: BoxFit.contain,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 32),
                            child: Form(
                              key: formStateKey,
                              child: Column(
                                children: [
                                  TextFormField(
                                    controller: emailController,
                                    validator: emailValidator,
                                    keyboardType: TextInputType.emailAddress,
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
                                          20,
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
                                    obscureText: true,
                                    controller: passwordController,
                                    validator: passwordValidator,
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
                                          20,
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
                          ),
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
                          SizedBox(height: 12*SizeConfig.blocHeight),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 32),
                            child: Divider(
                              thickness: 2,
                              color: ColorsApp.primaryColor,
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
                    ],
                  ),
                ),
              ],
            ),
          );
        },
    );
  }
}
