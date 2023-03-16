import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

var lightTheme = ThemeData(
  inputDecorationTheme: InputDecorationTheme(
    border: InputBorder.none,
    hintStyle: TextStyle(
      color: Colors.black,
      fontSize: 12,
      fontWeight: FontWeight.w500,
    ),
    labelStyle: TextStyle(
      color: Colors.black,
    ),
    iconColor: Colors.black,
    suffixIconColor: Colors.black,
    prefixIconColor: Colors.black,
  ),
  primarySwatch: Colors.blue,
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    backgroundColor: Colors.white,
    selectedItemColor: Colors.blue,
  ),
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: const AppBarTheme(
    iconTheme: IconThemeData(color: Colors.black),
    titleTextStyle: TextStyle(
      color: Colors.black,
      fontSize: 25.0,
      fontWeight: FontWeight.bold,
    ),
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
    ),
    backgroundColor: Colors.white,
    elevation: 0.0,
  ),
  textTheme: const TextTheme(
    bodyText1: TextStyle(
      color: Colors.black,
      fontSize: 18.0,
      fontWeight: FontWeight.w800,
    ),
    subtitle1: TextStyle(
      color: Colors.black,
      fontSize: 15.0,
      fontWeight: FontWeight.w600,
    ),
  ),
  cardColor: Colors.white,
);

var darkTheme = ThemeData(
  inputDecorationTheme: InputDecorationTheme(
    border: InputBorder.none,
    hintStyle: TextStyle(
      color: Colors.white,
    ),
    labelStyle: TextStyle(
      color: Colors.white,
    ),
    iconColor: Colors.white,
    suffixIconColor: Colors.white,
    prefixIconColor: Colors.white,
  ),
  primarySwatch: Colors.blue,
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    backgroundColor: Color.fromARGB(255, 24, 25, 26),
    selectedItemColor: Colors.blue,
    unselectedItemColor: Colors.grey,
  ),
  scaffoldBackgroundColor: const Color.fromARGB(255, 32, 31, 31),
  appBarTheme: const AppBarTheme(
    iconTheme: IconThemeData(color: Colors.white),
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 25.0,
      fontWeight: FontWeight.bold,
    ),
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Color.fromARGB(255, 32, 31, 31),
      statusBarIconBrightness: Brightness.light,
    ),
    backgroundColor: Color.fromARGB(255, 24, 25, 26),
    elevation: 0.0,
  ),
  textTheme: const TextTheme(
    bodyText1: TextStyle(
      color: Colors.white,
      fontSize: 18.0,
      fontWeight: FontWeight.w800,
    ),
    subtitle1: TextStyle(
      color: Colors.white,
      fontSize: 20.0,
      fontWeight: FontWeight.w900,
    ),
  ),
  cardColor: Color.fromARGB(255, 24, 25, 26),
);
