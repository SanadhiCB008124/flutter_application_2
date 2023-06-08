import 'package:flutter/material.dart';
import 'package:date_field/date_field.dart';
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

class _CardFormState extends State<CardForm> {
  final _formKey = GlobalKey<FormState>();
  final _cardNumberController = TextEditingController();
  final _cardNameController = TextEditingController();
  final _cvvController = TextEditingController();
  DateTime? _expirationDate;

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
    prefs.setString('expirationDate', _expirationDate?.toString() ?? '');
    prefs.setString('cvv', _cvvController.text);
  }

  Future<void> _loadFormData() async {
    final prefs = await SharedPreferences.getInstance();
    final cardNumber = prefs.getString('cardNumber');
    final cardName = prefs.getString('cardName');
    final expirationDate = prefs.getString('expirationDate');
    final cvv = prefs.getString('cvv');

    // Use the retrieved values as needed
    _cardNumberController.text = cardNumber ?? '';
    _cardNameController.text = cardName ?? '';
    _cvvController.text = cvv ?? '';
    setState(() {
      _expirationDate = expirationDate != null
          ? DateTime.parse(expirationDate)
          : null;
    });
  }

  @override
  Widget build(BuildContext context) {
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
              if (value == null || value.isEmpty) {
                return 'Please enter the card number';
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
                return 'Please enter the card holder name';
              }
              return null;
            },
          ),
          const SizedBox(height: 16.0),
          DateTimeFormField(
            decoration: InputDecoration(
              border: OutlineInputBorder(borderRadius: BorderRadius.zero),
              labelText: 'Expiration Date',
              suffixIcon: Icon(Icons.calendar_today),
            ),
            mode: DateTimeFieldPickerMode.date,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (DateTime? value) {
              if (value == null) {
                return 'Please enter the expiration date';
              }
              return null;
            },
            onDateSelected: (DateTime value) {
              setState(() {
                _expirationDate = value;
              });
            },
            initialValue: _expirationDate,
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
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                _saveFormData();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Form submitted')),
                );
              }
            },
            child: const Text('Submit'),
          ),
        ],
      ),
    );
  }
}
