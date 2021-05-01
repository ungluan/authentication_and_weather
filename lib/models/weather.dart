class Weather {
  final String weatherStateName;
  final String weatherStateAbbr;
  final String applicableDate;
  final int woeid;
  final String title;
  final double theTemp;
  final double windSpeed;
  final double airPressure;
  final int humidity;
  final int predictability;

  Weather({
    this.woeid,
    this.title,
    this.weatherStateName,
    this.weatherStateAbbr,
    this.applicableDate,
    this.theTemp,
    this.windSpeed,
    this.airPressure,
    this.humidity,
    this.predictability,
  });

}
