import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/screens/Home.dart';
import 'package:flutter_application_2/screens/Login.dart';
import 'package:flutter_application_2/screens/Splash.dart';
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
          home: StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Home();
              }
               else {

                return Login();
                
              }
            },
          ),
        );
      },
    );
  } 
}
