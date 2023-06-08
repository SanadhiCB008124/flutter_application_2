// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_application_2/screens/Home.dart';
import 'package:flutter_application_2/screens/Login.dart';
import 'package:flutter_application_2/screens/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Register extends StatefulWidget {

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
      final emailcontroller=TextEditingController();
      final passwordcontroller=TextEditingController();

  @override
  Widget build(BuildContext context) {
  final themeProvider = Provider.of<ThemeProvider>(context);

    return  Scaffold(
      
       
        body: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: SizedBox(
                  width: 80,
                  height: 100,
                  child: Image.asset('Assets/images/cupcake.png'),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: Colors.grey,
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Username',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 12.0,
                    ),
                  ),
                  obscureText: true,
                ),
              ),
              SizedBox(height: 16.0),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: Colors.grey,
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: TextFormField(
                  controller: emailcontroller,
                  decoration: InputDecoration(
                    labelText: '  Email',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 12.0,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: Colors.grey,
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: TextFormField(
                  controller: passwordcontroller,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 12.0,
                    ),
                  ),
                  obscureText: true,
                ),
              ),
              SizedBox(height: 16.0),
              
              Container(
                margin: const EdgeInsets.only(top: 16.0, bottom: 16.0),
                width: 150,
                child: ElevatedButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                    ),
                    backgroundColor: themeProvider.themeData.elevatedButtonTheme.style!.backgroundColor,
                  ),
                  onPressed: () {
                    FirebaseAuth.instance.createUserWithEmailAndPassword(
                      email: emailcontroller.text,
                     password: passwordcontroller.text).
                     then((value){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Home()),
                    );
                  }).catchError((e){
                    print(e);
                  });
                  
                  },
                  child: Text('Register'),
                  
                ),
              ),
              TextButton(
                  child: Text('Already have an account? Login',
                  
                  style:TextStyle(
                    fontSize: 14,
                  )),
                 style: ButtonStyle(

                 ),
               onPressed : () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Login()),
                    );
                  },
             
              )
            ],
          ),
        ),
      );
    
  }
}