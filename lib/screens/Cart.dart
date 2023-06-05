import 'package:flutter/material.dart';
import 'package:flutter_application_2/screens/theme_provider.dart';
import 'package:provider/provider.dart';

class Cart extends StatelessWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
    style: ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
     backgroundColor: Theme.of(context).brightness == Brightness.dark
          ? Colors.grey[50] // Light purple color in dark mode
          : Colors.purple, // Purple color in light mode
    ),
    child: const Text("Go to Checkout"),
  ),
),

        ],
      ),
    );
  }

  Widget buildCartItem(Article item) {
    return Container(
      height: 136,
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
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        item.title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.add_box),
                        const Icon(Icons.delete),
                      ]
                          .map((e) => InkWell(
                                onTap: () {},
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: e,
                                ),
                              ))
                          .toList(),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  item.price,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
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

void main() {
  runApp(const MaterialApp(
    home: Cart(),
  ));
}
