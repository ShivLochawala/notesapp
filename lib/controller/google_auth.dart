import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:notesapp/controller/helper_function.dart';
import 'package:notesapp/screens/home.dart';

GoogleSignIn googleSignIn = GoogleSignIn();
final FirebaseAuth auth = FirebaseAuth.instance;
CollectionReference users = FirebaseFirestore.instance.collection('users');

// ignore: missing_return
Future<bool> signInWithGoogle(BuildContext context) async{
  try {
    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    if(googleSignInAccount != null){
      final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken
      );

      final UserCredential authResult = await auth.signInWithCredential(credential);

      final User user = authResult.user;

      var userData = {
        "name" : googleSignInAccount.displayName,
        "provider" : "google",
        "photoUrl" : googleSignInAccount.photoUrl,
        "email" : googleSignInAccount.email
      };

      users.doc(user.uid).get().then((doc) {
        if(doc.exists){
          //old User
          doc.reference.update(userData);
          HelperFunctions.saveUserLoggedInSharedPreference(true);
          HelperFunctions.saveUserNameSharedPreference(userData['name'].toString());
          Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (context) => Home(),
            )
          );

        }else{
          //new user
          users.doc(user.uid).set(userData);
           HelperFunctions.saveUserLoggedInSharedPreference(true);
          HelperFunctions.saveUserNameSharedPreference(userData['name'].toString());
          Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (context) => Home(),
            )
          );
        }
      });
    }
  } catch (e) {
    print(e.toString());
    print("Facing issue");
  }
}