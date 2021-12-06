import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';

String? tokenAuth='';

ThemeData lightTheme()=>ThemeData(
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      elevation: 0,
      titleTextStyle: TextStyle(
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
        color: Colors.indigo,
      ),
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
      ),
      iconTheme: IconThemeData(
        color: Colors.indigo,
      ),
      actionsIconTheme: IconThemeData(
        color: Colors.indigo,
      ),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        elevation: 20.0,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.indigo),
    floatingActionButtonTheme:  FloatingActionButtonThemeData(
      backgroundColor: HexColor('180040')
    ),
    textTheme: const TextTheme(
      bodyText1: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 16,
        color: Colors.black,
      ),
    )
);
ThemeData darkTheme()=>ThemeData(
  scaffoldBackgroundColor: HexColor('000028'),
  appBarTheme:  AppBarTheme(
    backgroundColor: HexColor('00028'),
    elevation: 0,
    titleTextStyle: const TextStyle(
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
      color: Colors.blueAccent,
    ),
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: HexColor('000028'),
      statusBarIconBrightness: Brightness.light,
    ),
    iconTheme: const IconThemeData(
      color: Colors.blueAccent,
    ),
    actionsIconTheme: const IconThemeData(
      color: Colors.blueAccent,
    ),
  ),
  bottomNavigationBarTheme:  BottomNavigationBarThemeData(
    elevation: 20.0,
    type: BottomNavigationBarType.fixed,
    selectedItemColor: Colors.blueAccent,
    backgroundColor:HexColor('000028'),
    unselectedItemColor: Colors.white,
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(),
  textTheme: const TextTheme(
    bodyText1: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 16,
      color: Colors.white,
    ),
  ),
);

//Theme.of(context).textTheme.bodyText1