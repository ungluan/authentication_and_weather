import 'package:authentication_and_weather/events/weather_event.dart';
import 'package:authentication_and_weather/states/weather_state.dart';
import 'package:authentication_and_weather/user_repository/weather_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepositories _weatherRepositories;
  WeatherBloc({@required WeatherRepositories weatherRepositories})
      : assert(weatherRepositories != null),
        this._weatherRepositories = weatherRepositories,
        super(WeatherStateInitialize());

  @override
  Stream<WeatherState> mapEventToState(WeatherEvent weatherEvent) async* {
    if (weatherEvent is WeatherEventCityNameChanged) {
      yield WeatherStateCityNameChanged();
    }
    else if(weatherEvent is WeatherEventResearchedFirst){
      yield WeatherStateLoading();
      final listWeather = await _weatherRepositories.fetchDataWeather(_weatherRepositories.location);
      if(listWeather!=null){
        yield WeatherStateResearchSuccess(listWeather: listWeather );
      }
      else yield WeatherStateResearchFailure();
    }
    else if (weatherEvent is WeatherEventResearched) {
      yield WeatherStateLoading();
      final listWeather =
          await _weatherRepositories.fetchDataWeathers(weatherEvent.cityName);
      if (listWeather != null) {
        yield WeatherStateResearchSuccess(listWeather: listWeather);
      }
      else
        yield WeatherStateResearchFailure();
    }
    else if (weatherEvent is WeatherEventStarted)
      yield WeatherStateInitialize();
  }
}
