import 'package:equatable/equatable.dart';

abstract class SettingsState extends Equatable {}

enum TemperatureUnit { celsius, fahrenheit }

class SettingsStateTemperatureUnitCelsius extends SettingsState {
  final TemperatureUnit temperatureUnitCelsius = TemperatureUnit.celsius;

  @override
  // TODO: implement props
  List<Object> get props => [temperatureUnitCelsius];
}
class SettingsStateTemperatureUnitFahrenheit extends SettingsState{
  final TemperatureUnit temperatureUnitFahrenheit = TemperatureUnit.fahrenheit;

  @override
  // TODO: implement props
  List<Object> get props => [temperatureUnitFahrenheit];
}