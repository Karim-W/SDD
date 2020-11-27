// TODO Implement this library.
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/rendering.dart';
import 'package:playground/Models/manager.dart';
import 'package:playground/Models/violation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'violationView.dart';

class storeHistoryView extends StatefulWidget {
  storeHistoryView({this.storeID});
  //final FirebaseApp app;
  final storeID;
  @override
  State<StatefulWidget> createState() {
    return _storeHistoryView(sID: storeID);
  }
}

class _storeHistoryView extends State<storeHistoryView> {
  _storeHistoryView({this.sID});
  final sID;
  List<Violation> violations = [];
  @override
  void initState() {
    super.initState();
    DatabaseReference Dbref = FirebaseDatabase.instance
        .reference()
        .child("Locations")
        .child(sID)
        .child("violations");
    Dbref.once().then((DataSnapshot dataSnapShot) {
      var keys = dataSnapShot.value.keys;
      var values = dataSnapShot.value;
      for (var k in keys) {
        Violation v = new Violation(
            values[k]['time'], values[k]['photo'], values[k]['date']);
        if (v.photo == 'n/a') {
          v.photo =
              'https://i.pinimg.com/originals/ea/c9/96/eac9960a545ec495d88ce0554b9dd51a.png';
        }
        violations.add(v);
      }

      setState(() {});
      print(violations);
    });
  }

  String _storeID;
  final databaseReference = FirebaseDatabase.instance;
  @override
  Widget build(BuildContextcontext) {
    return new Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(
            "History",
            style: TextStyle(color: Colors.black),
          ),
          automaticallyImplyLeading: true,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pop(context, true);
            },
          )),
      body: ListView.builder(
          itemCount: violations.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
                trailing: Icon(Icons.arrow_forward),
                onTap: () {
                  print(violations.elementAt(index).time);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => violationView(
                            violationInst: violations.elementAt(index)),
                      ));
                },
                title: Text(violations.elementAt(index).date +
                    " " +
                    violations.elementAt(index).time));
          }),
    );
  }
}
