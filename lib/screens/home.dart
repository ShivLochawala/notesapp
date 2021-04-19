import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:notesapp/screens/add_note.dart';
import 'package:notesapp/screens/view_note.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  
  CollectionReference reference = FirebaseFirestore
    .instance
    .collection('users')
    .doc(FirebaseAuth.instance.currentUser.uid)
    .collection('notes');

  @override
  void initState() {
    setState(() {
    });
    super.initState();
  }

  Widget allNotes(){
    return(
      FutureBuilder<QuerySnapshot>(
        future: reference.get(),
        builder: (context, snapshot){
          if(snapshot.hasData){
            return ListView.builder(
              itemCount: snapshot.data.docs.length,
              itemBuilder: (context, index) {
                Map data = snapshot.data.docs[index].data();
                String title = (data['title']).toString();
                DateTime mydateTime = (data['created']).toDate();
                String formatedTime = DateFormat.yMMMd().add_jm().format(mydateTime);
                return Container(
                  child: NotesTile(title, formatedTime, data, snapshot.data.docs[index].reference ),
                );
              }
            );
          }else{
            return Container(
              child: Center(
                child: Text('No Notes', 
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold
                  ),),
              ),
            );
          }
        }
      )
    );
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Notes", style: TextStyle(fontSize: 25.0),),),
      body:allNotes(),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(
            builder: (context) => AddNote()
            )
          ).then((value) =>setState(() {}));
        },
        child: Icon(
          Icons.add,
          color: Colors.white70,
        ),
        backgroundColor: Colors.grey[700],
      ),
    );
  }
}
class NotesTile extends StatefulWidget {
  final String title;
  final String created;
  final Map data;
  final DocumentReference ref;
  NotesTile(this.title, this.created, this.data, this.ref);

  @override
  _NotesTileState createState() => _NotesTileState();
}

class _NotesTileState extends State<NotesTile> {
  List<Color> cardColor = [
    Colors.yellow[200],
    Colors.red[200],
    Colors.green[200],
    Colors.deepPurple[200],
    Colors.orange[200]
  ];  

  @override
  void initState() {
    setState(() {
      
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Random random = new Random();
    Color bg = cardColor[random.nextInt(4)];
    return GestureDetector(
      onTap: (){
        setState(() {
          Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ViewNote(
            data: widget.data,
            time: widget.created,
            ref: widget.ref,
            )
          )
          );
        });
      },
      child:Card(
        color: bg,
        margin:  EdgeInsets.symmetric(vertical:8.0, horizontal: 8.0),
        child: Container(
          padding: EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Text(widget.title, 
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.black87,
                    fontWeight: FontWeight.w600
                  ),
                ),
              ),
              SizedBox(width: 8),
              Container(
                padding: EdgeInsets.only(top:8.0, bottom:8.0),
                alignment: Alignment.bottomRight,
                child: Text(
                  widget.created,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black87
                  ),
                ),
              ),
            ],
          ),
        ),
      )
    );
  }
}