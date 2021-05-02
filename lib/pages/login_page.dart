import 'package:authentication_and_weather/Constants/colors_app.dart';
import 'package:authentication_and_weather/Constants/size_config.dart';
import 'package:authentication_and_weather/Widget/primary_button.dart';
import 'package:authentication_and_weather/Widget/social_media_button.dart';
import 'package:authentication_and_weather/blocs/authentication_bloc.dart';
import 'package:authentication_and_weather/blocs/login_bloc.dart';
import 'package:authentication_and_weather/blocs/register_bloc.dart';
import 'package:authentication_and_weather/events/authentication_event.dart';
import 'package:authentication_and_weather/events/login_event.dart';
import 'package:authentication_and_weather/pages/register_page.dart';
import 'package:authentication_and_weather/states/login_state.dart';
import 'package:authentication_and_weather/user_repository/user_repository.dart';
import 'package:authentication_and_weather/validator/validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginPages extends StatefulWidget {
  final UserRepository _userRepository;

  const LoginPages({@required UserRepository userRepository})
      : assert(userRepository != null),
        this._userRepository = userRepository;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPages> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  AuthenticationBloc authenticationBloc;
  bool enable = false;
  final formStateKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    authenticationBloc = BlocProvider.of<AuthenticationBloc>(context);

    emailController.addListener(() {
      BlocProvider.of<LoginBloc>(context).add(
        LoginEventEmailChanged(
          email: emailController.text,
        ),
      );
    });

    passwordController.addListener(() {
      BlocProvider.of<LoginBloc>(context).add(
        LoginEventPasswordChanged(
          password: passwordController.text,
        ),
      );
    });
  }

  String emailValidator(String inputEmail) {
    if (Validator.isValidEmail(inputEmail)) return null;
    return"Invalid email" ;
  }

  String passwordValidator(String inputPassword) {
    if (Validator.isValidPassword(inputPassword)) return null;
    return  "Invalid password" ;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, loginState) {
        if (loginState.isSuccess && widget._userRepository.isSignedIn() ) {
          enable = false;
          BlocProvider.of<AuthenticationBloc>(context).add(
            AuthenticationEventLoggedIn(),
          );
        }
        else if(loginState.isFailure){
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
                    loginState.isLoading ? Positioned(
                      top: SizeConfig.blocHeight/2,
                      left: SizeConfig.blocWidth/2,
                      bottom: SizeConfig.blocWidth/2,
                      right: SizeConfig.blocHeight/2,
                      child: Center(child: CircularProgressIndicator(
                        backgroundColor: ColorsApp.primaryColor,
                      ),),
                    ) : Text(''),
                    Column(
                      children: [
                        Center(
                          child: Text(
                            'Login Page',
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
                                  ? 'Email or password is incorrect':'' , style: TextStyle(fontSize: 14, color: Colors.red.shade600),
                            ),
                          ),
                        ),
                        SizedBox(height: 5*SizeConfig.blocHeight,),
                        PrimaryButton(
                          btnText: 'Login',
                          function: () {
                            if (formStateKey.currentState.validate()) {
                              BlocProvider.of<LoginBloc>(context).add(
                                LoginEventWithEmailAndPassword(
                                  email: emailController.text,
                                  password: passwordController.text,
                                ),
                              );
                            }
                          },
                        ),
                        SizedBox(height: 4*SizeConfig.blocHeight,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SocialMediaButton(
                              iconData: FontAwesomeIcons.googlePlus,
                              colorIcon: Colors.white,
                              backgroundColor: Colors.red,
                              function: () {
                                BlocProvider.of<LoginBloc>(context).add(LoginEventWithGoogleAccount());
                              },
                            ),
                            SocialMediaButton(
                              iconData: FontAwesomeIcons.facebook,
                              colorIcon: Colors.white,
                              backgroundColor: Colors.blueAccent,
                              function: () {
                                BlocProvider.of<LoginBloc>(context).add(LoginEventWithFacebookAccount());
                              },
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 32),
                          child: Divider(
                            color: ColorsApp.primaryColor,
                            thickness: 2,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Don\'t have an account?'),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => BlocProvider<RegisterBloc>(
                                      create: (context) => RegisterBloc(
                                          userRepository: widget._userRepository),
                                      child: BlocProvider.value(
                                        value: authenticationBloc,
                                        child: RegisterPage(),
                                      ),
                                    ),
                                  ),
                                );
                              },
                              child: Text(
                                'Register',
                                style: TextStyle(
                                  fontWeight: FontWeight.w900,
                                  color: ColorsApp.primaryColor,
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

