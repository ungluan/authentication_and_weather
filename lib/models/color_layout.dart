import 'package:flutter/material.dart';

class ColorLayout {
  final Color backgroundColor;
  final Color textColor;

  ColorLayout({this.backgroundColor, this.textColor});

  static ColorLayout getColorsContainer(String weatherStateName) {
    if (weatherStateName == 'Snow' ||
        weatherStateName == 'Sleet' ||
        weatherStateName == 'Hail') {
      return ColorLayout(
        backgroundColor: Color(0xFF184b59),
        textColor: Colors.white,
      );
    } else if (weatherStateName == 'Thunderstorm') {
      return ColorLayout(
        backgroundColor: Color(0xFFFFFF00),
        textColor: Colors.black,
      );
    } else if (weatherStateName == 'Heavy Rain') {
      return ColorLayout(
        backgroundColor: Color(0xFF2F3484),
        textColor: Colors.white,
      ); //303c75 // 094479
    } else if (weatherStateName == 'Light Rain') {
      return ColorLayout(
        backgroundColor: Color(0xFF2DAAD8),
        textColor: Colors.white,
      ); //A08555
    } else if (weatherStateName == 'Showers') {
      return ColorLayout(
        backgroundColor: Color(0xff29926e),
        textColor: Colors.black,
      ); //
    } else if (weatherStateName == 'LightCloud' || weatherStateName == 'Clear') {
      return ColorLayout(
        backgroundColor: Color(0xFFFFA249),
        textColor: Colors.black,
      );
    } else if (weatherStateName == 'HeavyCloud')
      return ColorLayout(
        backgroundColor: Colors.white,
        textColor: Colors.black,
      );
    return ColorLayout(
      backgroundColor: Colors.white,
      textColor: Colors.black,
    );
  }
}
