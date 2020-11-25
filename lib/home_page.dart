import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/rendering.dart';
import 'package:playground/Models/manager.dart';
import 'package:playground/Models/violation.dart';

import 'authentication_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  HomePage({this.app});
  final FirebaseApp app;
  @override
  State<StatefulWidget> createState() {
    return _myHomePageState();
  }
}

class _myHomePageState extends State<HomePage> {
  final gee = ['hello', 'my', 'name', 'is', 'karim'];
  List<String> intArr = ['Paul', 'Carrefour', 'FedEx', 'Nike', 'Nandos'];
  List<String> locArr = ['Mirdif', 'Downtown', 'Sports City', 'JBR', 'Marina'];
  List<String> cityArr = [
    'Dubai,UAE',
    'Dubai,UAE',
    'Dubai,UAE',
    'Dubai,UAE',
    'Dubai,UAE'
  ];
  List<int> vioArr = [3, 5, 2, 1, 0];
  final databaseReference = FirebaseDatabase.instance;
  @override
  Widget build(BuildContextcontext) {
    final DBref = databaseReference.reference();
    return new Scaffold(
        backgroundColor: Color(0xff0B0500),
        appBar: new AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: Icon(Icons.menu),
          title: Text("Home"),
          actions: <Widget>[
            FlatButton(
              textColor: Colors.white,
              onPressed: () {
                context.read<AuthenticationService>().signOut();
              },
              child: Text("Logout"),
              shape: CircleBorder(side: BorderSide(color: Colors.transparent)),
            ),
          ],
        ),
        body: Padding(
          padding: EdgeInsets.only(top: 16.0),
          child: Column(
            children: [
              Container(
                child: _buildHorizontalList(
                    w_idth: MediaQuery.of(context).size.width,
                    parentIndex: 1,
                    howmany: intArr.length,
                    locTitle: intArr,
                    locArea: locArr,
                    locCity: cityArr,
                    vioArr: vioArr),
              ),
              Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Container(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "HELooooo",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold),
                      ))),
            ],
          ),
        ));
  }
}

Widget _buildHorizontalList(
    {double w_idth,
    int parentIndex,
    int howmany,
    List<String> locTitle,
    List<String> locArea,
    List<String> locCity,
    List<int> vioArr}) {
  double height = w_idth - 2;
  return SizedBox(
    height: height * 1.6,
    child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: howmany,
        itemBuilder: (BuildContext content, int index) {
          return _buildItem(
              index: index + 1,
              color: Colors.deepPurpleAccent,
              parentSize: height,
              name: locTitle[index],
              area: locArea[index],
              city: locCity[index],
              violations: vioArr[index]);
        }),
  );
}

Widget _buildItem(
    {int index,
    Color color,
    double parentSize,
    String name,
    String area,
    String city,
    int violations}) {
  double edgeSize = 8.0;
  double itemSize = parentSize - edgeSize * 2.0;
  return Container(
    padding: EdgeInsets.all(edgeSize),
    child: SizedBox(
      width: itemSize,
      height: itemSize,
      child: Padding(
        padding: EdgeInsets.all(0.0),
        child: Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
              color: color,
              gradient: new LinearGradient(
                  colors: [Colors.purple, color.withOpacity(0.75)],
                  begin: Alignment.centerRight,
                  end: new Alignment(-1.0, -1.0)),
              borderRadius: BorderRadius.circular(10)),
          child: Container(
              alignment: Alignment.bottomCenter, //.bottomCenter,
              child: Padding(
                  padding: EdgeInsets.only(top: (itemSize * 1.4) - 16),
                  child: Column(children: [
                    Text(
                      name,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(area + "," + city,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        )),
                    Text("Number of Violations: " + violations.toString(),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ))
                  ]))),
        ),
      ),
    ),
  );
}

// class HomePage extends StatelessWidget {
//   manager user;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text("HOME"),
//             RaisedButton(
//               onPressed: () {
//                 context.read<AuthenticationService>().signOut();
//               },
//               child: Text("Sign out"),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
