import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'Cart.dart';
import 'Favorites.dart';
import 'Home.dart';
import 'theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/screens/CardDetails.dart';
import 'package:flutter_application_2/screens/Settings.dart';
import 'package:flutter_application_2/screens/Map.dart';

class Profile extends StatefulWidget {

  

  Profile({
    Key? key,
   
  }) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  late User? _user;
  int _selectedIndex = 3;
  List<CardDetailsClass> cardList = [];
  CardDetailsClass? cardDetailsvar;

 List<MapDetailsClass> mapList = [];
 MapDetailsClass? mapDetailsvar;


  @override
  void initState() {
    super.initState();
    _getUser();
    fetchCardDetails();
     fetchMapDetails(); 
  }

  Future<void> _getUser() async {
    User? user = FirebaseAuth.instance.currentUser;
    setState(() {
      _user = user;
    });
  }

void fetchCardDetails() async {
  FirebaseFirestore.instance.collection('CardDetails').get().then((value) {
    value.docs.forEach((result) {
      setState(() {
        cardList.add(CardDetailsClass(
          cardName: result.data()['cardName'] ?? '',
          cardNumber: result.data()['cardNumber'] ?? '',
          cardExpirymonth: result.data()['cardExpirymonth'] ?? '',
          cardExpiryyear: result.data()['cardExpiryyear'] ?? '',
          cardCVV: result.data()['cardCVV'] ?? '',
        ));
      });
    });

    // Print the values
    cardList.forEach((cardDetails) {
      print('Card Name: ${cardDetails.cardName}');
      print('Card Number: ${cardDetails.cardNumber}');
      print('Card Expiry Month: ${cardDetails.cardExpirymonth}');
      print('Card Expiry Year: ${cardDetails.cardExpiryyear}');
      print('Card CVV: ${cardDetails.cardCVV}');
      print('------');
    });
  });
}
void fetchMapDetails() async {
    FirebaseFirestore.instance.collection('MapDetails').get().then((value) {
      value.docs.forEach((result) {
        setState(() {
          mapList.add(MapDetailsClass(
     
            nickname: result.data()['nickname'] ?? '',
            address: result.data()['address'] ?? '',
          ));
        });
      });

      // Print the values
      mapList.forEach((mapDetails) {
        
        print('Nickname: ${mapDetails.nickname}');
        print('Address: ${mapDetails.address}');
        print('------');
      });
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
                MaterialPageRoute(builder: (context) => const AppSettings()),
              );
            },
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        unselectedItemColor: Theme.of(context).brightness == Brightness.dark
      ? Colors.grey
      : Color.fromARGB(255, 153, 116, 159),      
        onTap: (int index) {
          setState(() {
            _selectedIndex = index;
          });
          if (index == 0) {
            Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
          } else if (index == 1) {
            Navigator.push(context, MaterialPageRoute(builder: (context) => Favorites()));
          } else if (index == 2) {
            Navigator.push(context, MaterialPageRoute(builder: (context) => Cart()));
          } else if (index == 3) {
            Navigator.push(context, MaterialPageRoute(builder: (context) => Profile()));
          }
        },
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
            icon: Icon(
              Icons.home,
              size: 28,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
            icon: Icon(
              Icons.favorite,
              size: 28,
            ),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
            icon: Icon(
              Icons.shopping_cart,
              size: 28,
            ),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
            icon: Icon(
              Icons.person,
              size: 28,
            ),
            label: 'Profile',
          ),
        ],
        selectedLabelStyle: TextStyle(fontSize: 0),
      ),
      body: Center(
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            SizedBox(
              width: 100,
              height: 150,
              child: Icon(
                Icons.person_2_outlined,
                size: 100.0,
              ),
            ),
            const SizedBox(height: 16.0),
            Container(
              child: Text(
                'Hi! ${_user?.email ?? ''}',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Color.fromARGB(255, 173, 66, 192),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            Container(
              child: TextFormField(
                decoration: InputDecoration(
                  suffixIcon: Icon(Icons.edit),
                  labelText: 'Username',
                  labelStyle: TextStyle(
                    color: themeProvider.themeData.textTheme.bodyMedium?.color,
                  ),
                  
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
              itemCount: 1,
              itemBuilder: (context, _) {
                return Container(
                  child: Card(
                    color: Theme.of(context).brightness == Brightness.light
                        ? const Color.fromARGB(255, 173, 140, 179)
                        : Colors.grey,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Stack(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                //location name
                                 mapList.isNotEmpty ? mapList[0].nickname: '',
                                style:  TextStyle(
                                  fontSize: 20.0,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 6.0),
                              Padding(padding: EdgeInsets.all(10.0)),
                              Text(
                                //addreess
                                  mapList.isNotEmpty ? mapList[0].address: '',
                                style: TextStyle(
                                  fontSize: 18.0,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                          Align(
                            alignment: Alignment.topRight,
                            child: Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: const Icon(
                                      Icons.edit,
                                      color: Colors.black,
                                    ),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Map()),
                                      );
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
                    MaterialPageRoute(builder: (context) => Map()),
                  );
                },
                child: Text(
                  '+ Add New Location',
                  style: TextStyle(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.grey
                        : Color.fromRGBO(75, 25, 105, 1),
                    fontSize: 19.0,
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
            Container(
              child: Card(
                color: Theme.of(context).brightness == Brightness.light
                    ? const Color.fromARGB(255, 173, 140, 179)
                    : Colors.grey,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Stack(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            //cardname
                            cardList.isNotEmpty ? cardList[0].cardName : '',
                            style: TextStyle(
                            
                              fontSize: 20.0,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                            SizedBox(height: 6.0),
                              Padding(padding: EdgeInsets.all(10.0)),
                          Text(
                            //cardnumbe
                            cardList.isNotEmpty ? cardList[0].cardNumber : '',
                            style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.black,
                           
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
                                icon: const Icon(
                                  Icons.edit,
                                  color: Colors.black,
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => CardDetails()),
                                  );
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
              padding: const EdgeInsets.all(6),
              child: GestureDetector(
                onTap: () {
                  
                },
                child: Text(
                  '+ Add New Card',
                  style: TextStyle(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.grey
                        : Color.fromRGBO(75, 25, 105, 1),
                    fontSize: 19.0,
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


class CardDetailsClass {
  final String cardName;
  final String cardNumber;
  final String cardExpirymonth;
  final String cardExpiryyear;
  final String cardCVV;

  CardDetailsClass({
    required this.cardName,
    required this.cardNumber,
    required this.cardExpirymonth,
    required this.cardExpiryyear,
    required this.cardCVV,
  });
}
class MapDetailsClass {
 
  final String nickname;
  final String address;

  MapDetailsClass({
   
    required this.nickname,
    required this.address,
  });
}