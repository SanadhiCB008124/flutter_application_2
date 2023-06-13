import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'theme_provider.dart';
import 'package:flutter_application_2/screens/Product.dart';
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
  List<Article> articles = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: items.length, vsync: this);
    loadArticles();
  }

  Future<void> loadArticles() async {
    String jsonString = await rootBundle.loadString('Assets/articles.json');
    List<dynamic> jsonList = json.decode(jsonString);
    setState(() {
      articles = jsonList.map((item) => Article.fromJson(item)).toList();
    });
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
        backgroundColor:
            themeProvider.themeData.bottomNavigationBarTheme.backgroundColor,
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
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Home()));
          } else if (index == 1) {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Favorites()));
          } else if (index == 2) {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Cart()));
          } else if (index == 3) {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Profile()));
          }
        },
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            backgroundColor:
                themeProvider.themeData.bottomNavigationBarTheme.backgroundColor,
            icon: Icon(
              Icons.home,
              size: 28,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            backgroundColor:
                themeProvider.themeData.bottomNavigationBarTheme.backgroundColor,
            icon: Icon(
              Icons.favorite,
              size: 28,
            ),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            backgroundColor:
                themeProvider.themeData.bottomNavigationBarTheme.backgroundColor,
            icon: Icon(
              Icons.shopping_cart,
              size: 28,
            ),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            backgroundColor:
                themeProvider.themeData.bottomNavigationBarTheme.backgroundColor,
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

Widget buildPortraitLayout(ThemeProvider themeProvider) {
  return Center(
    child: Column(
      children: [
        SizedBox(height: 10),
        Container(
        
          margin: const EdgeInsets.symmetric(vertical: 10),
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.only(left: 15, top: 30),
          child: const Text(
            'Explore !',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.all(6),
          child: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  
                  color:  Colors.purple,
                  width: 1,
                ),
              ),
              prefixIcon: Icon(Icons.search),
              hintText: 'What would you like?',
              hintStyle: TextStyle(
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.grey
                    : Color(0xFF4B1969),
                fontSize: 17,
              ),
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
            children: items
                .map((category) => CategoryPage(
                      category: category,
                      articles: articles,
                    ))
                .toList(),
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
          const SizedBox(width: 10),
          Expanded(
            flex: 5,
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  alignment: Alignment.topLeft,
                  padding: const EdgeInsets.only(left: 10, top: 30),
                  child: const Text(
                    'Explore',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  height: 50,
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
                    children: items
                        .map((category) => CategoryPage(category: category, articles: articles))
                        .toList(),
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
  final List<Article> articles;

  const CategoryPage({Key? key, required this.category, required this.articles}) : super(key: key);

  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  late List<Article> filteredArticles;

  @override
  void initState() {
    super.initState();
    filteredArticles = widget.articles
        .where((article) => article.category == widget.category)
        .toList();
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
    final themeProvider = Provider.of<ThemeProvider>(context);
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
          border: Border.all(
            color: themeProvider.isDark ? Color.fromARGB(255, 52, 51, 51) : Colors.purple,
          ),
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
                          color: item.isFavorite
                              ? (themeProvider.isDark ? Colors.red : Colors.red)
                              : (themeProvider.isDark ? Colors.white : Colors.black),
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

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      title: json['title'],
      price: json['price'],
      imageUrl: json['imageUrl'],
      category: json['category'],
      description: json['description'],
    );
  }
}
