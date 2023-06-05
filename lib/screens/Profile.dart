import 'package:flutter/material.dart';
import 'package:flutter_application_2/screens/Settings.dart';
import 'package:flutter_application_2/screens/Map.dart';

class Profile extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(
            icon:Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Settings()),
              );
            },
          ),
        ],
       ),
      body: Center(
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            SizedBox(
              width: 100,
              height: 150,
              child: Image.asset('Assets/images/user.png'),
            ),
            SizedBox(height: 16.0),
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.purple,
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: TextFormField(
                
                decoration: InputDecoration(
                   suffixIcon: Icon(Icons.edit),
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
                border: Border.all(
                  color: Colors.purple,
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: TextFormField(
                decoration: InputDecoration(
                  suffixIcon: Icon(Icons.edit),
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
            Container(
            
  padding: EdgeInsets.all(16.0),
 
             child: Text('Saved Locations',
             
             style: TextStyle(
              color: Colors.black,
               fontSize: 22.0,
               fontWeight: FontWeight.bold,
             ),),
            ),
            
            Container(
  child: Card(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Home',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                'No.26 Niwasa Mawatha, Kandana',
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      // Add your edit button logic here
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  ),
),
Container(
  padding: EdgeInsets.all(6),
  child: GestureDetector(
    onTap: () {
      Navigator.push(context, MaterialPageRoute(builder: (context) => Map()));
    },
    child: Text(
      'Add New Location',
      style: TextStyle(
        color: Colors.purpleAccent,
        fontSize: 20.0,
      ),
    ),
  ),
),
          ],
        ),
      ),
    );
  }
}
