import 'package:flutter/material.dart';

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
  const CardForm({Key? key}) : super(key: key);

  @override
  _CardFormState createState() => _CardFormState();
}

class _CardFormState extends State<CardForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          
          TextFormField(
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
          SizedBox(height: 16.0),
          TextFormField(
            decoration: const InputDecoration(
              border: OutlineInputBorder(borderRadius: BorderRadius.zero),
              labelText: 'Card Holder Name',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter the card holder name';
              }
              return null;
            },
          ),
           SizedBox(height: 16.0),
          TextFormField(
            decoration: const InputDecoration(
              border: OutlineInputBorder(borderRadius: BorderRadius.zero),
              labelText: 'Expiration Date',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter the expiration date';
              }
              return null;
            },
          ),
           SizedBox(height: 16.0),
          TextFormField(
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
                
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Form submitted')),
                );
              }
            },
            child: const Text('Submit'),
          )
            ],
          )
         ,
        ],
      ),
    );
  }
}
