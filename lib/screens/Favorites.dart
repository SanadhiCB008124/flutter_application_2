import 'dart:math';

import 'package:flutter/material.dart';

class Favorites extends StatefulWidget {
  const Favorites({Key? key}) : super(key: key);

  @override
  _FavoritesState createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Favorites"),
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
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(padding: EdgeInsets.all(6)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        item.title,
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          item.isFavorite = !item.isFavorite;
                        });
                      },
                      child: Icon(
                        item.isFavorite ? Icons.favorite : Icons.favorite_outline,
                        color: item.isFavorite ? Colors.red : null,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  item.price,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
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
  bool isFavorite;

  Article({
    required this.title,
    required this.price,
    required this.imageUrl,
    required this.category,
    this.isFavorite = false,
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
    home: Favorites(),
  ));
}
