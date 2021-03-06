import 'package:authentication_and_weather/Constants/colors_app.dart';
import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {

  final String btnText;
  final Function function;
  PrimaryButton({@required this.btnText, @required this.function});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 32),
        height: 50,
        decoration: BoxDecoration(
            color: ColorsApp.primaryColor,
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              colors: [
                ColorsApp.primaryColor,
                Color(0xFF787FF6),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomLeft,
            ),
        ),
        child: Center(
          child: Text(
            btnText,
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
            ),
          ),
        ),
      ),
    );
  }
}
