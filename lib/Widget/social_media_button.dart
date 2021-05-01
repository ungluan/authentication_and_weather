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
        margin: EdgeInsets.symmetric(horizontal: 5),
        height: 60,
        width: 60,
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
