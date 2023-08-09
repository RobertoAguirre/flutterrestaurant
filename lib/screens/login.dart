import 'package:flutter/material.dart';
class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(150.0),
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
                    decoration: const InputDecoration(labelText: 'Email'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: const InputDecoration(labelText: 'Password'),
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
    );
  }

  
 
}



                           