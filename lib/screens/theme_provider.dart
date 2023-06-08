import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier {
  bool _isDark = false;

  bool get isDark => _isDark;

  ThemeData get themeData => _isDark ? _darkTheme : _lightTheme;

  static final ThemeData _lightTheme = ThemeData(
    
    primaryColor: Color.fromRGBO(75, 25, 105, 1),
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
      backgroundColor: Color.fromRGBO(75, 25, 105, 1),
    ),
    inputDecorationTheme: InputDecorationTheme(
       iconColor: Colors.black,
    ),
   
    brightness: Brightness.light,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Color.fromRGBO(75, 25, 105, 1),

        textStyle: TextStyle(
          color: Colors.white,
          fontSize: 20,
        ),
        minimumSize: Size(150, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
    ),
     bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Color.fromRGBO(75, 25, 105, 1),
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white,
    ),
     tabBarTheme: TabBarTheme(
      indicatorColor: Color(0xFF4B1969),
      labelColor: Colors.white,
      unselectedLabelColor: Colors.black,
    ),
     textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
          textStyle: TextStyle(
        color: Color(0xFF4B1969),
          ),
      ),

   )
    
   


   
  );

  static final ThemeData _darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.black,
    scaffoldBackgroundColor: Colors.black12,
   
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.black,
    ),
     elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Color.fromRGBO(92, 88, 95, 1),

        textStyle: TextStyle(
          color: Colors.white,
          fontSize: 20,
        ),
        minimumSize: Size(150, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(

      backgroundColor:  Color.fromARGB(255, 36, 34, 34),
        
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.grey,
    ),
    textTheme: TextTheme(
      bodyMedium: TextStyle(
        color: Colors.white,
      ),
      bodyLarge: TextStyle(
        color: Colors.white,
      ),
    ),
    tabBarTheme: TabBarTheme(
      indicatorColor: Colors.grey,
      labelColor: Colors.black,
      unselectedLabelColor: Colors.white,
    ),

    switchTheme: SwitchThemeData(
      thumbColor: MaterialStateProperty.all(Colors.purple),
      trackColor: MaterialStateProperty.all(Colors.grey),
    ),
    bottomAppBarTheme: BottomAppBarTheme(
      color: Colors.black,),

  
   textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
          textStyle: TextStyle(
            color: Colors.white,
          ),
      ),

   )
  
  );

  void toggleTheme() {
    _isDark = !_isDark;
    notifyListeners();
  }
}
