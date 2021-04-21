import 'dart:async';

import 'package:flutter/material.dart';
import 'package:notesapp/controller/helper_function.dart';
import 'package:notesapp/screens/login.dart';

import 'home.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool userIsLoggedIn = false;
  @override
  void initState() {
    
    getLoggedInState();
    super.initState();
    Timer(
      Duration(seconds: 1), (){
        Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) => userIsLoggedIn != null ? /**/userIsLoggedIn ? Home() : LoginScreen() /* */ : LoginScreen(),
          )
        );
      } 
    );
  }
  getLoggedInState() async{
    await HelperFunctions.getUserLoggedInSharedPreference().then((value){
      setState(() {
        userIsLoggedIn = value;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Image.asset('assets/images/notes.png', width: 400.0, height: 400.0),
      ),
    );
  }
}