import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class AddCard extends StatefulWidget {
  

  @override
  State<AddCard> createState() => _AddCardState();
}

class _AddCardState extends State<AddCard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Card'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: Colors.grey,
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: TextFormField(
              decoration: const InputDecoration(
                suffixIcon: const Icon(Icons.edit),
                labelText: 'Card Name',
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 12.0,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20.0),
          Container(
            margin: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: Colors.grey,
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: TextFormField(
              decoration: const InputDecoration(
                suffixIcon: const Icon(Icons.edit),
                labelText: 'Card Number',
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 12.0,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20.0),
          Container(
            margin: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: Colors.grey,
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: TextFormField(
              
              decoration: const InputDecoration(
                suffixIcon: const Icon(Icons.edit),
                labelText: 'CVV',
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 12.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
