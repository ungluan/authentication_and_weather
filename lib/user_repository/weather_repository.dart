import 'dart:convert';

import 'package:authentication_and_weather/models/location.dart';
import 'package:authentication_and_weather/models/weather.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

String uriCityName(String city) =>
    'https://www.metaweather.com/api/location/search/?query=$city';
String uriLocation(int location) =>
    'https://www.metaweather.com/api/location/$location/';
String uriPosition(Location location) =>
    'https://www.metaweather.com/api/location/search/?lattlong=${location.latitude},${location.longitude}';

class WeatherRepositories {
  final Location location;
  final http.Client httpCline;
  WeatherRepositories({@required this.httpCline, @required Location location})
      : assert(httpCline != null),
        assert(location != null),
        this.location = location;
  // Get location from cityName

  Future<int> getLocationIdFromPosition(Location location) async {
    try {
      var response = await httpCline.get(Uri.parse(uriPosition(location)));
      if (response.statusCode == 200) {
        final cities = jsonDecode(response.body);
        return cities[0]['woeid'];
      }
    } catch (e) {
      print('Error occurred: $e');
      return -1;
    }
    return -1;
  }

  Future<int> getLocationIdFromCityName(String cityName) async {
    try {
      var response = await httpCline.get(
        Uri.parse(
          uriCityName(cityName),
        ),
      );
      if (response.statusCode == 200) {
        final cities = jsonDecode(response.body);
        return cities[0]['woeid'];
      }
    } catch (e) {
      print('Error occurred: $e');
      return -1;
    }
    return -1;
  }

  Future<List<Weather>> getWeatherDataFromLocationId(int location) async {
    if (location == -1) return null;
    List<Weather> list = [];
    var response = await http.get(Uri.parse(uriLocation(location)));
    if (response.statusCode == 200) {
      var dataDecode = jsonDecode(response.body);
      int position = 0;
      var data = dataDecode['consolidated_weather'];
      while (position < data.length) {
        var values = data[position];
        var weather = Weather(
          title: dataDecode['title'],
          woeid: dataDecode['woeid'],
          weatherStateName: values['weather_state_name'],
          weatherStateAbbr: values['weather_state_abbr'],
          applicableDate: values['applicable_date'],
          theTemp: values['the_temp'],
          windSpeed: values['wind_speed'],
          airPressure: values['air_pressure'],
          humidity: values['humidity'],
          predictability: values['predictability'],
        );
        list.add(weather);
        position++;
      }
      return list;
    }
    return null;
  }

  Future<List<Weather>> fetchDataWeathers(
      {String cityName, Location location}) async {
    int locationId = cityName != null
        ? await getLocationIdFromCityName(cityName)
        : await getLocationIdFromPosition(location);
    return await getWeatherDataFromLocationId(locationId);
  }
}
