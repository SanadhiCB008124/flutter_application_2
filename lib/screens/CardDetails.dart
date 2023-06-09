import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('cardNumber', _cardNumberController.text);
    prefs.setString('cardName', _cardNameController.text);
    prefs.setString('expirationMonth', _selectedMonth ?? '');
    prefs.setString('expirationYear', _selectedYear ?? '');
    prefs.setString('cvv', _cvvController.text);
    final cardName = _cardNameController.text;
    Provider.of<CardData>(context, listen: false).setCardName(cardName);
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
                  if (_formKey.currentState!.validate()) {
                    _saveFormData();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Form saved succesfully')),
                    );
                    final cardData = Provider.of<CardData>(context, listen: false);
      cardData.setCardName(_cardNameController.text);
      Navigator.pop(context, _cardNameController.text);
                  }
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
                      if (_formKey.currentState!.validate()) {
                        _saveFormData();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Form saved succesfully')),
                        );
                      final cardData = Provider.of<CardData>(context, listen: false);
      cardData.setCardName(_cardNameController.text);
      Navigator.pop(context, _cardNameController.text);  
                       
                      }
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
