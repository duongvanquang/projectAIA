import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'color_theme.dart';

mixin MoviesTheme {
  static ThemeData buildTheme() => ThemeData(
      fontFamily: 'google',
      appBarTheme: const AppBarTheme(
          centerTitle: true,
          systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: ColorsTheme.blueColor,
              statusBarBrightness: Brightness.light)),
      textTheme: const TextTheme(
        headline1: TextStyle(
          color: ColorsTheme.primaryBlack,
          fontWeight: FontWeight.bold,
          fontSize: 36,
        ),
        headline2: TextStyle(
          color: ColorsTheme.primaryBlack,
          fontWeight: FontWeight.bold,
          fontSize: 24,
        ),
        headline3: TextStyle(
          color: ColorsTheme.primaryBlack,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
        headline4: TextStyle(
          color: ColorsTheme.primaryBlack,
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
        headline5: TextStyle(
          color: ColorsTheme.primaryBlack,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
        headline6: TextStyle(
          color: ColorsTheme.primaryBlack,
          fontWeight: FontWeight.normal,
          fontSize: 14,
        ),
        bodyText1: TextStyle(
          color: ColorsTheme.primaryBlack,
          fontWeight: FontWeight.normal,
          height: 1.75,
          fontSize: 12,
        ),
        bodyText2: TextStyle(
          color: ColorsTheme.primaryBlack,
          fontWeight: FontWeight.normal,
          fontSize: 10,
        ),
      ));
}
