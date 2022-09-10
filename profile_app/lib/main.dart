import 'package:flutter/material.dart';
import 'package:profile_app/dark_theme_preference.dart';
import 'package:profile_app/profile_manager.dart';
import 'package:provider/provider.dart';
import 'package:profile_app/home.dart';
import 'package:profile_app/profile_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _profileManager = ProfileManager();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => _profileManager,
          )
        ],
        child:
            Consumer<ProfileManager>(builder: (context, profileManager, child) {
          ThemeData theme;

          if (profileManager.darkMode) {
            //theme = ThemeData.dark();
            theme = ProfileTheme.dark();
          } else {
            //theme = ThemeData.light();
            theme = ProfileTheme.light();
          }
          return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: theme,
              title: 'ALICIA',
              home: Home());
        }));
  }

}


