import 'package:flutter/material.dart';

class OutlineBtn extends StatelessWidget {
  final String btnText;
  final Function function;
  OutlineBtn({this.btnText, this.function});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(50),
          border: Border.all(color: Color(0xFFB40284A), width: 2),
        ),
        padding: EdgeInsets.all(20),
        child: Center(
          child: Text(
            btnText,
            style: TextStyle(
              color: Color(0xFFB40284A),
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
