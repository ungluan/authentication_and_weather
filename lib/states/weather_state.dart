import 'package:authentication_and_weather/models/location.dart';
import 'package:authentication_and_weather/models/weather.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class WeatherState extends Equatable{}

class WeatherStateCityNameChanged extends WeatherState{
  @override
  // TODO: implement props
  List<Object> get props => [];
}
class WeatherStateInitialize extends WeatherState{
  WeatherStateInitialize();
  @override
  // TODO: implement props
  List<Object> get props => [];
}
class WeatherStateResearchSuccess extends WeatherState {
  final List<Weather> listWeather;

  WeatherStateResearchSuccess({this.listWeather});

  @override
  // TODO: implement props
  List<Object> get props => [listWeather];
}
class WeatherStateLoading extends WeatherState{
  @override
  // TODO: implement props
  List<Object> get props => [];
}
class WeatherStateResearchFailure extends WeatherState{
  @override
  // TODO: implement props
  List<Object> get props => [];
}