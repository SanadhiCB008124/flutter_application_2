import 'package:flutter/material.dart';

class Address extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Delivery Details'),
      ),
      body: const Padding(

        padding: EdgeInsets.all(16.0),
        
        child: Column(
          
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('saved locations',
            style: TextStyle(fontSize: 22)
            ,
            ),
            AddressBox(
              addressName: 'Home',
              addressDetails: 'No 26 Niwasa mawatha kandana',
            ),
            SizedBox(height: 16),
            Padding(padding:EdgeInsets.all(5)),
            AddressBox(
              addressName: 'Work',
              addressDetails: '123 uluporunewa road, Ja ela',
            ),
          ],
        ),
      ),
    );
  }
}

class AddressBox extends StatelessWidget {
  
  final String addressName;
  final String addressDetails;

  const AddressBox({
    required this.addressName,
    required this.addressDetails,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            addressName,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            addressDetails,
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: Address(),
  ));
}
