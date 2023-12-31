import 'dart:convert';
import 'package:flutter/material.dart';

import 'package:flutter/widgets.dart';
import 'package:fluttermegaproject/screens/Users/userdetails.dart';
import 'package:http/http.dart' as http;


 class Users extends StatefulWidget {
  const Users({super.key});

  @override
  State<Users> createState() => _UsersState();
}



class _UsersState extends State<Users> {
  List<dynamic> users = [];
  bool isLoading = true;
  String error = '';
  final String userId ='';
  


  @override
  void initState() {
    super.initState();
    fetchUsers();
  }

  Future<void> fetchUsers() async{
    try{
      //final response = await http.get(Uri.parse('http://localhost:3001/api/v1/users/getAll'));
      //final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
      final response = await http.get(Uri.parse('http://50.21.186.23:3001/api/v1/users/getAll'));

      if(response.statusCode == 200){
        setState(() {
          users = json.decode(response.body);
          isLoading = false;
        });
      }else{
        setState(() {
          error = 'Error fetching users';
          isLoading = false;
        });
      }
    }catch(e){
      setState(() {
        error = 'Error fetching users: $e';
        isLoading = false;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    
    var listView = ListView.builder(
                  itemCount: users.length,
                  shrinkWrap:true,
                  
                  
                  itemBuilder: (context, index) {
                    return ListTile(
                      
                      //add a circle avatar to the list
                      leading: CircleAvatar(
                        child: Text(users[index]['email'][0]),
                      ),
                   
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => UserDetails(
                              userId: users[index]['_id'].toString(),

                            ),
                          ),
                        );
                      },
                      title: Text(users[index]['email']),
                      subtitle: Text(users[index]['role']),
                     
                    );
                    
                  }
                );

    var card = Card(
              elevation: 1.1,
            child: isLoading
            ? const CircularProgressIndicator()
            : error.isNotEmpty
                ? Text(error)
                : Card(
                child: listView,
                  
              ),
              
            );
    
    return Scaffold(
          appBar: AppBar(
            centerTitle: true ,
            title: const Text('Usuarios'),
            
            
            
          ),
         //make a list of users with tappable elements
          body: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(230,90,230,90),
            child: card,
             
          
           
    ),
    );
    
  }
  

  
}  














