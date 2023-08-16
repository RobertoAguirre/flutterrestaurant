import 'package:flutter/material.dart';
import 'package:fluttermegaproject/screens/home.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;


class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();


  @override
  Widget build(BuildContext context) {
   return  Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(150.0),
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
                    child:  Text('Bienvenido',style: TextStyle(
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
                      validator: (value){
                        if(value == null||value.isEmpty){
                          return 'Please enter your password';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                        textStyle: const TextStyle(
                          color: Colors.black
                        ),
        
                      ),
                      onPressed: (){
                        if (_formKey.currentState != null && _formKey.currentState!.validate()) {
                              _submitForm();
                        }
        
                        print('logging in');
                      },
                      child: const Text('Login'),
                    ),
                  )
              
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _submitForm() async{
          const apiUrl = 'http://localhost:3001/api/v1/users/authenticate'; // Replace with your API endpoint for creating a new user
          // Get the email and password values from the TextFormField widgets
            // String email = emailController.text;
            // String password = passwordController.text;
            final Map<String, String> headers = {
              'Content-Type': 'application/json', // Set the correct content-type header for JSON
            };
                
            final Map<String, dynamic> body = {
                'email': emailController.text,
                'password': passwordController.text,
            };
            try {
              final response = await http.post(
              Uri.parse(apiUrl),
              headers: headers,
              body: jsonEncode(body), // Convert the body to a JSON string
              );
              
                if(response.statusCode==200){
                  //api call succeeded handle the response if needed
                    print('User created successfully');  
                    //show a flutter dialog with the message 'User created successfully'
                                        //show a flutter dialog with the message 'User created successfully'
                    // ignore: use_build_context_synchronously
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>const Home()));
                    // showDialog(
                    //   context: context, 
                    //   builder: (BuildContext context){
                    //     return AlertDialog(
                    //       title: const Text('Success'),
                    //       content: const Text('User created successfully'),
                    //       actions: [
                    //         TextButton(
                    //           onPressed: (){
                    //             //Navigator.of(context).pop();
                    //             //redirect to the home page
                    //             Navigator.push(context, MaterialPageRoute(builder: (context)=>const Home()));
                    //           },
                               
                    //           child: const Text('Ok')
                    //         )
                    //       ],
                    //     );
                    //   }
                    // );

                  }else{
                   // ignore: use_build_context_synchronously
                   showDialog(
                      context: context, 
                      builder: (BuildContext context){
                        return AlertDialog(
                          title: const Text('Error'),
                          content: const Text('Usuario o contraseña incorrectas'),
                          actions: [
                            TextButton(
                              onPressed: (){
                                //Navigator.of(context).pop();
                                //redirect to the home page
                                //Navigator.push(context, MaterialPageRoute(builder: (context)=>const Home()));
                                //dismiss the dialog
                                 Navigator.of(context).pop();
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