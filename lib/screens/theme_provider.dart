import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier {
  bool _isDark = false;

  bool get isDark => _isDark;

  ThemeData get themeData => _isDark ? _darkTheme : _lightTheme;

  static final ThemeData _lightTheme = ThemeData(
    primarySwatch: Colors.purple,
    // Define your light theme colors here
    // For example:
    // primaryColor: Colors.purple,
    // accentColor: Colors.deepPurple,
    // backgroundColor: Colors.white,
  );

  static final ThemeData _darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: Colors.black,
    // Define your dark theme colors here
    // For example:
    // primaryColor: Colors.deepPurple,
    // accentColor: Colors.purpleAccent,
    // backgroundColor: Colors.black,
  );

  void toggleTheme() {
    _isDark = !_isDark;
    notifyListeners();
  }
}
