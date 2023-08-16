import 'package:flutter/material.dart';
import 'package:fluttermegaproject/screens/Users/users.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  Widget _currentBodyWidget = Users();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final cardWidth = (screenWidth - 48.0) / 2;

    // List of data for each card
    final List<Map<String, String>> cardDataList = [
      {
        'title': 'Restaurant 1',
        'imagePath': 'assets/images/restaurantlogo.png',
      },
      {
        'title': 'Restaurant 2',
        'imagePath': 'assets/images/restaurantlogo.png',
      },
      // Add more data as needed
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Side Menu Demo'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          )
        ],
      ),
      body: _currentBodyWidget,
      drawer: Drawer(
        //remove the rouded corners of the drawer
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0.0),
        ),
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child:Column(
                children: [
                  Row(
                    children: [                  
                    IconButton(
                    icon: Icon(Icons.menu),
                    onPressed: () {
                      Navigator.pop(context); // Close the drawer
                    },
                  ),],
                  ),

                 const SizedBox(width: 10,),
                 const CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage('assets/images/restaurantlogo.png'),
                  ),
                 const SizedBox(width: 10,),
                 const Text('Restaurant Name',
                 style: TextStyle(fontSize: 20),),
                ],
              ),
              
            ),
            ListTile(
              title: const Text('Usuarios'),
              leading: const Icon(Icons.food_bank),
              onTap: () {
                // Handle the tap for Option 1
                Navigator.pop(context); // Close the drawer
                //change main body content depending on the selected option
                setState(() {
                  _currentBodyWidget = Users(); // Set the Users widget as the current main content
                });
              },
            ),
            ListTile(
              //add an icon to the drawer
              leading: const Icon(Icons.food_bank),
              title: const Text('Platillos'),
              onTap: () {
                // Handle the tap for Option 2
                Navigator.pop(context); // Close the drawer
                setState(() {
                  // For demonstration purposes, I'm just using a simple Text widget. 
                  // Replace with your actual widget for this option.
                  _currentBodyWidget = Center(child: Text('Platillos content here'));
                });
              },
            ),
            // Add more ListTiles for additional options
          ],
        ),
      ),
    );
   

  }
}