import 'package:authentication_and_weather/Constants/size_config.dart';
import 'package:flutter/material.dart';

class SocialMediaButton extends StatelessWidget {
  final IconData iconData;
  final Function function;
  final Color backgroundColor;
  final Color colorIcon;

  SocialMediaButton(
      {this.iconData, this.function, this.backgroundColor, this.colorIcon});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: Container(
        margin: EdgeInsets.only(top: 5, left: 5),
        height: 8*SizeConfig.blocHeight,
        width: 8*SizeConfig.blocHeight,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(50),
          // border: Border.all(color: Color(0xFFB40284A), width: 2),
        ),
        child: Icon(
          iconData,
          color: colorIcon,
        ),
      ),
    );
  }
}
