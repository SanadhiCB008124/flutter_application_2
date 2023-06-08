import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/screens/CardDetails.dart';
import 'package:flutter_application_2/screens/Settings.dart';
import 'package:flutter_application_2/screens/Map.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key,});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  late User? _user; // User object to store the currently signed-in user

  @override
  void initState() {
    super.initState();
    _getUser(); // Call a method to retrieve the currently signed-in user
  }

  Future<void> _getUser() async {
    User? user = FirebaseAuth.instance.currentUser;
    setState(() {
      _user = user;
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
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
            const SizedBox(height: 16.0),
            Container(
              child: Text('Hi ${_user?.email ?? ''}' 
              ,style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              )
              ),
              
              ), // Display the user's email
            const SizedBox(height: 16.0),
            Container(
              child: TextFormField(
                decoration: const InputDecoration(
                  suffixIcon: Icon(Icons.edit),
                  labelText: 'Username',
                  border: OutlineInputBorder(borderRadius: BorderRadius.zero),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 12.0,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16.0),
          
            Container(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Saved Locations',
                style: TextStyle(
                  color: themeProvider.themeData.textTheme.bodyMedium?.color,
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: locations.length,
              itemBuilder: (context, index) {
                final location = locations[index];
                return Container(
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Stack(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                location.name,
                                style: const TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 8.0),
                              Text(
                                location.address,
                                style: const TextStyle(
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
                                    icon: const Icon(Icons.edit),
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
                );
              },
            ),
            Container(
              padding: const EdgeInsets.all(6),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Map()),
                  );
                },
                child: const Text(
                  'Add New Location',
                  style: TextStyle(
                    color: Color.fromRGBO(75, 25, 105, 1),
                    fontSize: 20.0,
                  ),
                ),
              ),
            ),
            SizedBox(height: 16.0),
            Container(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Saved Cards',
                style: TextStyle(
                  color: themeProvider.themeData.textTheme.bodyMedium?.color,
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: cards.length,
              itemBuilder: (context, index) {
                final CardItem = cards[index];
                return Container(
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Stack(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                CardItem.name,
                                style: const TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 8.0),
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
                                    icon: const Icon(Icons.edit),
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
                );
              },
            ),
            Container(
              padding: const EdgeInsets.all(6),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CardDetails()),
                  );
                },
                child: const Text(
                  'Add New Card',
                  style: TextStyle(
                    color: Color.fromRGBO(75, 25, 105, 1),
                    fontSize: 20.0,
                  ),
                ),
              ),
            ),
          ],
        ),
     ));
  }
}
class Location {
  final String name;
  final String address;

  Location({required this.name, required this.address});
}

final List<Location> locations = [
  Location(name: 'Home', address: 'No.26 Niwasa Mawatha, Kandana'),
  // Add more locations here
];

class CardItem {
  final String name;

  CardItem({required this.name});
}

final List<CardItem> cards = [
  CardItem(name: 'Visa'),
  // Add more card items here
];

