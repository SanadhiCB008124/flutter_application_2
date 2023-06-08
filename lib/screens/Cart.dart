import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'theme_provider.dart';

class Cart extends StatefulWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  int value = 1;

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _articles.length,
              itemBuilder: (BuildContext context, int index) {
                final item = _articles[index];
                return buildCartItem(item);
              },
            ),
          ),
          Container(
            margin: const EdgeInsets.all(10),
            height: 60,
            width: 300,
            child: ElevatedButton(
              onPressed: () {},
              child: Text("Go to Checkout"),
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                ),
                backgroundColor: themeProvider.themeData.elevatedButtonTheme.style!.backgroundColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCartItem(Article item) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8.0),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFE0E0E0)),
        borderRadius: BorderRadius.circular(8.0),
      ),
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(8.0),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(item.imageUrl),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 Container(
                  margin: EdgeInsets.only(top:10),
                      child: Text(
                        item.title,
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Container(
                      child: Icon(Icons.delete),
                      margin: EdgeInsets.only(left: 200.0)
                      ),


                    
                    Container(
               child: Text(
                  item.price,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                    ),
               
                const SizedBox(height: 8),
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
                        child: Icon(
                          Icons.add_box_rounded,
                          size: 30.0,
                          color: themeProvider.isDark ? Colors.grey : Colors.black,
                        ),
                      ),
                    ),
                    SizedBox(width: 10.0),
                    Container(
                      child: Text(
                        value.toString(),
                        style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(width: 10.0),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          if (value > 1) {
                            value--;
                          }
                        });
                      },
                      child: Container(
                        child: Icon(
                          Icons.remove_circle_rounded,
                          size: 30.0,
                          color: themeProvider.isDark ? Colors.grey : Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
               
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Article {
  final String title;
  final String price;
  final String imageUrl;
  final String category;

  Article({
    required this.title,
    required this.price,
    required this.imageUrl,
    required this.category,
  });
}

final List<Article> _articles = [
  Article(
    title: "Macchiato",
    price: "900.00",
    imageUrl: "Assets/images/macchiato.jpg",
    category: "Beverages",
  ),
  Article(
    title: "Fudge",
    price: "900.00",
    imageUrl: "Assets/images/fudge.jpg",
    category: "Cakes",
  ),
];
