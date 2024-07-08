import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Bottom Navigation Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
      routes: {
        '/login': (context) => LoginPage(),
        '/orders': (context) => OrdersPage(), // Register the orders route
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;

  final List<Widget> _tabs = [
    HomePage(),
    OrdersPage(), // Corrected: This should be the instance of OrdersPage widget
    
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kitchen Groceries'),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              // Handle item selection
              switch (value) {
                case 'login':
                  Navigator.pushNamed(context, '/login');
                  break;
                case 'orders':
                  Navigator.pushNamed(context, '/orders');
                  break;
                case 'contact':
                  // Handle contact action
                  print('Contact selected');
                  break;
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              PopupMenuItem<String>(
                value: 'login',
                child: Text('Login'),
              ),
              PopupMenuItem<String>(
                value: 'orders',
                child: Text('Orders'),
              ),
              PopupMenuItem<String>(
                value: 'contact',
                child: Text('Contact'),
              ),
            ],
          ),
        ],
      ),
      
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Orders',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      children: [
        _buildGridItem(context, 'Vegetables', 'https://media.istockphoto.com/id/1203599923/photo/food-background-with-assortment-of-fresh-organic-vegetables.jpg?s=612x612&w=0&k=20&c=DZy1JMfUBkllwiq1Fm_LXtxA4DMDnExuF40jD8u9Z0Q=', Icons.shopping_basket),
        _buildGridItem(context, 'Fruits', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaVSaCcQy85soS7b-9Jhm9tRMf5B_U79SduQ&s', Icons.shopping_basket),
        _buildGridItem(context, 'Dairy', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSjZDTVlU-ElepZxdA-HQ3P8OIjtVgsslHy_Q&s', Icons.local_dining),
        _buildGridItem(context, 'Meat', 'https://t3.ftcdn.net/jpg/02/26/53/80/360_F_226538033_C42p96JDNwkSdQs86Agxd1TtaVJsyJ71.jpg', Icons.restaurant),
      ],
    );
  }

  Widget _buildGridItem(BuildContext context, String title, String imageUrl, IconData icon) {
    return Card(
      elevation: 2,
      child: InkWell(
        onTap: () {
          // Handle grid item tap
          print('$title tapped');
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
              imageUrl,
              height: 100,
              width: 100,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 10),
            Text(
              title,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

class OrdersPage extends StatelessWidget {
  // Example list of orders
  final List<Map<String, dynamic>> orders = [
    {
      'id': '1',
      'name': 'Tomatoes',
      'description': 'This is the description for Order 1.',
      'imageUrl': ('https://t4.ftcdn.net/jpg/05/37/04/61/360_F_537046123_s8JVn2NrClPQDOryhSm8jonYZPfIzPRX.jpg'),
    },
    {
      'id': '2',
      'name': 'potatoes',
      'description': 'This is the description for Order 2.',
      'imageUrl': 'https://5.imimg.com/data5/UV/IF/MY-41885957/potatoes.jpg',
    },
    {
      'id': '3',
      'name': 'Brinjal',
      'description': 'This is the description for Order 3.',
      'imageUrl': 'https://fastandfresh.in/cdn/shop/products/smallbrinjal_800x.jpg?v=1655523186',
    },
    {
      'id': '4',
      'name': 'Lady/''s Finger',
      'description': 'This is the description for Order 4.',
      'imageUrl': 'https://www.trustbasket.com/cdn/shop/articles/Lady_Finger.webp?v=1681366481',
    },
    {
      'id': '5',
      'name': 'Drumstick',
      'description': 'This is the description for Order 5.',
      'imageUrl': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRqiC_btKP-ey2cM1Kccw_Jt08nqJrzJv-fSA&s',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Orders Page'),
      ),
      body: ListView.builder(
        itemCount: orders.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 2,
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(orders[index]['imageUrl']),
              ),
              title: Text(orders[index]['name']),
              subtitle: Text(orders[index]['description']),
              onTap: () {
                // Handle tapping on an order item if needed
                print('Tapped on order: ${orders[index]['name']}');
              },
            ),
          );
        },
      ),
    );
  }
}

class ProfilePage extends StatelessWidget {
  final  user;

  ProfilePage({required this.user});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Profile Page',
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(height: 20),
          Text(
            'Name: ${user.name}',
            style: TextStyle(fontSize: 18),
          ),
          Text(
            'Email: ${user.email}',
            style: TextStyle(fontSize: 18),
          ),
          Text(
            'Phone: ${user.phone}',
            style: TextStyle(fontSize: 18),
          ),
          Text(
            'Address: ${user.address}',
            style: TextStyle(fontSize: 18),
          ),
        ],
      ),
    );
  }
}



class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(20.0),
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Username',
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20.0),
              child: TextField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // Perform login functionality
                Navigator.pop(context); // Go back to previous screen (home page)
              },
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
