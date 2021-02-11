import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/rendering.dart';
import 'package:playground/Models/manager.dart';
import 'package:playground/Models/violation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class userSetting extends StatefulWidget {
  userSetting();
  @override
  State<StatefulWidget> createState() {
    return _userSetting();
  }
}

class _userSetting extends State<userSetting> {
  _userSetting();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContextcontext) {
    return new Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(
            "User Settings",
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
      body: Column(
        children: [
          Padding(
              padding: EdgeInsets.all(16),
              child: Container(
                alignment: Alignment.topLeft,
                child: Text(
                  "Hello Karim,",
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
              )),
          Padding(
            padding: EdgeInsets.only(left: 16, right: 16, top: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "First Name :",
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.normal),
                ),
                Container(
                  alignment: Alignment.topLeft,
                  width: 290,
                  height: 45,
                  child: TextField(
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Enter a search term'),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 16, right: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Last Name :",
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.normal),
                ),
                Container(
                  alignment: Alignment.topLeft,
                  width: 290,
                  height: 45,
                  child: TextField(
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Enter a search term'),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 16, right: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Phone num:",
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.normal),
                ),
                Container(
                  alignment: Alignment.topLeft,
                  width: 290,
                  height: 45,
                  child: TextField(
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Enter a search term'),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 16, right: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Email :",
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.normal),
                ),
                Container(
                  alignment: Alignment.topLeft,
                  width: 330,
                  height: 45,
                  child: TextField(
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Enter a search term'),
                  ),
                )
              ],
            ),
          ),
          Padding(
              padding: EdgeInsets.only(top: 16),
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                ),
                child: Text("Change Passaword"),
                color: Colors.black,
                textColor: Colors.white,
                onPressed: () {},
              )),
          Padding(
              padding: EdgeInsets.zero,
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                ),
                child: Text("Add Location"),
                color: Colors.black,
                textColor: Colors.white,
                onPressed: () {},
              ))
        ],
      ),
    );
  }
}
