import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/rendering.dart';
import 'package:playground/Models/Managers.dart';
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
  bool isEnabled = false;
  String iconString = "Edit";
  final fNameController = TextEditingController();
  final lNameController = TextEditingController();
  final eMailController = TextEditingController();
  final phoneController = TextEditingController();
  managers theUsers = managers("Enter E-Mail", "Enter First Name",
      "Enter Last Name", "Enter Phone Number");
  @override
  void initState() {
    // TODO: implement initState
    DatabaseReference Dbref = FirebaseDatabase.instance
        .reference()
        .child("users")
        .child(FirebaseAuth.instance.currentUser.uid);
    Dbref.once().then((DataSnapshot dataSnapShot) {
      var keys = dataSnapShot.value.keys;
      var values = dataSnapShot.value;
      managers m = managers(values['Email'], values['First_Name'],
          values['Last_Name'], values['Phone']);
      theUsers = m;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContextcontext) {
    DatabaseReference Dbref = FirebaseDatabase.instance
        .reference()
        .child("users")
        .child(FirebaseAuth.instance.currentUser.uid);
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
        ),
        actions: <Widget>[
          FlatButton(
            textColor: Colors.black,
            onPressed: () {
              if (isEnabled) {
                if (phoneController.text != "") {
                  Dbref.update({"Phone": phoneController.text});
                }
                if (fNameController.text != "") {
                  Dbref.update({"First_Name": fNameController.text});
                }
                if (lNameController.text != "") {
                  Dbref.update({"Last_Name": lNameController.text});
                }
                if (eMailController.text != "") {
                  Dbref.update({"Email": eMailController.text});
                }
                iconString = "Edit";
              } else {
                iconString = "Save";
              }
              isEnabled = !isEnabled;
              setState(() {});
            },
            child: Text(iconString),
            shape: CircleBorder(side: BorderSide(color: Colors.transparent)),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
              padding: EdgeInsets.all(16),
              child: Container(
                alignment: Alignment.topLeft,
                child: Text(
                  "Hello " + theUsers.fname + ",",
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
              )),
          Padding(
            padding: EdgeInsets.only(left: 16, right: 16),
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
                    controller: fNameController,
                    enabled: isEnabled,
                    decoration: InputDecoration(
                        border: InputBorder.none, hintText: theUsers.fname),
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
                    controller: lNameController,
                    enabled: isEnabled,
                    decoration: InputDecoration(
                        border: InputBorder.none, hintText: theUsers.lname),
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
                    controller: phoneController,
                    enabled: isEnabled,
                    decoration: InputDecoration(
                        border: InputBorder.none, hintText: theUsers.phone),
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
                    controller: eMailController,
                    enabled: isEnabled,
                    decoration: InputDecoration(
                        border: InputBorder.none, hintText: theUsers.email),
                  ),
                )
              ],
            ),
          ),
          // Padding(
          //     padding: EdgeInsets.only(top: 16),
          //     child: RaisedButton(
          //       shape: RoundedRectangleBorder(
          //         borderRadius: BorderRadius.circular(18.0),
          //       ),
          //       child: Text("Change Passaword"),
          //       color: Colors.black,
          //       textColor: Colors.white,
          //       onPressed: () {
          //         _changePassModal(context);
          //         setState(() {});
          //       },
          //     )),
          Padding(
              padding: EdgeInsets.only(top: 16),
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                ),
                child: Text("Add Location"),
                color: Colors.black,
                textColor: Colors.white,
                onPressed: () {
                  _AddLocationModal(context);
                  setState(() {});
                },
              ))
        ],
      ),
    );
  }

  void _AddLocationModal(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          final locController = TextEditingController();
          return Container(
              height: MediaQuery.of(context).size.height * 0.35,
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          "Add Location:",
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        Spacer(),
                        IconButton(
                          icon: Icon(
                            Icons.cancel,
                            size: 30,
                            color: Colors.black,
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        )
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 16, left: 5),
                      child: Text(
                        "Enter Location ID:",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(16),
                      child: TextField(
                        controller: locController,
                        decoration:
                            InputDecoration(hintText: "Enter Location ID"),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(16),
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                        child: Text("Submit"),
                        color: Colors.black,
                        textColor: Colors.white,
                        onPressed: () {
                          DatabaseReference Dbref = FirebaseDatabase.instance
                              .reference()
                              .child("Locations");
                          bool doesExists = false;
                          Dbref.once().then((DataSnapshot dataSnapShot) {
                            var keys = dataSnapShot.value.keys;
                            for (var k in keys) {
                              if (k.toString() == locController.text) {
                                doesExists = true;
                                print("ssssssayyyy" + doesExists.toString());
                                if (doesExists) {
                                  DatabaseReference submitLoc = FirebaseDatabase
                                      .instance
                                      .reference()
                                      .child("users")
                                      .child(
                                          FirebaseAuth.instance.currentUser.uid)
                                      .child("pairedLocations");
                                  submitLoc
                                      .child(locController.text)
                                      .set({"id": locController.text});
                                  Navigator.of(context).pop();
                                }
                              }
                            }
                          });
                        },
                      ),
                    )
                  ],
                ),
              ));
        });
  }
}
