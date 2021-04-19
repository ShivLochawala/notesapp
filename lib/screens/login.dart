import 'package:flutter/material.dart';
import 'package:notesapp/controller/google_auth.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
       child: Column(
         children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/cover.png'),
                ),
              ),
            )
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text("Create and Manage your Notes", 
              style: TextStyle(
                fontSize: 23.0,
                color: Colors.white
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              top: 20.0,
              bottom: 50.0,
              right: 10.0,
              left: 10.0
            ),
            child: ElevatedButton(
              onPressed: (){
                signInWithGoogle(context);
              }, 
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Continue with Google", 
                    style: TextStyle(
                      fontSize: 22.0,
                      
                    ),
                  ),
                  SizedBox(width: 10.0,),
                  Image.asset('assets/images/google.png', 
                    height: 23.0
                  ),
                ],
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                  Colors.grey[700]
                ),
                padding: MaterialStateProperty.all(
                  EdgeInsets.all(15.0)
                ),
              ),
            )
          )
         ],
       ),
      ),
    );
  }
}