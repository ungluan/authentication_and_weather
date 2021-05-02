import 'package:flutter/material.dart';

class SizeConfig{
  static double maxHeight ;
  static double maxWidth ;
  static double blocHeight;
  static double blocWidth;

  void init(BoxConstraints constraints){
    maxHeight =  constraints.maxHeight;
    maxWidth = constraints.maxWidth;

    blocHeight = maxHeight/100;
    blocWidth = maxWidth/100;
  }

}