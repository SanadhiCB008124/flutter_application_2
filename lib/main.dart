import 'package:flutter/material.dart';
import 'package:flutter_application_2/screens/Home.dart';
import 'package:flutter_application_2/screens/Login.dart';
import 'package:flutter_application_2/screens/Address.dart';
import 'package:flutter_application_2/screens/Map.dart';
import 'package:flutter_application_2/screens/Favorites.dart';
import 'package:flutter_application_2/screens/Cart.dart';
import 'package:flutter_application_2/screens/Product.dart';
import 'package:flutter_application_2/screens/Profile.dart';
import 'package:flutter_application_2/screens/Splash.dart';
import 'package:flutter_application_2/screens/theme_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, _) {
        return MaterialApp(
          title: 'Sana Bakes',
          theme: Provider.of<ThemeProvider>(context).themeData,
          
          home: Home(),
        );
      },
    );
  }
}



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
     
    );
  }