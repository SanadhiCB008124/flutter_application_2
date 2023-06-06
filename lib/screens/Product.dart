import 'package:flutter/material.dart';
import 'package:flutter_application_2/screens/theme_provider.dart';
import 'package:provider/provider.dart';

import '../main.dart';

class Product extends StatefulWidget {

  final String title;
  final String price;
  final String image;
  final String description;

  const Product({Key? key,
   required this.title,
    required this.price,
     required this.image,
      required this.description
  
  }) : super(key: key);

  @override
  _ProductState createState() => _ProductState();
}


class _ProductState extends State<Product> {
  int value = 1;
 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text(widget.title),
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.all(10.0),
            width: MediaQuery.of(context).size.width,
            height: 300,
            child: Image.asset(widget.image, fit: BoxFit.cover),

          ),
          Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.all(8.0),
            child: Text(
              widget.title,
             
              style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          SizedBox(height: 5.0),
          Container(
            margin: EdgeInsets.all(10.0),
            child: Text(
              widget.description,
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.black,
              ),
            ),
          ),
          Row(
            children: [
              SizedBox(width: 10.0),
              Icon(Icons.star, color: Colors.yellow),
              Icon(Icons.star, color: Colors.yellow),
              Icon(Icons.star, color: Colors.yellow),
              Icon(Icons.star, color: Colors.yellow),
              Icon(Icons.star_border, color: Colors.yellow),
              SizedBox(width: 10.0),
              Text('Reviews'),
            ],
          ),
          Container(
            alignment: Alignment.bottomRight,
            margin: EdgeInsets.only(right: 22.0),
            child: Text(
              'Rs. 1000',
              style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
            ),
          ),
         
          Row(
            children: [
             
              GestureDetector(
                onTap: () {
                  setState(() {
                    value++;
                  });
                },
                child: Container(
                  margin: EdgeInsets.only(left: 22.0),
                  child:
                      Icon(Icons.add_box_rounded, size: 30.0, color: Colors.black),
                ),
              ),
              Container(
                child: Text(
                  value.toString(),
                  style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
                ),
              ),
              
              GestureDetector(
                onTap: () {
                  setState(() {
                    if (value > 1) {
                      value--;
                    }
                  });
                },
                child: Container(
                  child:
                      Icon(Icons.remove_circle_rounded, size: 30.0, color: Colors.black),
                ),
              ),
            ],
          ),
          SizedBox(height: 30.0),
           Container(
            margin: EdgeInsets.only(left: 22.0),
            child: Row(
              children: [
                ElevatedButton(
                
                  onPressed: () {
                   
                  },
                  
                child: Text('Add to Cart'),
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                  ),
                  minimumSize: MaterialStateProperty.all(Size(150, 60)),
                )
                ),
                SizedBox(width: 40.0),
                ElevatedButton(
                  onPressed: () {
                   
                  },
                  child: Text('Buy Now'),
                   style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                  ),
                  minimumSize: MaterialStateProperty.all(Size(150, 60)),
                )
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


