// ignore_for_file: prefer_const_constructors

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/screens/Home.dart';
import 'package:flutter_application_2/screens/Login.dart';
import 'package:flutter_application_2/screens/theme_provider.dart';
import 'package:flutter_application_2/screens/theme_provider.dart';
import 'package:flutter_application_2/screens/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Register extends StatefulWidget {
  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  String? _validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a username';
    }
    return null;
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter an email address';
    }
    if (!value.contains('@')) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a password';
    }
    if (value.length < 6) {
      return 'Password should be at least 6 characters long';
    }
    return null;
  }

  void _registerUser() {
    if (_formKey.currentState!.validate()) {
      String email = _emailController.text.trim();
      String password = _passwordController.text.trim();

      FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Home()),
        );
      }).catchError((e) {
        print(e);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

 return Scaffold(
  backgroundColor:  Color.fromARGB(255, 173, 140, 179),
  
    body: OrientationBuilder(
      builder: (context, orientation) {
        // Portrait mode
        if (orientation == Orientation.portrait) {
          return buildPortraitLayout(themeProvider );
        }
        // Landscape mode
        else {
          return buildLandscapeLayout(themeProvider  );
        }
      },
    ),
  );
}





Widget buildPortraitLayout(ThemeProvider themeProvider){
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
            
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: SizedBox(
                        width: 80,
                        height: 90,
                        child: Image.asset('Assets/images/cupcake.png'),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: const Color.fromARGB(255, 177, 96, 147),
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                      child: TextFormField(
                        
                        controller: _usernameController,
                        decoration: InputDecoration(
                          labelText: 'Username',
                           labelStyle: TextStyle(
                        color: Colors.grey,
                        
                      ),
                          border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 12.0,
                        ),
                      ),
                    
                       validator: _validateUsername,
                      ),
                    ),
                    SizedBox(height: 16.0),
                    Container(
                      decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: const Color.fromARGB(255, 177, 96, 147),
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                      child: TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          labelText: 'Email',
                           labelStyle: TextStyle(
                        color: Colors.grey,
                        
                      ),
                          border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 12.0,
                      ),),
                          
                        validator: _validateEmail,
                      ),
                    ),
                    SizedBox(height: 16.0),
                    Container(
                       decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: const Color.fromARGB(255, 177, 96, 147),
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                      child: TextFormField(
                        controller: _passwordController,
                        decoration: InputDecoration(
                          labelText: 'Password',
                           labelStyle: TextStyle(
                        color: Colors.grey,
                        
                      ),
                          border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 12.0,
                      ),
                          
                        ),
                        obscureText: true,
                        validator: _validatePassword,
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
                          backgroundColor:
                              themeProvider.themeData.elevatedButtonTheme.style!
                                  .backgroundColor,
                        ),
                        onPressed: _registerUser,
                        child: Text('Register'),
                      ),
                    ),
                    Container(
                      
                     child: TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Login()),
                          );
                        },
                        child: Text('Already Have an Account? Login Here',
                        style: TextStyle(
                          color: Color(0xFF4B1969),
                          fontSize: 17,
                        ),
                      ),)
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      );  
  
  }

Widget buildLandscapeLayout(ThemeProvider themeProvider) {
    final themeProvider = Provider.of<ThemeProvider>(context);
  return SingleChildScrollView(
    child: Container(
      padding: EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.center,
              child: SizedBox(
                width: 80,
                height: 90,
                child: Image.asset('Assets/images/cupcake.png'),
              ),
            ),
            SizedBox(height: 16.0),
            Container(
               decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: const Color.fromARGB(255, 177, 96, 147),
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
              child: TextFormField(
                controller: _usernameController,
                decoration: InputDecoration(
                  labelText: 'Username',
                   labelStyle: TextStyle(
                          color: Colors.grey,
                          
                        ),
                      border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 12.0,
                    horizontal: 16.0,
                  ),
                 
                ),
                validator: _validateUsername,
              ),
            ),
            SizedBox(height: 16.0),
            Container(  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: const Color.fromARGB(255, 177, 96, 147),
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
              child: TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                   labelStyle: TextStyle(
                          color: Colors.grey,
                          
                        ),
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 12.0,
                    horizontal: 16.0,
                  ),
                  border: InputBorder.none,
                 
                ),
                validator: _validateEmail,
              ),
            ),
            SizedBox(height: 16.0),
            Container(
              decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: const Color.fromARGB(255, 177, 96, 147),
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
              child: TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                   labelStyle: TextStyle(
                          color: Colors.grey,
                          
                        ),
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 12.0,
                    horizontal: 16.0,
                  ),
                 border: InputBorder.none,
                ),
                obscureText: true,
                validator: _validatePassword,
              ),
            ),
            SizedBox(height: 16.0),
            Container(
              alignment: Alignment.center,
              
              margin:  EdgeInsets.only(left:300),
              width: 150,
              child: ElevatedButton(
               
                style: ButtonStyle(
                   
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                  ),
                  backgroundColor: themeProvider.themeData
                      .elevatedButtonTheme.style!.backgroundColor,
                ),
                onPressed: _registerUser,
                child: Text('Register'),
              ),
            ),
            Container(
              alignment: Alignment.center,
              
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Login()),
                  );
                },
                child: Text('Already Have an Account? Login Here',
                style: TextStyle(
                  color: Color(0xFF4B1969),
                  fontSize: 17,
                ),
              ),
            ),
          ),
          ]
        ),
      ),
    ),
  );
}
}