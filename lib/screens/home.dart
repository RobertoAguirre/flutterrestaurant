import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body:  Center(
        child: Row(
          children: [
              Card(
                //add an imagme to the card
                clipBehavior: Clip.hardEdge,
                child: InkWell(
                     
                      splashColor: Colors.blue.withAlpha(30),
                      onTap: () {
                        debugPrint('Card tapped.');
                      },
                    child:const Column(
                      children: [
                         Image(
                          image: AssetImage('assets/images/restaurantlogo.png'),
    
                        ),
                         Text('Restaurant'),
                      ],
                    ),
                    ),
                ),
            
           const Card(
              child: Expanded(
                child: Center(
                  child: Text('Platillos'),
                ),  
              )
            ),
          ],
        ),
      ),
    );
  }
}