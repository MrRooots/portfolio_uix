import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:portfolio_uix/core/palette/palette.dart';

class MyTheme {
  static final ThemeData myTheme = ThemeData(
    appBarTheme: const AppBarTheme(
      titleTextStyle: TextStyle(
        fontSize: 18.0,
        color: Palette.black,
      ),
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
      backgroundColor: Colors.transparent,
      elevation: 0.0,
    ),
    pageTransitionsTheme: const PageTransitionsTheme(builders: {
      TargetPlatform.android: CupertinoPageTransitionsBuilder(),
      TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
    }),
    textTheme: const TextTheme(
      headline1: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
      subtitle1: TextStyle(fontSize: 16),
    ),
    fontFamily: 'Muli',
    visualDensity: VisualDensity.adaptivePlatformDensity,
    inputDecorationTheme: const InputDecorationTheme(
      suffixIconColor: Palette.black,
      floatingLabelStyle: TextStyle(color: Palette.orange),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Palette.black, width: 2),
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Palette.black, width: 2),
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Palette.black, width: 2),
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      errorStyle: TextStyle(fontSize: 14.0),
      focusColor: Palette.black,
    ),
    iconTheme: const IconThemeData(color: Palette.orange, size: 30.0),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Palette.orange,
    ),
  );
}
