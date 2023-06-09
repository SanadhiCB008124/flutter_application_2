// ignore_for_file: prefer_const_constructors
import 'package:flutter_application_2/screens/Register.dart';
import 'package:provider/provider.dart';
import 'theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_2/screens/Home.dart';

class Login extends StatefulWidget {
   final String? errorMessage; 
  Login({Key? key,  this.errorMessage}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
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
          return buildLandscapeLayout(themeProvider );
        }
      },
    ),
  );
}

  
  Widget buildPortraitLayout(ThemeProvider themeProvider) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(16.0),
            margin: const EdgeInsets.all(10.0),
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
                    controller: emailController,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 12.0,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
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
                    controller: passwordController,
                    decoration: const InputDecoration(
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
                const SizedBox(height: 16.0),
                Container(
                  margin: const EdgeInsets.only(top: 40.0),
                  width: 150,
                  height: 60,
                  child: ElevatedButton(
                    onPressed: () {
                      SignIn(context);
                    },
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                      ),
                      backgroundColor:
                         
                              themeProvider.themeData
                                  .elevatedButtonTheme.style!.backgroundColor!,
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Login',
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                Column(
                  children: [
                    const Padding(padding: EdgeInsets.all(6)),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Register()),
                              );
                            },
                            child: const Text(
                              'No Account? Register Here',
                              style: TextStyle(
                                color: Color(0xFF4B1969),
                          fontSize: 17,
                              ),
                            ),
                          ),
                          margin: const EdgeInsets.all(6),
                        ),
                       
                      ],
                    ),
                   Text(widget.errorMessage ?? '',
                        style: TextStyle(color: Colors.red)),
                  ],
                ),
              ],
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
      padding: const EdgeInsets.all(16.0),
      margin: const EdgeInsets.all(10.0),
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
              controller: emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
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
                color: const Color.fromARGB(255, 177, 96, 147),
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: TextFormField(
              controller: passwordController,
              decoration: const InputDecoration(
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
          
            width: 150,
            height: 60,
            child: ElevatedButton(
              onPressed: () {
                SignIn(context);
              },
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                ),
                backgroundColor: themeProvider.themeData
                    .elevatedButtonTheme.style!.backgroundColor!,
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 6.0),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Register()),
                    );
                  },
                  child: Text(
                    'No Account? Register Here',
                    style: TextStyle(
                      
                       color: Color(0xFF4B1969),
                          fontSize: 17,
                    ),
                  ),
                ),
                margin: const EdgeInsets.all(6),
              ),
            ],
          ),
            Text(widget.errorMessage ?? '',
                        style: TextStyle(color: Colors.red)),
        ],
      ),
    ),
  );
}












  Future<void> SignIn(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      // Navigate to Home screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Home()),
      );
    } catch (e) {
      String errorMessage = 'Incorrect Email or Password';

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => Login(errorMessage: errorMessage),
        ),
      );
    }
  }
}
