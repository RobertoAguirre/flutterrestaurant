import 'package:flutter/material.dart';
import 'package:fluttermegaproject/screens/Users/users.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
            title: const Text('Home'),
          ),
          body: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, // Adjust spacing
              crossAxisSpacing: 16.0,
              mainAxisSpacing: 16.0,
              childAspectRatio: cardWidth / (cardWidth + 60.0),
            ),
            itemCount: cardDataList.length, // Change this to the number of cards you have
            itemBuilder: (context, index) {
              final cardData = cardDataList[index];
              return Card(
                clipBehavior: Clip.hardEdge,
                child: InkWell(
                  splashColor: Colors.blue.withAlpha(30),
                  onTap: () {
                    //on tap go to users page  
                    Navigator.push(context,MaterialPageRoute(builder: (context) => Users()));
                    
                    debugPrint('Card tapped: ${cardData['title']}');
                  },
                  child: Column(
                    children: [
                      Image(
                        image: AssetImage(cardData['imagePath']!),
                      ),
                      Text(cardData['title']!),
                    ],
                  ),
                ),
              );
            },
          ),
        );

  }
}