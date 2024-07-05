import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Veg cart',
      theme: ThemeData(
        primarySwatch: Colors.lime,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Colors.orangeAccent,
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.grey,
          selectedIconTheme: IconThemeData(size: 30),
        ),
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[
    LoginScreen(),
    ProductScreen(),
    AboutScreen(),
    CategoriesScreen(),
  ];

  static List<int> _appBarScreens = [1]; // Index of screens that require app bar

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBarScreens.contains(_selectedIndex)
          ? AppBar(
        title: Row(
          children: [
            Image.network(
              'https://tse4.mm.bing.net/th?id=OIP.a8gbKR-RqJnXb0Yaf0VAHwHaHa&pid=Api&P=0&h=220',
              width: 30, // Adjust size as needed
              height: 30, // Adjust size as needed
            ),
            SizedBox(width: 8),
            Text('Veg cart'),
          ],
        ),
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // Handle search button press
              showSearch(
                context: context,
                delegate: CustomSearchDelegate(),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              // Navigate to CartScreen
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => CartScreen(),
                ),
              );
            },
          ),
        ],
      )
          : null,
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.login),
            label: 'Login',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            label: 'About',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Categories',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        selectedIconTheme: IconThemeData(size: 30),
        onTap: _onItemTapped,
      ),
    );
  }
}

class LoginScreen extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _submitForm(BuildContext context) {
    String username = _usernameController.text;
    String password = _passwordController.text;

    // Basic validation (you can implement more advanced validation logic here)
    if (username == 'asdf' && password == '1234') {
      print('Username: $username');
      print('Password: $password');

      // Navigate to HomeScreen after successful login
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    } else {
      // Show an error message or handle invalid input
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Invalid username or password.'),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Set background color for the scaffold
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          // Background image
          Image.network(
            'https://images.pexels.com/photos/1103970/pexels-photo-1103970.jpeg?auto=compress&cs=tinysrgb&w=600',
            fit: BoxFit.cover,
          ),
          // Login form centered
          Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.8, // Adjust width as needed
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.white.withOpacity(0.8), // White with opacity
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    TextFormField(
                      controller: _usernameController,
                      decoration: InputDecoration(
                        labelText: 'Username',
                        labelStyle: TextStyle(color: Colors.black), // Label text color
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black), // Border color when focused
                        ),
                      ),
                    ),
                    SizedBox(height: 20.0),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        labelStyle: TextStyle(color: Colors.black), // Label text color
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black), // Border color when focused
                        ),
                      ),
                    ),
                    SizedBox(height: 20.0),
                    ElevatedButton(
                      onPressed: () {
                        _submitForm(context);
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 12.0),
                        child: Text(
                          'Login',
                          style: TextStyle(fontSize: 18.0),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ProductScreen extends StatelessWidget {
  final List<Map<String, String>> products = [
    {
      'image': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRNn3pvz6CHZj95XWihyMR3gb-rLlwddC7low&s',
      'title': 'Brijal',
      'price': '₹45/kg',
      'discount': '70% savings',
      'mrp': 'M.R.P.: ₹',
      'taxes': 'Inclusive of all taxes',
    },
    {
      'image': 'https://static.nike.com/a/images/t_PDP_1280_v1/f_auto,q_auto:eco/99486859-0ff3-46b4-949b-2d16af2ad421/custom-nike-dunk-high-by-you-shoes.png',
      'title': 'Nike Mens Jordan 1 Retro High Sneaker',
      'price': '₹11,477.00',
      'discount': '18% savings',
      'mrp': 'M.R.P.: ₹13,995.00',
      'taxes': 'Inclusive of all taxes',
    },
    {
      'image': 'https://tse4.mm.bing.net/th?id=OIP.7XCMtor7_6KWLQlRLkcNsgHaHa&pid=Api&P=0&h=220',
      'title': 'Woodland men\'s Ogb 2975118nw Ankle Boot',
      'price': '₹3,417.00',
      'discount': '40% savings',
      'mrp': 'M.R.P.: ₹5,695.00',
      'taxes': 'Inclusive of all taxes',
    },
    {
      'image': 'https://tse4.mm.bing.net/th?id=OIP.a2BcAZC1adH1vu8p6htnVwHaHa&pid=Api&P=0&h=220',
      'title': 'Liberty Mens Roger-e Sneaker',
      'price': '₹665.00',
      'discount': '63% savings',
      'mrp': 'M.R.P.: ₹1,799.00',
      'taxes': 'Inclusive of all taxes',
    },
    {
      'image': 'https://tse1.mm.bing.net/th?id=OIP.MnyAcw0WUfF0ocAOF8IJXAHaE_&pid=Api&P=0&h=220',
      'title': 'SPARX mens Sx0643g Sneakers',
      'price': '₹759.00',
      'discount': '62% savings',
      'mrp': 'M.R.P.: ₹1,999.00',
      'taxes': 'Inclusive of all taxes',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.all(8.0),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(products[index]['image']!),
                  SizedBox(height: 8.0),
                  Text(
                    products[index]['title']!,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    products[index]['price']!,
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.green,
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    products[index]['discount']!,
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.red,
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    products[index]['mrp']!,
                    style: TextStyle(
                      fontSize: 14.0,
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    products[index]['taxes']!,
                    style: TextStyle(
                      fontSize: 14.0,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class AboutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage('https://tse2.mm.bing.net/th?id=OIP.JkcYOovXGNijhryz145aHwHaEK&pid=Api&P=0&h=220'),
            fit: BoxFit.cover,
          ),
        ),
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.network(
              'https://tse4.mm.bing.net/th?id=OIP.a8gbKR-RqJnXb0Yaf0VAHwHaHa&pid=Api&P=0&h=220',
              width: 100, // Adjust size as needed
              height: 100, // Adjust size as needed
            ),
            SizedBox(height: 16.0),
            Text(
              'Welcome to Shoe Shack!',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'Your ultimate destination for high-quality footwear. At Shoe Shack, we believe in providing our customers with the best products, at the best prices, and with the best service.',
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.black54,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16.0),
            Text(
              'Why Choose Us?',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              '• Wide variety of styles and brands\n'
                  '• Competitive prices\n'
                  '• Easy and secure online shopping\n'
                  '• Fast and reliable delivery\n'
                  '• Excellent customer service',
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.black54,
              ),
              textAlign: TextAlign.left,
            ),
          ],
        ),
      ),
    );
  }
}


class CategoriesScreen extends StatelessWidget {
  final List<Map<String, String>> categories = [
    {
      'image': 'https://tse4.mm.bing.net/th?id=OIP.q-8NK3Q9M-pjiPbAHISK7gHaHa&pid=Api&P=0&h=220',
      'title': 'Men\'s Shoes',
    },
    {
      'image': 'https://tse2.mm.bing.net/th?id=OIP.x4AM_rtqvQ2jA-0rzzGoawHaHa&pid=Api&P=0&h=220',
      'title': 'Women\'s Shoes',
    },
    {
      'image': 'https://tse3.mm.bing.net/th?id=OIP.4kl4OliF9t9j1lQZqlEOuAHaHa&pid=Api&P=0&h=220',
      'title': 'Kids\' Shoes',
    },
    {
      'image': 'https://tse2.mm.bing.net/th?id=OIP.32ZKVt4-iByZ4RJrgPHFigHaE7&pid=Api&P=0&h=220',
      'title': 'Other Shoes',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Categories'),
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
        ),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              if (categories[index]['title'] == "Men's Shoes") {
                // Navigate or expand to show the mini bars
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => MenShoesScreen(),
                ));
              } else if (categories[index]['title'] == "Women's Shoes") {
                // Navigate or expand to show the mini bars for Women's Shoes
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => WomenShoesScreen(),
                ));
              } else if (categories[index]['title'] == "Kids' Shoes") {
                // Navigate or expand to show the mini bars for Kids' Shoes
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => KidsShoesScreen(),
                ));
              } else {
                // Handle navigation for other categories if needed
              }
            },
            child: Card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Image.network(
                      categories[index]['image']!,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      categories[index]['title']!,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class MenShoesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Men's Shoes"),
      ),
      body: ListView(
        children: [
          ExpansionTile(
            title: Text('Mens'),
            children: [
              ListTile(
                title: Text('Casual Shoes'),
                onTap: () {
                  // Handle Casual Shoes tap
                },
              ),
              ListTile(
                title: Text('Formal Shoes'),
                onTap: () {
                  // Handle Formal Shoes tap
                },
              ),
              ListTile(
                title: Text('Sports Shoes'),
                onTap: () {
                  // Handle Sports Shoes tap
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class WomenShoesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Women's Shoes"),
      ),
      body: ListView(
        children: [
          ExpansionTile(
            title: Text('Subcategories'),
            children: [
              ListTile(
                title: Text('Casual Shoes'),
                onTap: () {
                  // Handle Casual Shoes tap
                },
              ),
              ListTile(
                title: Text('Formal Shoes'),
                onTap: () {
                  // Handle Formal Shoes tap
                },
              ),
              ListTile(
                title: Text('Sports Shoes'),
                onTap: () {
                  // Handle Sports Shoes tap
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class KidsShoesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Kids' Shoes"),
      ),
      body: ListView(
        children: [
          ExpansionTile(
            title: Text('Subcategories'),
            children: [
              ListTile(
                title: Text('Boys Shoes'),
                onTap: () {
                  // Handle Boys Shoes tap
                },
              ),
              ListTile(
                title: Text('Girls Shoes'),
                onTap: () {
                  // Handle Girls Shoes tap
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
      ),
      body: Center(
        child: Text('Your cart is empty.'),
      ),
    );
  }
}

class CustomSearchDelegate extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Implement search results
    return Center(
      child: Text('No results found for "$query"'),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Suggestions that appear when typing in the search field
    return Center(
      child: Text('Enter your search query'),
    );
  }
}