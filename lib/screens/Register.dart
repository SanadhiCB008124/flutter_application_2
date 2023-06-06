// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_application_2/screens/Home.dart';

class Register extends StatelessWidget {
  const Register({ Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    
      backgroundColor: const Color.fromARGB(255, 195, 157, 169),
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
                  labelText: 'Confirm Password',
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 12.0,
                  ),
                ),
                obscureText: true,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 16.0, bottom: 16.0),
              height: 60,
              width: 150,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Home()),
                  );
                },
                child: Text('Create Account'),
              ),
            ),
            Text(
              'Already have an account? Sign in',
              style: TextStyle(
                color: Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  }
}
