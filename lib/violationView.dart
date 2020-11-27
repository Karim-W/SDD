import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/rendering.dart';
import 'package:playground/Models/manager.dart';
import 'package:playground/Models/violation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class violationView extends StatefulWidget {
  violationView({this.violationInst});
  //final FirebaseApp app;
  final violationInst;
  @override
  State<StatefulWidget> createState() {
    return _violationView(ViolationInst: violationInst);
  }
}

class _violationView extends State<violationView> {
  _violationView({this.ViolationInst});
  final ViolationInst;
  List<Violation> violations = [];
  @override
  String _storeID;
  final databaseReference = FirebaseDatabase.instance;
  @override
  Widget build(BuildContextcontext) {
    return new Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(
            "Violation Information",
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
      body: Container(
        alignment: Alignment.center,
        child: Column(
          children: [
            Padding(
              padding:
                  EdgeInsets.only(top: (MediaQuery.of(context).size.width / 3)),
              child: Container(
                height: 200,
                width: 200,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.fitHeight,
                        image: NetworkImage(ViolationInst.photo)),
                    borderRadius: BorderRadius.all(Radius.circular(20.0))),
                alignment: Alignment.bottomCenter,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 0, top: 20),
              child: Text(
                "Date: " + ViolationInst.date,
                style: TextStyle(fontSize: 24),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 0),
              child: Text(
                "Time: " + ViolationInst.time,
                style: TextStyle(fontSize: 24),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
