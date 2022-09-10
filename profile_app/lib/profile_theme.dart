
import 'package:flutter/material.dart';

class ProfileTheme {
  static ThemeData dark() {
    return ThemeData(
      appBarTheme: const AppBarTheme(
          foregroundColor: Colors.purpleAccent,
          backgroundColor: Colors.black),
      brightness: Brightness.dark,
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: Colors.black,
      ),
      expansionTileTheme: ExpansionTileThemeData(
        collapsedBackgroundColor: Colors.blue.withOpacity(0.5),
        backgroundColor: Colors.black,
          textColor: Colors.deepOrange,
          collapsedTextColor: Colors.white
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: Colors.purple,
          foregroundColor: Colors.yellow
      ),
      cardColor: Colors.grey[700],
    );
  }

  static ThemeData light() {
    return ThemeData(
      appBarTheme: const AppBarTheme(
          foregroundColor: Colors.yellow,
          backgroundColor: Colors.blueAccent),
      brightness: Brightness.light,
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Colors.blue[800],
        selectedItemColor: Colors.white
      ),
      expansionTileTheme: ExpansionTileThemeData(
          collapsedBackgroundColor: Colors.lightBlue[700],
          backgroundColor: Colors.indigo,
        textColor: Colors.white,
        collapsedTextColor: Colors.amberAccent
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        //backgroundColor: Colors.deepOrange,
          foregroundColor: Colors.yellow
      ),
      cardColor: Colors.lightBlue[100],
    );
  }
}