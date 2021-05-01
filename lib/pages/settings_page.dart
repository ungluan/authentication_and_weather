import 'package:authentication_and_weather/blocs/settings_bloc.dart';
import 'package:authentication_and_weather/events/settings_event.dart';
import 'package:authentication_and_weather/states/settings_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsBloc, SettingsState>(
      builder: (context, settingsState) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Settings'),
            centerTitle: true,
          ),
          body: Container(
            padding: EdgeInsets.only(top: 32, left: 16, right: 16, bottom: 16),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Celsius',
                    ),
                    Switch(
                        value:
                            settingsState.temperatureUnit == TemperatureUnit.celsius
                                ? true
                                : false,
                        onChanged: (value) {
                          BlocProvider.of<SettingsBloc>(context).add(SettingEventTemperatureUnitChanged());
                        },
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
