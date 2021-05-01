import 'package:authentication_and_weather/Constants/colors_app.dart';
import 'package:authentication_and_weather/blocs/authentication_bloc.dart';
import 'package:authentication_and_weather/blocs/settings_bloc.dart';
import 'package:authentication_and_weather/blocs/weather_bloc.dart';
import 'package:authentication_and_weather/events/authentication_event.dart';
import 'package:authentication_and_weather/events/weather_event.dart';
import 'package:authentication_and_weather/models/ColorsContainer.dart';
import 'package:authentication_and_weather/pages/researchable_city_page.dart';
import 'package:authentication_and_weather/pages/settings_page.dart';
import 'package:authentication_and_weather/states/authentication_state.dart';
import 'package:authentication_and_weather/states/settings_state.dart';
import 'package:authentication_and_weather/states/weather_state.dart';
import 'package:authentication_and_weather/user_repository/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class WeatherPage extends StatelessWidget {
  final UserRepository userRepository;

  WeatherPage({UserRepository userRepository})
      : assert(userRepository != null),
        this.userRepository = userRepository;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, authenticationState) {
        if (authenticationState is AuthenticationStateSuccess) {
          return BlocBuilder<SettingsBloc, SettingsState>(
            builder: (context, settingsState) {
              final settingsBloc = BlocProvider.of<SettingsBloc>(context);
              return Scaffold(
                resizeToAvoidBottomInset: false,
                drawer: Drawer(
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.only(top: 40, left: 16, bottom: 2),
                        child: Row(
                          children: [
                            CircleAvatar(
                              foregroundImage:
                                  AssetImage('assets/images/avata_cat.png'),
                              radius: 32,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  userRepository.getUser().email,
                                  style: TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        color: Colors.black38,
                        thickness: 2,
                      ),
                      Expanded(
                        child: ListView(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => BlocProvider.value(
                                      value: settingsBloc,
                                      child: SettingsPage(),
                                    ),
                                  ),
                                );
                              },
                              child: ListTile(
                                leading: Icon(
                                  Icons.settings,
                                  color: ColorsApp.primaryColor,
                                  size: 32,
                                ),
                                title: Text(
                                  'Settings',
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                BlocProvider.of<AuthenticationBloc>(context)
                                    .add(AuthenticationEventLoggedOut());
                              },
                              child: ListTile(
                                leading: Icon(
                                  FontAwesomeIcons.signOutAlt,
                                  color: ColorsApp.primaryColor,
                                ),
                                title: Text(
                                  'Sign out',
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                appBar: AppBar(
                  backgroundColor: ColorsApp.primaryColor,
                  title: Text(
                    'Weather Page', /*style: TextStyle(color: themeStateColor.textColor)*/
                  ),
                  centerTitle: true,
                  actions: [
                    IconButton(
                      icon: Icon(FontAwesomeIcons.search),
                      onPressed: () async {
                        final cityName = await Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => ResearchCityPage(),
                          ),
                        );
                        if (cityName != "" && cityName != null) {
                          BlocProvider.of<WeatherBloc>(context).add(
                            WeatherEventResearched(cityName: cityName),
                          );
                        }
                      },
                    ),
                  ],
                ),
                body: BlocBuilder<WeatherBloc, WeatherState>(
                  builder: (context, weatherState) {
                    if (weatherState is WeatherStateResearchSuccess) {
                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: weatherState.listWeather.length,
                        itemBuilder: (context, index) {
                          ColorsContainer colors = ColorsContainer.getColorsContainer(
                              weatherState.listWeather[index].weatherStateAbbr,
                          );
                          print(weatherState.listWeather[index].weatherStateAbbr);
                          return Container(
                            padding: EdgeInsets.symmetric(horizontal: 32, vertical: 32,),
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height,
                            decoration: BoxDecoration(
                              color: colors.backgroundColor,
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(width: 2, color: colors.textColor),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              padding: EdgeInsets.all(16),
                              child: Column(
                                children: [
                                  Text(
                                    weatherState.listWeather[index].title,
                                    style: TextStyle(
                                      color: colors.textColor,
                                      fontSize: 30,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Align(
                                      alignment: Alignment.topRight,
                                      child: Text(
                                        'Date: ' +
                                            weatherState.listWeather[index]
                                                .applicableDate,
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: colors.textColor,
                                        ),
                                      )),
                                  SizedBox(
                                    height: 40,
                                  ),
                                  Container(
                                    height: 100,
                                    width: 100,
                                    child: SvgPicture.asset(
                                      'assets/images/${weatherState.listWeather[index].weatherStateAbbr}.svg',
                                    ),
                                  ),
                                  BlocBuilder<SettingsBloc, SettingsState>(
                                    builder: (context, settingsState) {
                                      int value = weatherState
                                          .listWeather[index].theTemp
                                          .toInt();
                                      if (settingsState
                                          is SettingsStateTemperatureUnitCelsius) {
                                        return Text(
                                          '$value°C',
                                          style: TextStyle(
                                            fontSize: 70,
                                            color: colors.textColor,
                                          ),
                                        );
                                      }
                                      value = (value * 9 / 5 + 32).toInt();
                                      return Text(
                                        '$value°F',
                                        style: TextStyle(
                                          fontSize: 70,
                                          color: colors.textColor,
                                        ),
                                      );
                                    },
                                  ),
                                  Text(
                                    weatherState
                                        .listWeather[index].weatherStateName,
                                    style: TextStyle(
                                      color: colors.textColor,
                                      fontSize: 24,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 40,
                                  ),
                                  Container(
                                    height: 200,
                                    width: MediaQuery.of(context).size.width,
                                    padding: EdgeInsets.symmetric(
                                        vertical: 20, horizontal: 16),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16),
                                      border: Border.all(color: colors.textColor, width: 2),
                                    ),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Column(
                                              // mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Humidity',
                                                  style: TextStyle(
                                                      color: Colors.white54,
                                                      ),
                                                ),
                                                Text(
                                                  '${weatherState.listWeather[index].humidity}%',
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                    color: colors.textColor,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Pressure',
                                                  style: TextStyle(
                                                    color: Colors.white54,
                                                      ),
                                                ),
                                                Text(
                                                  '${weatherState.listWeather[index].airPressure}mbar',
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                    color: colors.textColor,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Column(
                                              // mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Wind speed',
                                                  style: TextStyle(
                                                    color: Colors.white54,
                                                  ),
                                                ),
                                                Text(
                                                  '${weatherState.listWeather[index].windSpeed.toInt()}km/h',
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                    color: colors.textColor,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Predictability',
                                                  style: TextStyle(
                                                    color: Colors.white54,
                                                  ),
                                                ),
                                                Text(
                                                  '${weatherState.listWeather[index].predictability}%',
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                    color: colors.textColor,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),

                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    } else if (weatherState is WeatherStateResearchFailure) {
                      return Center(
                        child: Text(
                          'City not found',
                          style: TextStyle(
                            fontSize: 32,
                            color: Colors.red,
                          ),
                        ),
                      );
                    } else if (weatherState is WeatherStateLoading) {
                      return Container(
                        child: Center(
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
                    }
                    BlocProvider.of<WeatherBloc>(context)
                        .add(WeatherEventResearchedFirst());
                    return Container(
                      child: Center(
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
              );
            },
          );
        }
        return Container();
      },
    );
  }
}
