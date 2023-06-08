import 'package:flutter/material.dart';
import 'package:flutter_application_2/screens/Login.dart';
import 'Home.dart';
import 'package:flutter_application_2/screens/Register.dart';

class Splash extends StatelessWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple[300],
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
            Text(
              'Sana Bakes',
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 40),
           
          ],
        ),
      ),
    );
  }
}
