import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/rendering.dart';
import 'package:playground/Models/manager.dart';

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
  List<int> myList = List<int>();
  //myList.add(42);
  final databaseReference = FirebaseDatabase.instance;
  @override
  Widget build(BuildContextcontext) {
    final DBref = databaseReference.reference();
    return new Scaffold(
      backgroundColor: Colors.grey,
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
      body: Container(
        child: _buildHorizontalList(parentIndex: 1, howmany: 5),
      ),
    );
  }
}

Widget _buildHorizontalList({int parentIndex, int howmany}) {
  var colors = [
    Colors.green,
    Colors.blue,
    Colors.indigo,
    Colors.red,
    Colors.orange
  ];
  double height = 250.0;
  return SizedBox(
    height: height,
    child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: howmany,
        itemBuilder: (BuildContext content, int index) {
          return _buildItem(
              index: index + 1,
              color: colors[(parentIndex + index) % colors.length],
              parentSize: height,
              name: "null");
        }),
  );
}

Widget _buildItem({int index, Color color, double parentSize, String name}) {
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
              color: color, borderRadius: BorderRadius.circular(10)),
          child: Center(child: Text(name)),
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
