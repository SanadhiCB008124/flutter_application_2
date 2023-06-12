import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'theme_provider.dart';

class Product extends StatefulWidget {
  final String title;
  final String price;
  final String image;
  final String description;
 


  const Product({
    Key? key,
    required this.title,
    required this.price,
    required this.image,
    required this.description,
   

    
   
  }) : super(key: key);

  @override
  _ProductState createState() => _ProductState();
}

class _ProductState extends State<Product> {
  int value = 1;

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

 return Scaffold(
  
    body: OrientationBuilder(
      builder: (context, orientation) {
        // Portrait mode
        if (orientation == Orientation.portrait) {
          return buildPortraitLayout(themeProvider );
        }
        // Landscape mode
        else {
          return buildLandscapeLayout(themeProvider );
        }
      },
    ),
  );
}

Widget buildPortraitLayout(ThemeProvider themeProvider) {
  return Scaffold(
    appBar: AppBar(
      title: Text('Product'),),
  
  body :SingleChildScrollView(
    child: Column(
      children: [
        Container(
          margin: EdgeInsets.all(10.0),
          width: MediaQuery.of(context).size.width,
          
          child: Image.asset(widget.image, fit: BoxFit.cover),
        ),
        Container(
          alignment: Alignment.centerLeft,
          margin: EdgeInsets.all(8.0),
          child: Text(
            widget.title,
            style: TextStyle(
              color: themeProvider.themeData.textTheme.bodyLarge?.color,
              fontSize: 30.0,
              fontWeight: FontWeight.bold,
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
              color: themeProvider.themeData.textTheme.bodyMedium?.color,
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
            widget.price,
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
        SizedBox(height: 30.0),
   
        Container(
          margin: EdgeInsets.only(bottom: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
            
              ElevatedButton(
                onPressed: () {},
                child: Text('Add to Cart'),
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                  ),
                  backgroundColor: themeProvider.themeData.elevatedButtonTheme.style!.backgroundColor,
                  minimumSize: MaterialStateProperty.all(Size(150, 60)),
                ),
              ),
              ElevatedButton(
                onPressed: () {},
                child: Text('Buy Now'),
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                  ),
                  backgroundColor: themeProvider.themeData.elevatedButtonTheme.style!.backgroundColor,
                  minimumSize: MaterialStateProperty.all(Size(150, 60)),
                ),
              ),
             
            ],
          ),
        ),
      ],
    ),
  ));
}

Widget buildLandscapeLayout(ThemeProvider themeProvider) {
   return Scaffold(
      appBar: AppBar(
        title:  Text(widget.title),
      ),
      body:SingleChildScrollView(
        child: Center(
          child: Row(
          children: [
        
        Container(
             width: 300,
            
          child: Expanded(
         
          flex: 1,
          child: Container(
            decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(widget.image), // Provide the asset image path as a string
            fit: BoxFit.cover,
          ),
            ),
          ),
        ),
        ),
                SizedBox(width: 16),
                Expanded(
                 
                  flex: 2,
                  child: Column(
                   
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(padding: EdgeInsets.all(7.0)),
                       Text(
                        widget.title,

                        style: TextStyle(
                         fontSize: 30.0,
              fontWeight: FontWeight.bold,
                         
                        ),
                        
                      ),
                     
                      SizedBox(height: 16),
                      Text(
                        widget.description,
                        style: TextStyle(
                          fontSize: 18,
                         
                        ),
                      ),
                      SizedBox(height: 16),
                      Text(widget.price,
                        style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
                      ),
                    Row(
          children: [
           
            Icon(Icons.star, color: Colors.yellow),
            Icon(Icons.star, color: Colors.yellow),
            Icon(Icons.star, color: Colors.yellow),
            Icon(Icons.star, color: Colors.yellow),
            Icon(Icons.star_border, color: Colors.yellow),
            SizedBox(width: 10.0),
            Text('Reviews'),
          ],
        ),
      
          
           SizedBox(height: 16),
                      Row(
                        crossAxisAlignment: 
                        CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                         
                           ElevatedButton(
                  onPressed: () {},
                  child: Text('Add to Cart'),
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                    ),
                    backgroundColor: themeProvider.themeData.elevatedButtonTheme.style!.backgroundColor,
                    minimumSize: MaterialStateProperty.all(Size(150, 60)),
                  ),
                ),
                          SizedBox(width: 16),
                           ElevatedButton(
                  onPressed: () {},
                  child: Text('Buy Now'),
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                    ),
                    backgroundColor: themeProvider.themeData.elevatedButtonTheme.style!.backgroundColor,
                    minimumSize: MaterialStateProperty.all(Size(150, 60)),
                  ),
                ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
      ),
      );

}
}
