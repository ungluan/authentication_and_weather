import 'package:flutter/material.dart';

enum AbbrWeather { sn, sl, h, t, hr, lr, s, hc, lc, c }

class ColorsContainer {
  final Color backgroundColor;
  final Color textColor;

  ColorsContainer({this.backgroundColor, this.textColor});

  static ColorsContainer getColorsContainer(String abbrWeather) {
    if (abbrWeather == 'sn' || abbrWeather == 'sl' || abbrWeather == 'h') {
      return ColorsContainer(
        backgroundColor: Color(0xFF184b59),
        textColor: Colors.white,
      );
    } else if (abbrWeather == 't') {
      return ColorsContainer(
        backgroundColor: Color(0xFFFFFF00),
        textColor: Colors.black,
      );
    } else if (abbrWeather == 'hr') {
      return ColorsContainer(
          backgroundColor: Color(0xFF2F3484),
          textColor: Colors.white,
      ); //303c75 // 094479
    } else if (abbrWeather == 'lr') {
      return ColorsContainer(
        backgroundColor: Color(0xFF2DAAD8),
        textColor: Colors.white,
      ); //A08555
    }
    else if( abbrWeather == 's'){
      return  ColorsContainer(
        backgroundColor: Color(0xff29926e),
        textColor: Colors.black,
      ); //
    } else if (abbrWeather == 'lc' || abbrWeather == 'c') {
      return ColorsContainer(
        backgroundColor: Color(0xFFFFA249),
        textColor: Colors.black,
      );
    } else if(abbrWeather == 'hc')
      return ColorsContainer(
        backgroundColor: Colors.white,
        textColor: Colors.black,
      );
  }
}
