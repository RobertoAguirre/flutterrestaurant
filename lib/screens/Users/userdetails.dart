import 'package:flutter/material.dart';

//create a stateful widget for user details
class UserDetails extends StatefulWidget {
  final String userId;
  //pass the user id to the user details page
 // const UserDetails(userId, {Key? key}) : super(key: key);
   const UserDetails({required this.userId});

  @override
  State<UserDetails> createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalles del Usuario'),
      ),
      body: const Center(
        child: Text('Detalles del Usuario'),
      ),
    );
  }
}