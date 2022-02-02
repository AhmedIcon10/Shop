import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';

import 'constants.dart';

ThemeData appLightTheme = ThemeData(
  primaryColor: defaultColor,
  primarySwatch: Colors.cyan,
  scaffoldBackgroundColor: Colors.white,
  appBarTheme:  const AppBarTheme(
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
    systemOverlayStyle:  SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarBrightness: Brightness.dark,
    ),

  ),
  textTheme: const TextTheme(
    bodyText1: TextStyle(
      fontWeight: FontWeight.bold,
      color: Colors.black,
      fontSize: 20.0,
      overflow: TextOverflow.ellipsis
    ),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: defaultColor),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
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
      fontSize: 20.0,
      fontWeight: FontWeight.w600,
      overflow: TextOverflow.ellipsis,

    ),
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: defaultColor,),
);