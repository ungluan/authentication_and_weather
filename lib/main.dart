import 'package:authentication_and_weather/Constants/colors_app.dart';
import 'package:authentication_and_weather/Constants/size_config.dart';
import 'package:authentication_and_weather/blocs/login_bloc.dart';
import 'package:authentication_and_weather/blocs/register_bloc.dart';
import 'package:authentication_and_weather/blocs/settings_bloc.dart';
import 'package:authentication_and_weather/blocs/weather_bloc.dart';
import 'package:authentication_and_weather/events/authentication_event.dart';
import 'package:authentication_and_weather/models/location.dart';
import 'package:authentication_and_weather/pages/login_page.dart';
import 'package:authentication_and_weather/pages/weather_page.dart';
import 'package:authentication_and_weather/states/authentication_state.dart';
import 'package:authentication_and_weather/user_repository/user_repository.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:authentication_and_weather/user_repository/weather_repository.dart';
import 'package:http/http.dart' as http;
import 'blocs/authentication_bloc.dart';

Location location = Location();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await location.getCurrentPosition();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((_) => runApp(MyApp()));
  // runApp(MyApp());
}



class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  final UserRepository _userRepository = UserRepository();
  final WeatherRepositories _weatherRepositories =
      WeatherRepositories(httpCline: http.Client(), location: location);


  @override
  Widget build(BuildContext context) {

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        SizeConfig().init(constraints);
        print(SizeConfig.maxWidth);
        print(SizeConfig.maxHeight);
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(fontFamily: 'Nunito'),
          home: MultiBlocProvider(
            providers: [
              // import 3 bloc: authentication, login, register
              BlocProvider<AuthenticationBloc>(
                create: (context) =>
                AuthenticationBloc(userRepository: _userRepository)
                  ..add(AuthenticationEventStarted()),
              ),
              BlocProvider<LoginBloc>(
                create: (context) => LoginBloc(userRepository: _userRepository),
              ),
              BlocProvider<RegisterBloc>(
                create: (context) => RegisterBloc(userRepository: _userRepository),
              ),
            ],
            child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
              builder: (context, authenticationState) {
                if (authenticationState is AuthenticationStateSuccess) {
                  return BlocProvider<WeatherBloc>(
                    create: (context) =>
                        WeatherBloc(weatherRepositories: _weatherRepositories),
                    child: BlocProvider<SettingsBloc>(
                      create: (context) => SettingsBloc(),
                      child: WeatherPage(
                        userRepository: _userRepository,
                      ),
                    ),
                  );
                } else if (authenticationState is AuthenticationStateFailure) {
                  return LoginPages(
                    userRepository: _userRepository,
                  );
                } else
                  return Scaffold(
                    body: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(
                            backgroundColor: ColorsApp.primaryColor,
                          ),
                          Text(
                            'Loading...',
                            style: TextStyle(
                              fontSize: 24,
                              color: ColorsApp.primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
              },
            ),
          ),
        );
      },
    );
  }
}
