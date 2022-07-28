import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

var themelight = ThemeData(
    primarySwatch:Colors.teal, // بتاع اللي  بيلف
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
        titleSpacing: 20,
        backwardsCompatibility: false, //states Bare
        systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: Colors.white),
        backgroundColor: Colors.white,
        elevation: 0.0,
        titleTextStyle: TextStyle(
            color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        iconTheme: IconThemeData(color: Colors.black)),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      selectedItemColor:Colors.grey,
      unselectedItemColor: Colors.grey,
      backgroundColor: Colors.white,
      elevation: 20.0,
    ),);

const Color red = Colors.redAccent;
const Color teal = Colors.teal;
const Color oragne = Colors.orangeAccent;
const Color  blue = Colors.blue;
