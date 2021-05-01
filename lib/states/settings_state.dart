import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

enum TemperatureUnit { celsius, fahrenheit }

class SettingsState extends Equatable {
  final TemperatureUnit temperatureUnit;

  SettingsState({
    @required this.temperatureUnit,
  }):assert(temperatureUnit!=null);

  @override
  // TODO: implement props
  List<Object> get props => [temperatureUnit];
}
