enum WeatherStateName {
  snow,
  sleet,
  hail,
  thunderstorm,
  heavyRain,
  lightRain,
  showers,
  heavyCloud,
  lightCloud,
  clear,
}

class Weather {
  final int id;
  final String weatherStateName;
  final String weatherStateAbbr;
  final String applicableDate;
  final int woeid;
  final String title;
  final double minTemp;
  final double maxTemp;
  final double theTemp;
  final double windSpeed;
  final double windDirection;
  final double airPressure;
  final int humidity;
  final int predictability;
  Weather({
    this.id,
    this.woeid,
    this.title,
    this.weatherStateName,
    this.weatherStateAbbr,
    this.applicableDate,
    this.minTemp,
    this.maxTemp,
    this.theTemp,
    this.windSpeed,
    this.windDirection,
    this.airPressure,
    this.humidity,
    this.predictability,
  });
}
