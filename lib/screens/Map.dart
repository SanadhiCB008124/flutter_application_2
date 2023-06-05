import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_2/screens/theme_provider.dart';
import 'package:provider/provider.dart'; 

class Map extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Map'),
      ),
      body: Consumer<ThemeProvider>(
        builder: (context, themeProvider, _) {
          return Container(
            color: themeProvider.isDark ? Colors.black : Colors.white,
            child: Center(
              child: Text(
                'Welcome to the Home Page!',
                style: TextStyle(
                  color: themeProvider.isDark ? Colors.white : Colors.black,
                  fontSize: 20.0,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}