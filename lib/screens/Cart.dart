import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Favorites.dart';
import 'Home.dart';
import 'Profile.dart';
import 'theme_provider.dart';

class Cart extends StatefulWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  int value = 1;
  int _selectedIndex = 2; // Add this line to define and initialize _selectedIndex

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
            width: 300,
            child: ElevatedButton(
              onPressed: () {},
              child: Text(" Checkout"),
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
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
      unselectedItemColor: Theme.of(context).brightness == Brightness.dark
      ? Colors.grey
      : Color.fromARGB(255, 153, 116, 159),     
        onTap: (int index) {
          setState(() {
            _selectedIndex = index;
          });
          if (index == 0) {
            Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
          } else if (index == 1) {
            Navigator.push(context, MaterialPageRoute(builder: (context) => Favorites()));
          } else if (index == 2) {
            Navigator.push(context, MaterialPageRoute(builder: (context) => Cart()));
          } else if (index == 3) {
            Navigator.push(context, MaterialPageRoute(builder: (context) => Profile(savedLocation: '', nickname: '')));
          }
        },
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
            icon: Icon(
              Icons.home,
              size: 28,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
            icon: Icon(
              Icons.favorite,
              size: 28,
            ),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
            icon: Icon(
              Icons.shopping_cart,
              size: 28,
            ),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
            icon: Icon(
              Icons.person,
              size: 28,
            ),
            label: 'Profile',
          ),
        ],
        selectedLabelStyle: TextStyle(fontSize: 0),
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
                  margin: EdgeInsets.only(top: 10),
                  child: Text(
                    item.title,
                    style: const TextStyle(fontSize: 20),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Container(
                  alignment: Alignment.topRight,
                  child: Icon(
                    Icons.delete,
                    color: Theme.of(context).brightness == Brightness.dark ? Colors.grey : Colors.black,
                  ),
                  margin: EdgeInsets.only(left: 200.0),
                ),
                Container(
                  child: Text(
                    item.price,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
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
    imageUrl: "Assets/images/macchiato.jpg", // Update the image paths to use lowercase 'assets'
    category: "Beverages",
  ),
  Article(
    title: "Fudge",
    price: "900.00",
    imageUrl: "Assets/images/fudge.jpg",
    category: "Cakes",
  ),
];
