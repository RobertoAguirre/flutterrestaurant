// ignore_for_file: prefer_const_constructors

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
      final response = await http.get(Uri.parse('http://50.21.186.23:3001/api/v1/users/${widget.userId}'));
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

 Future<void> updateUser(User user) async {
  try {
    final apiUrl = 'http://localhost:3001/api/v1/users/${user.id}'; // Replace with your API endpoint for updating a user
    final Map<String, String> headers = {
      'Content-Type': 'application/json', // Set the correct content-type header for JSON
    };

    final Map<String, dynamic> body = {
      'username': user.email,
      'role': user.role,
    };

    final response = await http.patch(
      Uri.parse(apiUrl),
      headers: headers,
      body: jsonEncode(body), // Convert the body to a JSON string
    );

    if (response.statusCode == 200) {
      final responseJson = json.decode(response.body);
      final myResponse = MyResponse.fromJson(responseJson, (json) => User.fromJson(json));

      // Check if the update operation was successful
      if (myResponse.message == 'User updated successfully') {
        // Handle success
        // You can update your UI or perform any other actions here
      } else {
        // Handle other responses or errors here
      }
    } else {
      // Handle error
      // You can handle HTTP errors here
    }
  } catch (e) {
    // Handle exception
    print('Error occurred: $e');
  }
}


Future<void> deleteUser() async {
  try {
    final response = await http.delete(Uri.parse('http://localhost:3001/api/v1/users/${widget.userId}'));
    if (response.statusCode == 200) {
      final responseJson = json.decode(response.body);
      final myResponse = MyResponse.fromJson(responseJson, (json) => User.fromJson(json));

      // Check if the delete operation was successful
      if (myResponse.message == 'User deleted successfully') {
        // Pop the current screen and navigate back to the previous screen
        // ignore: use_build_context_synchronously
        Navigator.pop(context);
      } else {
        // Handle other responses or errors here
      }
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
        title: Text('Datos de usuario'),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : fetchedUser != null
              ? Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Card
                  (
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'User ID: ${fetchedUser!.id}', // Change to use User properties
                            style:const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 16),
                          // Text(
                          //   'User Name: ${fetchedUser!.name}', // Change to use User properties
                          //   style: TextStyle(fontSize: 16),
                          // ),
                          const SizedBox(height: 8),
                          Text(
                            'Email: ${fetchedUser!.email}', // Change to use User properties
                            style: const TextStyle(fontSize: 16),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Role: ${fetchedUser!.role}', // Change to use User properties
                            style: TextStyle(fontSize: 16),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                               Expanded(
                                 child: ElevatedButton(
                                 style: ElevatedButton.styleFrom(
                                    minimumSize: Size(double.infinity, 50),
                                    foregroundColor: Colors.white,
                                    backgroundColor: Colors.indigo
                                  ),
                                  onPressed: () {
                                    // Add any action you want here
                                  },
                                  child: Text('Editar Usuario'),
                                                             ),
                               ),
                              SizedBox(width: 16), // Add some spacing between buttons
                              Expanded(
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    foregroundColor: Colors.white, 
                                    backgroundColor: Colors.red, minimumSize: Size(double.infinity, 50)
                                  ),
                                  onPressed: () {
                                    //alert dialog
                                    showDialog(
                                      context: context, 
                                      builder: (context) => AlertDialog(
                                        title: Text('Eliminar Usuario'),
                                        content: Text('¿Esta seguro de que quiere eliminar el usuario?'),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            }, 
                                            child: Text('No')
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              //delete user
                                              Navigator.of(context).pop();
                                            }, 
                                            child: Text('Yes')
                                          ),
                                        ],
                                      )
                                    );
                                  },
                                  child: Text('Remove User'),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              : Center(child: Text('No user data available')),
    );
  }
}
