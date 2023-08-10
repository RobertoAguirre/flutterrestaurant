import 'package:flutter/material.dart';
import 'package:fluttermegaproject/screens/Users/userdetails.dart';

class Users extends StatefulWidget {
  const Users({super.key});

  @override
  State<Users> createState() => _UsersState();
}

class _UsersState extends State<Users> {
  final String userId ='';
   @override
  Widget build(BuildContext context) {
 

    return Scaffold(
          appBar: AppBar(
            title: const Text('Usuarios'),
          ),
         //make a list of users with tappable elements
          body: ListView(
            children: [
              ListTile(
                title: Text('User 1'),
                onTap: () {
                  //on tap go to user details page
                  
                  //q:how to pass user data to user details page?

                  Navigator.push(context,MaterialPageRoute(builder: (context) => UserDetails(userId:'123')));
                },
              ),
              ListTile(
                title: Text('User 2'),
                onTap: () {
                  //on tap go to user details page
                  Navigator.push(context,MaterialPageRoute(builder: (context) => UserDetails(userId:'123')));
                },
              ),
              ListTile(
                title: Text('User 3'),
                onTap: () {
                  //on tap go to user details page
                  Navigator.push(context,MaterialPageRoute(builder: (context) => UserDetails(userId:'123')));
                },
              ),
              ListTile(
                title: Text('User 4'),
                onTap: () {
                  //on tap go to user details page
                  Navigator.push(context,MaterialPageRoute(builder: (context) => UserDetails(userId:'123')));
                },
              ),
              ListTile(
                title: Text('User 5'),
                onTap: () {
                  //on tap go to user details page
                  Navigator.push(context,MaterialPageRoute(builder: (context) => UserDetails(userId:'123')));
                  
                },
              ),
            ],
          ),
    );
  }
}