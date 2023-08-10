import 'dart:html';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttermegaproject/screens/home.dart';
import 'package:http/http.dart' as http;

import 'screens/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Restaurant',
     // theme: ThemeData.dark(), // Switch to a different default theme here
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: const NewUser(),
     // home: const NewUser (),
    );
  }
}


class NewUser extends StatefulWidget {
  const NewUser({super.key});

  @override
  _NewUserState createState() => _NewUserState();
}

class _NewUserState extends State<NewUser> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController roleController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Padding(
        padding: const EdgeInsets.all(100.0),
        child: Form(
          key:_formKey,
          child: Center(
            child: Card(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                const Image(
                  image: AssetImage('assets/images/restaurantlogo.png'),
                  height: 200,
                ),//add an image

                const Padding(
                    padding:  EdgeInsets.only(top: 15.0, bottom: 10.0) ,
                    child:  Text('Crear nuevo usuario',style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.5
                    ),),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: emailController,
                      decoration: const InputDecoration(labelText: 'Email'),
                      validator: (value){
                        if(value == null||value.isEmpty){
                          return 'Please enter your email';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(labelText: 'Password'),
                    ),
                    
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller:confirmPasswordController,
                      obscureText: true,
                      decoration: const InputDecoration(labelText: 'Confirm password'),
                    ),
                    
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    //make the elevated button a full width button
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        //change the width of the button
                        backgroundColor: Colors.blueAccent,
                        minimumSize: const Size(double.infinity,50),
                        textStyle: const TextStyle(
                          color: Colors.black
                        ),
        
                      ),
                      onPressed: (){
                        
                        //validate if the password and confirm password are the same, if not show an error if they are the same submit the form                        
                        if(passwordController.text != confirmPasswordController.text){
                          //show an browser alert dialog with the error 'passwords do not match
                          //window.alert('passwords do not match');
                          //show a flutter snackbar with the error 'passwords do not match'
                         /* ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('passwords do not match')),
                          );*/
                                                    //show a flutter dialog with the error 'passwords do not match'
                          showDialog(
                            context: context, 
                            builder: (BuildContext context){
                              return AlertDialog(
                                title: const Text('Error'),
                                content: const Text('passwords do not match'),
                                actions: [
                                  TextButton(
                                    onPressed: (){
                                      Navigator.of(context).pop();
                                    }, 
                                    child: const Text('Ok')
                                  )
                                ],
                              );
                            }
                          );
                          print('passwords do not match');
                          
                        }else{
                          if (_formKey.currentState != null && _formKey.currentState!.validate()) {
                            _submitForm();
                          }
                        }
                      },
                      child: const Text(
                        'Registrarse',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                        ),
                    ),
                  )
              
                ],
              ),
            ),
          ),
        )
      )
    );
  }

      void _submitForm() async{
          const apiUrl = 'http://localhost:3001/api/v1/users'; // Replace with your API endpoint for creating a new user
          // Get the email and password values from the TextFormField widgets
            // String email = emailController.text;
            // String password = passwordController.text;
            final Map<String, String> headers = {
              'Content-Type': 'application/json', // Set the correct content-type header for JSON
            };
                
            final Map<String, dynamic> body = {
                'email': emailController.text,
                'role':'admin',
                'password': passwordController.text,
            };
            try {
              final response = await http.post(
              Uri.parse(apiUrl),
              headers: headers,
              body: jsonEncode(body), // Convert the body to a JSON string
              );
              
                if(response.statusCode==201){
                  //api call succeeded handle the response if needed
                    print('User created successfully');  
                    //show a flutter dialog with the message 'User created successfully'
                                        //show a flutter dialog with the message 'User created successfully'
                    // ignore: use_build_context_synchronously
                    showDialog(
                      context: context, 
                      builder: (BuildContext context){
                        return AlertDialog(
                          title: const Text('Success'),
                          content: const Text('User created successfully'),
                          actions: [
                            TextButton(
                              onPressed: (){
                                //Navigator.of(context).pop();
                                //redirect to the login page
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>const Login()));
                              },
                               
                              child: const Text('Ok')
                            )
                          ],
                        );
                      }
                    );

                  }
                
                }catch(e){
                  // Handle any exception that occurred during the API call
                  print('Error occurred: $e');
                }
      } 


  
}
