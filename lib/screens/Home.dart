import 'package:flutter/material.dart';
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
    return Scaffold(
      body: Column(
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
              border: Border.all(color: Colors.purple, width: 2),
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: ' What would you like?',
                suffixIcon: IconButton(
                  icon: Icon(Icons.clear),
                  onPressed: () {
                    _searchController.clear();
                  },
                ),
              ),
              onChanged: (value) {
                // Handle search query changes here
                // You can filter the articles based on the search query
              },
            ),
          ),
          SizedBox(
            height: 60,
            width: double.infinity,
            child: TabBar(
              controller: _tabController,
              padding: const EdgeInsets.all(7),
              indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: const Color(0xFF4B1969),
              ),
              labelColor: Colors.white,
              unselectedLabelColor: Colors.black,
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
      bottomNavigationBar: BottomNavigationBar(
        
        onTap: (int index) {
    setState(() {
      _selectedIndex = index;
    });
    if (index == 0) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
    } else if (index == 1) {
       Navigator.push(context, MaterialPageRoute(builder: (context) => Favorites()));
      // Handle other navigation options
    } else if (index == 2) {
       Navigator.push(context, MaterialPageRoute(builder: (context) => Cart()));
      // Handle other navigation options
    }
    else if(index == 3){
       Navigator.push(context, MaterialPageRoute(builder: (context) => Profile()));
    } 
  },
        items:  <BottomNavigationBarItem>[
          BottomNavigationBarItem(
     
            backgroundColor: Colors.purple,
            
            icon: Icon(Icons.home, ),
            label: 'Home',
           
           
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.purple,
            icon: Icon(Icons.favorite,),
         
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.purple,
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.purple,
            icon: Icon(Icons.person),
            label: 'Profile',
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
                    Text(
                      item.title,
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
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
                const SizedBox(height: 4),
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
    title: "Caffe Latte",
    price: "900.00",
    imageUrl: "Assets/images/macchiato.jpg",
    category: "Beverages",
  ),
  Article(
    title: "Macchiato",
    price: "900.00",
    imageUrl: "Assets/images/macchiato.jpg",
    category: "Beverages",
  ),
  Article(
    title: "Pizza",
    price: "900.00",
    imageUrl: "Assets/images/fudge.jpg",
    category: "Food",
  ),
  Article(
    title: "Burger",
    price: "900.00",
    imageUrl: "Assets/images/fudge.jpg",
    category: "Food",
  ),
  Article(
    title: "Chocolate Cake",
    price: "900.00",
    imageUrl: "Assets/images/fudge.jpg",
    category: "Cakes",
  ),
  Article(
    title: "Strawberry Cake",
    price: "900.00",
    imageUrl: "Assets/images/fudge.jpg",
    category: "Cakes",
  ),
];

void main() {
  runApp(const MaterialApp(
    home: Home(),
  ));
}
