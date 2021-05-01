import 'package:authentication_and_weather/models/location.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class WeatherEvent extends Equatable {}

class WeatherEventStarted extends WeatherEvent {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class WeatherEventCityNameChanged extends WeatherEvent {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class WeatherEventResearched extends WeatherEvent {
  final String cityName;
  WeatherEventResearched({@required String cityName})
      : assert(cityName != null),
        this.cityName = cityName;

  @override
  // TODO: implement props
  List<Object> get props => [cityName];
}
// class WeatherEventResearchedFirst extends WeatherEvent{
//   @override
//   // TODO: implement props
//   List<Object> get props => [];
// }
