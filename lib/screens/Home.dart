import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/screens/Product.dart';
import 'package:provider/provider.dart';
import 'theme_provider.dart';
import 'package:flutter_application_2/screens/Cart.dart';
import 'package:flutter_application_2/screens/Favorites.dart';
import 'package:flutter_application_2/screens/Profile.dart';

class Home extends StatefulWidget {
  const Home({Key? key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  final List<String> items = ['Beverages', 'Food', 'Cakes'];
  late TabController _tabController;
  TextEditingController _searchController = TextEditingController();
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: items.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _onTabSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      body: OrientationBuilder(
        builder: (context, orientation) {
          // Portrait mode
          if (orientation == Orientation.portrait) {
            return buildPortraitLayout(themeProvider);
          }
          // Landscape mode
          else {
            return buildLandscapeLayout(themeProvider);
          }
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: themeProvider.themeData.bottomNavigationBarTheme.backgroundColor,
        currentIndex: _selectedIndex,
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
            Navigator.push(context, MaterialPageRoute(builder: (context) => Profile()));
          }
        },
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            backgroundColor: themeProvider.themeData.bottomNavigationBarTheme.backgroundColor,
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            backgroundColor: themeProvider.themeData.bottomNavigationBarTheme.backgroundColor,
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            backgroundColor: themeProvider.themeData.bottomNavigationBarTheme.backgroundColor,
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            backgroundColor: themeProvider.themeData.bottomNavigationBarTheme.backgroundColor,
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        selectedLabelStyle: TextStyle(fontSize: 0),
      ),
    );
  }

  Widget buildPortraitLayout(ThemeProvider themeProvider) {
    return Center(
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.only(left: 10, top: 30),
            child: const Text(
              'Explore',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              border: Border.all(
                color: themeProvider.isDark ? Colors.grey : Colors.purple,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: 'What would you like?',
                suffixIcon: IconButton(
                  icon: Icon(Icons.clear),
                  onPressed: () {
                    _searchController.clear();
                  },
                ),
              ),
              onChanged: (value) {},
            ),
          ),
          SizedBox(
            height: 60,
            width: double.infinity,
            child: TabBar(
              controller: _tabController,
              padding: const EdgeInsets.all(7),
              indicator: BoxDecoration(
                color: themeProvider.themeData.tabBarTheme!.indicatorColor,
                borderRadius: BorderRadius.circular(15),
              ),
              labelColor: themeProvider.themeData.tabBarTheme!.labelColor,
              physics: const BouncingScrollPhysics(),
              tabs: items.map((item) => Tab(text: item)).toList(),
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: items.map((category) => CategoryPage(category: category)).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildLandscapeLayout(ThemeProvider themeProvider) {
    return Center(
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                border: Border.all(
                  color: themeProvider.isDark ? Colors.grey : Colors.purple,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  hintText: 'What would you like?',
                  suffixIcon: IconButton(
                    icon: Icon(Icons.clear),
                    onPressed: () {
                      _searchController.clear();
                    },
                  ),
                ),
                onChanged: (value) {},
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            flex: 3,
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  alignment: Alignment.topLeft,
                  padding: const EdgeInsets.only(left: 10, top: 30),
                  child: const Text(
                    'Explore',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  height: 60,
                  width: double.infinity,
                  child: TabBar(
                    controller: _tabController,
                    padding: const EdgeInsets.all(7),
                    indicator: BoxDecoration(
                      color: themeProvider.themeData.tabBarTheme!.indicatorColor,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    labelColor: themeProvider.themeData.tabBarTheme!.labelColor,
                    physics: const BouncingScrollPhysics(),
                    tabs: items.map((item) => Tab(text: item)).toList(),
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: items.map((category) => CategoryPage(category: category)).toList(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CategoryPage extends StatefulWidget {
  final String category;

  const CategoryPage({Key? key, required this.category}) : super(key: key);

  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  late List<Article> filteredArticles;

  @override
  void initState() {
    super.initState();
    filteredArticles = _articles.where((article) => article.category == widget.category).toList();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: filteredArticles.length,
      itemBuilder: (BuildContext context, int index) {
        final item = filteredArticles[index];
        return buildArticleItem(item);
      },
    );
  }

  Widget buildArticleItem(Article item) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Product(
              title: item.title,
              price: item.price,
              image: item.imageUrl,
              description: item.description,
            ),
          ),
        );
      },
      child: Container(
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
                      Text(
                        item.title,
                        style: const TextStyle(fontSize: 18),
                        maxLines: 2,
                        overflow: TextOverflow.visible,
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
                  Text(
                    item.price,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}



class Article {
  final String title;
  final String price;
  final String imageUrl;
  final String category;
  final String description;
  bool isFavorite;

  Article({
    required this.title,
    required this.price,
    required this.imageUrl,
    required this.category,
    required this.description,
    this.isFavorite = false,
  });
}

final List<Article> _articles = [
  Article(
    title: "Caffe Latte",
    price: "900.00",
    imageUrl: "Assets/images/caffe latte.jpg",
    category: "Beverages",
    description: "A latte is a coffee drink made with espresso and steamed milk. The term as used in English is a shortened form of the Italian caffè latte, caffelatte or caffellatte, which means 'milk coffee'.",
  ),
  Article(
    title: "Cappucino",
    price: "900.00",
    imageUrl: "Assets/images/capuccino.jpg",
    category: "Beverages",
    description: "Capuccino is an espresso-based coffee drink that originated in Italy, and is traditionally prepared with steamed milk foam.",
  ),
   Article(
    title: "Macchiato",
    price: "900.00",
    imageUrl: "Assets/images/macchiato.jpg",
    category: "Beverages",
    description: "macchiato ,made with two shots of espresso",
  ),
   Article(
    title: "Espresso",
    price: "900.00",
    imageUrl: "Assets/images/espre.jpg",
    category: "Beverages",
    description: "Espresso is a coffee-brewing method of Italian origin, in which a small amount of nearly boiling water is forced under pressure through finely-ground coffee beans.",
  ),
  Article(
    title: "Iced Milo",
    price: "900.00",
    imageUrl: "Assets/images/iced milo.jpg",
    category: "Beverages",
    description: "Iced Milo , milo tea ",
  ),
  Article(
    title: "Iced Americano",
    price: "900.00",
    imageUrl: "Assets/images/iced americano.webp",
    category: "Beverages",
    description: "shots of espresso cooled with iced cubes.heaven on a warm day.",
  ),
   Article(
    title: "Iced Mocha",
    price: "900.00",
    imageUrl: "Assets/images/iced mocha.jpg",
    category: "Beverages",
    description: "Espresso is a coffee-brewing method of Italian origin, in which a small amount of nearly boiling water is forced under pressure through finely-ground coffee beans.",
  ),
  Article(
    title: "Strawberry Smoothie",
    price: "900.00",
    imageUrl: "Assets/images/strawberry smoothie.jpg",
    category: "Beverages",
    description: "Espresso is a coffee-brewing method of Italian origin, in which a small amount of nearly boiling water is forced under pressure through finely-ground coffee beans.",
  ),
  

  Article(
    title: "Bacon & Egg Sandwich",
    price: "900.00",
    imageUrl: "Assets/images/bacon and egg.jpg",
    category: "Food",
    description: "delicious bacon sandwich with a fried egg and a dash of tomato sauce",
  ),
  Article(
    title: "Chicken Sandwich",
    price: "900.00",
    imageUrl: "Assets/images/chicken sandwich.jpg",
    category: "Food",
    description: "crispy chicken lased with spicy bbq sauce"
  ),
  Article(
    title: "Croissant",
    price: "900.00",
    imageUrl: "Assets/images/croissant.jpg",
    category: "Food",
    description: "a cripsy outside and soft warm inside"
  ),
  Article(
    title: "Potato Cheese",
    price: "900.00",
    imageUrl: "Assets/images/potato cheese.jpg",
    category: "Food",
    description: "crispy potatoes and gooey cheese"
  ),
  Article(
    title: "Chocolate Fudge",
    price: "900.00",
    imageUrl: "Assets/images/fudge.jpg",
    category: "Cakes",
    description: "delicious hazelnut fudge"
  ),
  Article(
    title: "Red Velvet",
    price: "900.00",
    imageUrl: "Assets/images/red velvet.webp",
    category: "Cakes",
    description: "delicious red velvet cake with cream cheese frosting"
  ),
  Article(
    title: "Blueberry Cheesecake",
    price: "900.00",
    imageUrl: "Assets/images/lemon blueberry cheesecake.webp",
    category: "Cakes",
    description: "delicious blueberry cheesecake with a lemon twist"
  ),
  Article(
    title: "Chocolate Cake",
    price: "900.00",
    imageUrl: "Assets/images/chocolate cake with chocolate ganache.jpg",
    category: "Cakes",
    description: "delicious chocolate cake with chocolate ganache"
  ),
];


