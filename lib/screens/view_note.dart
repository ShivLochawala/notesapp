import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ViewNote extends StatefulWidget {

  final Map data;
  final String time;
  final DocumentReference ref;

  ViewNote({this.data, this.time, this.ref});

  @override
  _ViewNoteState createState() => _ViewNoteState();
}

class _ViewNoteState extends State<ViewNote> {
  TextEditingController titleController = new TextEditingController();
  TextEditingController descriptionController = new TextEditingController();

  @override
  void initState() {
    setState(() {
      titleController.text = widget.data['title'].toString();
      descriptionController.text = widget.data['description'].toString();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text("Note Details", 
              style: TextStyle(
                fontSize: 20.0
              ),
            ),
            Expanded(child: Text('')),
            ElevatedButton(
              onPressed: (){
               edit();
              }, 
              child: Icon(
                Icons.save,
                size: 20.0,
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                  Colors.green[500]
                ),
              
              ),
            ),
            SizedBox(width: 8.0,),
            ElevatedButton(
              onPressed: (){
               delete();
              }, 
              child: Icon(
                Icons.delete,
                size: 20.0,
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                  Colors.red[500]
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
  void delete() async{
    await widget.ref.delete();
    
    Navigator.pop(context);
  }
  void edit() async{
    await widget.ref.update({
      'title' : titleController.text,
      'description' : descriptionController.text,
      'created' : DateTime.now(),
    });
    
    Navigator.pop(context);
  }
}

