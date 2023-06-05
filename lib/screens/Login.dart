// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_application_2/screens/Home.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
     
     backgroundColor: const Color.fromARGB(255, 195, 157, 169),

      body:Container(
        padding: const EdgeInsets.all(16.0),
        margin: EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                child: SizedBox(
    width: 90,
    height: 100,
    child:Image.asset('Assets/images/cupcake.png'),
  ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 44.0),
              child: Text(
                ' Sana Bakes',
                
                style: TextStyle(
                  fontSize: 34.0,
                  
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 177, 96, 147),
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: Color.fromARGB(255, 177, 96, 147),
                  width: 3.0,
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
              ),
            ),
            SizedBox(height: 16.0),
            
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: Color.fromARGB(255, 177, 96, 147),
                  width: 3.0,
                ),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: TextFormField(
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
            
            SizedBox(height: 18.0),
            
            Container(
        margin: EdgeInsets.only(top:40.0),
           width: 150,
           height:60,
           child: ElevatedButton(
             
            onPressed: () {
            Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Home()));},
            
            style: ButtonStyle(
              
              backgroundColor: MaterialStateProperty.all<Color>(Color.fromARGB(255, 165, 103, 176),
              )
            ),
             child: Padding(
                  padding: const EdgeInsets.all(8.0),
              child: Text('Login',
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.white, // Set the color 
              )
              ),
            ),
            )), 
            Column(
              
             children: [
         Padding(padding: EdgeInsets.all(6)),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.all(6),
          child: Text('Sign in with Google'),
        ),
        Container(
                child: SizedBox(
    width: 50,
    height: 50,
    child:Image.asset('Assets/images/google.png'),
  ),
            ),
      
      ],
    ),
  ],
              
            )
          ],
        ),
      ),
    );
  }
}
