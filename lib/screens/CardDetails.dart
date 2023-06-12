import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/screens/Profile.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:shared_preferences/shared_preferences.dart';

class CardDetails extends StatelessWidget {
  const CardDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Card Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: CardForm(),
      ),
    );
  }
}

class CardForm extends StatefulWidget {
  CardForm({Key? key}) : super(key: key);

  @override
  _CardFormState createState() => _CardFormState();
}
class CardData with ChangeNotifier {
  String cardName = '';

  void setCardName(String name) {
    cardName = name;
    notifyListeners();
  }
}




class _CardFormState extends State<CardForm> {
  final _formKey = GlobalKey<FormState>();
  final _cardNumberController = TextEditingController();
  final _cardNameController = TextEditingController();
  final _cvvController = TextEditingController();
  String? _selectedMonth;
  String? _selectedYear;

  @override
  void initState() {
    super.initState();
    _loadFormData();
  }

  @override
  void dispose() {
    _cardNumberController.dispose();
    _cardNameController.dispose();
    _cvvController.dispose();
    super.dispose();
  }

  Future<void> _saveFormData() async {
  // ...

  // Store card details in Firestore
  final firestore = FirebaseFirestore.instance;
  final userId = FirebaseAuth.instance.currentUser?.uid; // Replace with your user ID retrieval logic
  if (userId != null) {
    await firestore.collection('cardDetails').doc(userId).set({
      'cardNumber': _cardNumberController.text,
      'cardName': _cardNameController.text,
      'expirationMonth': _selectedMonth ?? '',
      'expirationYear': _selectedYear ?? '',
      'cvv': _cvvController.text,
    });
  }

  // ...
}

 void saveCardDetails() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      String uid = user.uid;

      DocumentReference cardDetailsCollection =
          FirebaseFirestore.instance.collection("CardDetails").doc(uid);

      // Check documnet exists
      bool documentExists = await cardDetailsCollection.get().then((doc) => doc.exists);

      if(documentExists) {
        await cardDetailsCollection.update({
          "cardNumber": _cardNumberController.text,
          "cardName": _cardNameController.text,
          "expirationMonth": _selectedMonth ?? '',
          "expirationYear": _selectedYear ?? '',
          "cvv": _cvvController.text,
        }).then((value) => 
          print("Card Details Updated")
        ).catchError((error) => 
          print("Failed to update card details: $error")
        
        );
      } else {
        await cardDetailsCollection.set({
          "cardNumber": _cardNumberController.text,
          "cardName": _cardNameController.text,
          "expirationMonth": _selectedMonth ?? '',
          "expirationYear": _selectedYear ?? '',
          "cvv": _cvvController.text,
        }).then((value) => 
          print("Card Details Added")
        ).catchError((error) => 
          print("Failed to add card details: $error")
        );
      }
    }
 }

  Future<void> _loadFormData() async {
    final prefs = await SharedPreferences.getInstance();
    final cardNumber = prefs.getString('cardNumber');
    final cardName = prefs.getString('cardName');
    final expirationMonth = prefs.getString('expirationMonth');
    final expirationYear = prefs.getString('expirationYear');
    final cvv = prefs.getString('cvv');

    setState(() {
      _cardNumberController.text = cardNumber ?? '';
      _cardNameController.text = cardName ?? '';
      _selectedMonth = expirationMonth;
      _selectedYear = expirationYear;
      _cvvController.text = cvv ?? '';
    });
  }
  

  Future<void> _checkStoredData() async {
    final prefs = await SharedPreferences.getInstance();
    final cardNumber = prefs.getString('cardNumber');
    final cardName = prefs.getString('cardName');
    final expirationMonth = prefs.getString('expirationMonth');
    final expirationYear = prefs.getString('expirationYear');
    final cvv = prefs.getString('cvv');

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Stored Data'),
          content: Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  initialValue: cardNumber,
                  decoration: const InputDecoration(labelText: 'Card Number'),
                ),
                TextFormField(
                  initialValue: cardName,
                  decoration: const InputDecoration(labelText: 'Card Name'),
                ),
                TextFormField(
                  initialValue: expirationMonth,
                  decoration: const InputDecoration(labelText: 'Expiration Month'),
                ),
                TextFormField(
                  initialValue: expirationYear,
                  decoration: const InputDecoration(labelText: 'Expiration Year'),
                ),
                TextFormField(
                  initialValue: cvv,
                  decoration: const InputDecoration(labelText: 'CVV'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildPortraitLayout() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: _cardNumberController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(borderRadius: BorderRadius.zero),
              labelText: 'Card Number',
            ),
            validator: (value) {
              if (value == null || value.isEmpty || value.length < 16 || value.contains(RegExp(r'[A-Z]'))) {
                return 'Please enter a valid card number';
              }
              return null;
            },
          ),
          const SizedBox(height: 16.0),
          TextFormField(
            controller: _cardNameController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(borderRadius: BorderRadius.zero),
              labelText: 'Card Name',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter the cardholder name';
              }
              return null;
            },
          ),
          const SizedBox(height: 16.0),
          Row(
            children: [
              Expanded(
                child: DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(borderRadius: BorderRadius.zero),
                    labelText: 'Expiration Month',
                  ),
                  value: _selectedMonth,
                  onChanged: (String? value) {
                    setState(() {
                      _selectedMonth = value;
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select the expiration month';
                    }
                    return null;
                  },
                  items: <String>[
                    'January',
                    'February',
                    'March',
                    'April',
                    'May',
                    'June',
                    'July',
                    'August',
                    'September',
                    'October',
                    'November',
                    'December',
                  ].map<DropdownMenuItem<String>>(
                    (String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    },
                  ).toList(),
                ),
              ),
              const SizedBox(width: 16.0),
              Expanded(
                child: DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(borderRadius: BorderRadius.zero),
                    labelText: 'Expiration Year',
                  ),
                  value: _selectedYear,
                  onChanged: (String? value) {
                    setState(() {
                      _selectedYear = value;
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select the expiration year';
                    }
                    return null;
                  },
                  items: <String>[
                    '2023',
                    '2024',
                    '2025',
                    '2026',
                    '2027',
                    '2028',
                  ].map<DropdownMenuItem<String>>(
                    (String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    },
                  ).toList(),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16.0),
          TextFormField(
            controller: _cvvController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(borderRadius: BorderRadius.zero),
              labelText: 'CVV',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter the CVV';
              }
              return null;
            },
          ),
          const SizedBox(height: 16.0),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  saveCardDetails();
                  Navigator.pop(context);
                },
                child: const Text('Save'),
              ),
              const SizedBox(width: 16.0),
           //   ElevatedButton(
             //   onPressed: () {
             //     _checkStoredData();
             //   },
             //   child: const Text('Saved Cards'),
             // ),
            ],
          ),
        ],
      ),
    );
  }


  Widget _buildLandscapeLayout() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _cardNumberController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(borderRadius: BorderRadius.zero),
                  labelText: 'Card Number',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty || value.length < 16 || value.contains(RegExp(r'[A-Z]'))) {
                    return 'Please enter a valid card number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _cardNameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(borderRadius: BorderRadius.zero),
                  labelText: 'Card Name',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the cardholder name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              Row(
                children: [
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(borderRadius: BorderRadius.zero),
                        labelText: 'Expiration Month',
                      ),
                      value: _selectedMonth,
                      onChanged: (String? value) {
                        setState(() {
                          _selectedMonth = value;
                        });
                      },
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Please select the expiration month';
                        }
                        return null;
                      },
                      items: <String>[
                        'January',
                        'February',
                        'March',
                        'April',
                        'May',
                        'June',
                        'July',
                        'August',
                        'September',
                        'October',
                        'November',
                        'December',
                      ].map<DropdownMenuItem<String>>(
                        (String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        },
                      ).toList(),
                    ),
                  ),
                  const SizedBox(width: 16.0),
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(borderRadius: BorderRadius.zero),
                        labelText: 'Expiration Year',
                      ),
                      value: _selectedYear,
                      onChanged: (String? value) {
                        setState(() {
                          _selectedYear = value;
                        });
                      },
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Please select the expiration year';
                        }
                        return null;
                      },
                      items: <String>[
                        '2023',
                        '2024',
                        '2025',
                        '2026',
                        '2027',
                        '2028',
                      ].map<DropdownMenuItem<String>>(
                        (String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        },
                      ).toList(),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _cvvController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(borderRadius: BorderRadius.zero),
                  labelText: 'CVV',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the CVV';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      saveCardDetails();
                      Navigator.pop(context);  
                    },
                    child: const Text('Save'),
                  ),
                  const SizedBox(width: 16.0),
                //  ElevatedButton(
                 //   onPressed: () {
                 //     _checkStoredData();
                 //   },
                 //   child: const Text('Saved Cards'),
                 // ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }


 @override
Widget build(BuildContext context) {
  return ChangeNotifierProvider(
    create: (_) => CardData(),
    child: OrientationBuilder(
      builder: (BuildContext context, Orientation orientation) {
        if (orientation == Orientation.portrait) {
          return _buildPortraitLayout();
        } else {
          return _buildLandscapeLayout();
        }
      },
    ),
  );
}

}
