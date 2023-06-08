import 'package:flutter/material.dart';
import 'package:flutter_application_2/screens/Home.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_2/screens/theme_provider.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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

