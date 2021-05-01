import 'package:authentication_and_weather/events/settings_event.dart';
import 'package:authentication_and_weather/states/settings_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc():
        super(
          SettingsStateTemperatureUnitCelsius(),
        );

  @override
  Stream<SettingsState> mapEventToState(SettingsEvent settingsEvent) async* {
    if (settingsEvent is SettingEventTemperatureUnitChanged) {
      if (state is SettingsStateTemperatureUnitCelsius)
        yield SettingsStateTemperatureUnitFahrenheit();
      else
        yield SettingsStateTemperatureUnitCelsius();
    }
  }
}
