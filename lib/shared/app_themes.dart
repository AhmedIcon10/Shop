import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';

import 'constants.dart';

ThemeData appLightTheme = ThemeData(
  primaryColor: defaultColor,
  primarySwatch: Colors.deepPurple,
  scaffoldBackgroundColor: Colors.white,
  appBarTheme:  AppBarTheme(
    centerTitle: true,
    color: Colors.white,
    elevation: 0.0,
    iconTheme: IconThemeData(color: defaultColor),
    titleTextStyle: TextStyle(
      color: defaultColor,
      fontSize: 22.0,
      fontWeight: FontWeight.bold,
      fontStyle: FontStyle.italic,
    ),
    systemOverlayStyle: const SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarBrightness: Brightness.dark,
    ),

  ),
  bottomNavigationBarTheme:  BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: defaultColor),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: defaultColor),
);
ThemeData appDarkTheme = ThemeData(
  primarySwatch: Colors.cyan,
  primaryColor: defaultColor,
  scaffoldBackgroundColor: HexColor("#282828"),
  appBarTheme: AppBarTheme(
    centerTitle: true,
    color: HexColor("#121212"),
    elevation: 10.0,
    iconTheme: const IconThemeData(color: defaultColor),
    titleTextStyle: const TextStyle(
      color: defaultColor,
      fontSize: 22.0,
      fontWeight: FontWeight.bold,
      fontStyle: FontStyle.italic,
    ),
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: HexColor("#121212"),
      statusBarBrightness: Brightness.light,
    ),

  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    backgroundColor: HexColor("#121212"),
    selectedItemColor: defaultColor,
    unselectedItemColor:Colors.white70,),
  textTheme: const TextTheme(
    bodyText1: TextStyle(
      color: Colors.white,
      fontSize: 18,
      fontWeight: FontWeight.w600,
      overflow: TextOverflow.ellipsis,

    ),
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: defaultColor,),
);