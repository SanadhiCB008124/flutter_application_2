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
     primaryColor: Colors.purple,
  
   
  );

  static final ThemeData _darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: Colors.black,
   
   textTheme: const TextTheme(
    bodyLarge: TextStyle(
      color: Colors.white, // Set default text color
    ),
    
  ),
  buttonTheme: const ButtonThemeData(
    buttonColor: Colors.purpleAccent, 
   
  ),
   
    
  );

  void toggleTheme() {
    _isDark = !_isDark;
    notifyListeners();
  }
}
