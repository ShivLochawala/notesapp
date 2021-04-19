import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AddNote extends StatefulWidget {
  @override
  _AddNoteState createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  TextEditingController titleController = new TextEditingController();
  TextEditingController descriptionController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text("Add Note", 
              style: TextStyle(
                fontSize: 25.0
              ),
            ),
            Expanded(child: Text('')),
            ElevatedButton(
              onPressed: (){
                save();
              }, 
              child: Text('Save',),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                  Colors.grey[900]
                ),

              ),
            )
          ],
        ),
        
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(15.0),
          child: Form(
            child: Column(
              children: [
                Container(
                  child: TextFormField(
                    controller: titleController,
                    decoration: InputDecoration.collapsed(
                      hintText: "Title"
                    ),
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                  ),
                ),
                SizedBox(height: 12.0),
                Container(
                  height: MediaQuery.of(context).size.height/2,
                  child: TextFormField(
                    controller: descriptionController,
                    decoration: InputDecoration.collapsed(
                      hintText: "Description"
                    ),
                    style: TextStyle(
                      fontSize: 24,          
                    ),
                    maxLines: 20,
                  ),
                ),
              ],
            )
          ),
        ),
      ),
    );
  }

  void save() async{
    CollectionReference reference = FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser.uid)
      .collection('notes');
    var data = {
      'title' : titleController.text,
      'description' : descriptionController.text,
      'created' : DateTime.now(),
    };
    reference.add(data);
    Navigator.pop(context);
  }
}