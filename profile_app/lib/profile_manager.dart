
import 'package:flutter/material.dart';
import 'package:profile_app/dark_theme_preference.dart';
import 'package:profile_app/user.dart';

class ProfileManager extends ChangeNotifier {
  /*
  User get getUser => User(
      firstName: 'Alicia',
      lastName: 'Zhao',
      profileImageUrl: 'assets/alicia.jpg',
      darkMode: _darkMode
  );
   */
  DarkThemePreference darkThemePreference = DarkThemePreference();
  var _darkMode = false;

  bool get darkMode => _darkMode;

  set darkMode(bool darkMode) {
    _darkMode = darkMode;
    darkThemePreference.setDarkTheme(darkMode);
    notifyListeners();
  }

}