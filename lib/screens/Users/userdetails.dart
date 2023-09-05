import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../classes/MyResponse.dart';
import '../../classes/User.dart';

class UserDetails extends StatefulWidget {
  final String userId;

  const UserDetails({required this.userId});

  @override
  _UserDetailsState createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
  User fetchedUser = User(id: '', email: '', role: '');
  bool isLoading = true;
  

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    try {
      final response = await http.get(Uri.parse('http://localhost:3001/api/v1/users/${widget.userId}'));
      if (response.statusCode == 200) {
        final responseJson = json.decode(response.body);
        final myResponse = MyResponse.fromJson(responseJson, (json) => User.fromJson(json));
        setState(() {
          fetchedUser = myResponse.results.isNotEmpty ? myResponse.results[0] : User(id: '', email: '', role: '');
          isLoading = false;
        });
      } else {
        setState(() {
          // Handle error
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        // Handle error
        isLoading = false;
      });
    }
  }


 @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Details'),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : fetchedUser != null
              ? Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'User ID: ${fetchedUser!.id}', // Change to use User properties
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 16),
                      // Text(
                      //   'User Name: ${fetchedUser!.name}', // Change to use User properties
                      //   style: TextStyle(fontSize: 16),
                      // ),
                      SizedBox(height: 8),
                      Text(
                        'Email: ${fetchedUser!.email}', // Change to use User properties
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Role: ${fetchedUser!.role}', // Change to use User properties
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          // Add any action you want here
                        },
                        child: Text('Edit User'),
                      ),
                    ],
                  ),
                )
              : Center(child: Text('No user data available')),
    );
  }
}
