import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CommuniMate',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    ContactList(),
    UpdatesScreen(),
    GroupsPage(), // Corrected placement
    CallList(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 62, 194, 62),
        title: Text('CommuniMate'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(context: context, delegate: ContactSearchDelegate());
            },
          ),
          IconButton(
            icon: Icon(Icons.qr_code),
            onPressed: () {
              // Handle QR code icon tap
              print('QR Code tapped');
            },
          ),
          PopupMenuButton<String>(
            onSelected: (value) {
              // Handle menu item selection
              print('Selected: $value');
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                value: 'New group',
                child: Text('New group'),
              ),
              const PopupMenuItem<String>(
                value: 'New broadcast',
                child: Text('New broadcast'),
              ),
              const PopupMenuItem<String>(
                value: 'Linked devices',
                child: Text('Linked devices'),
              ),
              const PopupMenuItem<String>(
                value: 'Payments',
                child: Text('Payments'),
              ),
              const PopupMenuItem<String>(
                value: 'Settings',
                child: Text('Settings'),
              ),
            ],
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text('Satya Sai'), // Replace with actual username
              accountEmail: Text('satyasai@gmail.com'), // Replace with actual email
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('lib/assets/images/Satya.jpeg'), // Replace with actual avatar image
              ),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 142, 239, 109),
              ),
              onDetailsPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UserDetailsPage(
                      name: 'Satya Sai',
                      email: 'satyasai@gmail.com',
                      phoneNumber: '123-456-7890',
                      address: '123 Main St, City, Country',
                    ),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(
                Icons.person,
                color: Color.fromARGB(255, 49, 221, 64),
              ),
              title: Text('My account'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                // Add functionality for "My account"
                print('My account tapped');
              },
            ),
            ListTile(
              leading: Icon(
                Icons.info_outline,
                color: Colors.greenAccent,
              ),
              title: Text('About'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                // Add functionality for "About"
                print('About tapped');
              },
            ),
          ],
        ),
      ),
      backgroundColor: Color.fromARGB(255, 247, 252, 245),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(255, 247, 252, 245), // Light green background color
              Color.fromARGB(255, 247, 252, 245), // Light green accent color
            ],
            stops: [0.4, 1.0],
          ),
        ),
        child: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color.fromARGB(255, 9, 240, 9),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Color.fromARGB(255, 244, 248, 244),
        unselectedItemColor: Color.fromARGB(255, 248, 248, 248),
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
        unselectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble_outline),
            label: 'Chats',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.circle_notifications_rounded),
            label: 'Updates',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.group_add_outlined),
            label: 'Groups',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.call_outlined),
            label: 'Calls',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}

class UserDetailsPage extends StatelessWidget {
  final String name;
  final String email;
  final String phoneNumber;
  final String address;

  const UserDetailsPage({
    Key? key,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.address,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 62, 194, 62),
        title: Text('User Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Name: $name',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 8),
            Text(
              'Email: $email',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 8),
            Text(
              'Phone Number: $phoneNumber',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 8),
            Text(
              'Address: $address',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}

class ContactList extends StatelessWidget {
  final String searchQuery;
  const ContactList({Key? key, this.searchQuery = ''}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> contacts = [
      {'name': 'Boyapati Sreenu', 'image': 'lib/assets/images/download (8).jpeg'},
      {'name': 'Sardhar valabhai patel', 'image': 'lib/assets/images/download (1).jpeg'},
      {'name': 'magal damodar', 'image': 'lib/assets/images/download (2).jpeg'},
      {'name': 'Bhagat Singh', 'image': 'lib/assets/images/download (3).jpeg'},
      {'name': 'Gandhi ', 'image': 'lib/assets/images/download (4).jpeg'},
      {'name': 'Bose Babai', 'image': 'lib/assets/images/download (5).jpeg'},
      {'name': 'Jakkana', 'image': 'lib/assets/images/download (6).jpeg'},
      {'name': 'Jagan', 'image': 'lib/assets/images/download (7).jpeg'},
      {'name': 'Chandu Bro', 'image': 'lib/assets/images/images (1).jpeg'},
      {'name': 'Ambedkhar ji', 'image': 'lib/assets/images/images (2).jpeg'},
      {'name': 'Kalam', 'image': 'lib/assets/images/images (3).jpeg'},
      {'name': 'Sukumar ', 'image': 'lib/assets/images/images (4).jpeg'},
      {'name': 'Trivikram', 'image': 'lib/assets/images/images (5).jpeg'},
      {'name': 'Sid Sri ram', 'image': 'lib/assets/images/images (6).jpeg'},
      {'name': 'Balu Sir', 'image': 'lib/assets/images/images (7).jpeg'},
      {'name': 'Mahesh ', 'image': 'lib/assets/images/images.jpeg'},
    ];

    return ListView.builder(
      itemCount: contacts.length,
      itemBuilder: (context, index) {
        final contact = contacts[index];
        final contactName = contact['name']!;
        if (searchQuery.isNotEmpty &&
            !contactName.toLowerCase().contains(searchQuery.toLowerCase())) {
          return Container();
        }
        return ListTile(
          leading: CircleAvatar(
            backgroundImage: AssetImage(contact['image']!),
          ),
          title: Text(contactName),
          subtitle: Text('Online'),
        );
      },
    );
  }
}

class ContactSearchDelegate extends SearchDelegate<String> {
  @override
  List<Widget>? buildActions(BuildContext context) {
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
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return ContactList(searchQuery: query);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return ContactList(searchQuery: query);
  }
}

class CallList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) {
        return ListTile(
          leading: CircleAvatar(
            backgroundImage: AssetImage('lib/assets/images/Satya.jpeg'),
          ),
          title: Text('Call $index'),
          subtitle: Text('Yesterday, 9:00 AM'),
          trailing: Icon(Icons.call, color: Color.fromARGB(255, 4, 228, 8)),
        );
      },
    );
  }
}

class GroupsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Map<String, List<Map<String, String>>> groups = {
      'Freedom fighters': [
        
        {'name': 'Bhagat Singh', 'image': 'lib/assets/images/download (3).jpeg'},
        {'name': 'Gandhi', 'image': 'lib/assets/images/download (4).jpeg'},
        {'name': 'Bose Babai', 'image': 'lib/assets/images/download (5).jpeg'},
      ],
      'Directors': [
        {'name': 'Boyapati Sreenu', 'image': 'lib/assets/images/download (8).jpeg'},
        {'name': 'Jakkana', 'image': 'lib/assets/images/download (6).jpeg'},
        {'name': 'Sukumar', 'image': 'lib/assets/images/images (4).jpeg'},
      ],
      'Singers': [
        {'name': 'Sid Sri ram', 'image': 'lib/assets/images/images (6).jpeg'},
        {'name': 'Balu Sir', 'image': 'lib/assets/images/images (7).jpeg'},
        {'name': 'Mahesh', 'image': 'lib/assets/images/images.jpeg'},
      ],
    };

    return ListView(
      children: groups.keys.map((groupName) {
        return ExpansionTile(
          title: Text(groupName),
          children: groups[groupName]!.map((contact) {
            return ListTile(
              leading: CircleAvatar(
                backgroundImage: AssetImage(contact['image']!),
              ),
              title: Text(contact['name']!),
            );
          }).toList(),
        );
      }).toList(),
    );
  }
}
class UpdatesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          leading: CircleAvatar(
            backgroundImage: AssetImage('lib/assets/images/download (8).jpeg'),
          ),
          title: Text('Boyapati Sreenu'),
          subtitle: Text('New updates available'),
        ),
        ListTile(
          leading: CircleAvatar(
            backgroundImage: AssetImage('lib/assets/images/download (1).jpeg'),
          ),
          title: Text('Sardhar valabhai patel'),
          subtitle: Text('Updated profile picture'),
        ),
        ListTile(
          leading: CircleAvatar(
            backgroundImage: AssetImage('lib/assets/images/download (2).jpeg'),
          ),
          title: Text('magal damodar'),
          subtitle: Text('Status update'),
        ),
        // Add more ListTile widgets as needed
      ],
    );
  }
}
