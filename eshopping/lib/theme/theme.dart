import 'package:flutter/material.dart';

//Aydınlık mod için renk ayarlaması
ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(

    secondary: Colors.black,
    primary: Colors.grey.shade300,
    background: Colors.white,
  ),
);

//Karanlık mod için renk ayarlaması
ThemeData darkMode = ThemeData(
    brightness: Brightness.dark,
    colorScheme: ColorScheme.dark(
        secondary: Colors.white,
        primary: Colors.grey.shade800,
        background: Colors.grey.shade900));
