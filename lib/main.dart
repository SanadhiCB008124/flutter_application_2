import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/screens/CardDetails.dart';
import 'package:flutter_application_2/screens/Home.dart';
import 'package:flutter_application_2/screens/Login.dart';
import 'package:flutter_application_2/screens/Register.dart';
import 'package:flutter_application_2/screens/Splash.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_2/screens/theme_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_2/screens/theme_provider.dart';
import 'dart:async';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
   WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers:[
        ChangeNotifierProvider<CardData>(
          create: (_) => CardData(),
        ),
        ChangeNotifierProvider<ThemeProvider>(
          create: (_) => ThemeProvider(),
        ),
      ] ,
      child: MyApp(),
    ),
  );
}
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _showSplash = true;

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 4), () {
      setState(() {
        _showSplash = false;
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, _) {
        return MaterialApp(
          title: 'Sana Bakes',
          theme: Provider.of<ThemeProvider>(context).themeData,
               home: _showSplash ? SplashScreen() : StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return SplashScreen();
              }
               else {

                return SplashScreen();
                
              }
            },
          ),
        );
      },
    );
  } 
}

class SplashScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
  
       backgroundColor: Color.fromARGB(255, 173, 140, 179),
     
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Image(image: AssetImage('Assets/images/cupcake.png')),
              height: 100,
              width: 100,
            ),
            SizedBox(height: 20),
           Container(
           child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Login()
                  
                  
                  
                  ),
                  
                );
                
                
              },
                style: ButtonStyle(
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
        ),
      ),
    
    ),
              child: Text('Login'),
            ),
          
           ),
           SizedBox(height: 20),
         Container(
  child: ElevatedButton(
    onPressed: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Register()),
      );
    },
    style: ButtonStyle(
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
        ),
      ),
    
    ),
    child: Text('Register'),
  ),
          ),  ],

          
        ),
      ),
    );
  }
}