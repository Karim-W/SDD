import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/rendering.dart';
import 'package:playground/Models/manager.dart';
import 'package:playground/Models/violation.dart';
import 'storeHistoryView.dart';
// import 'package:Locations.dart';

import 'authentication_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Location {
  String id, name, city, area, locImg;
  int activeViolation;
  double long, lat;
  Location(this.id, this.activeViolation, this.area, this.city, this.lat,
      this.long, this.name, this.locImg);
}

class HomePage extends StatefulWidget {
  HomePage({this.app});
  final FirebaseApp app;
  @override
  State<StatefulWidget> createState() {
    return _myHomePageState();
  }
}

class _myHomePageState extends State<HomePage> {
  List<String> LocationIds = [];
  List<Location> userLocations = [];
  List<int> vioArr = [3, 5, 2, 1, 0];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    DatabaseReference Dbref = FirebaseDatabase.instance
        .reference()
        .child("users")
        .child(FirebaseAuth.instance.currentUser.uid)
        .child("pairedLocations");
    Dbref.once().then((DataSnapshot dataSnapShot) {
      var keys = dataSnapShot.value.keys;
      var values = dataSnapShot.value;
      for (var key in keys) {
        LocationIds.add(key);
        DatabaseReference ref =
            FirebaseDatabase.instance.reference().child("Locations").child(key);
        ref.once().then((DataSnapshot dataSnapShots) {
          var keyse = dataSnapShots.value.keys;
          var valuese = dataSnapShots.value;
          print(valuese);
          Location bigL = new Location(
              valuese['id'],
              valuese['activeViolations'],
              valuese['area'],
              valuese['city'],
              valuese['lat'],
              valuese['long'],
              valuese['name'],
              valuese['locImg']);
          print(bigL.area);
          userLocations.add(bigL);
          setState(() {});
        });
        //print(key);
      }

      //print(keys.toString());
    });
  }

  final databaseReference = FirebaseDatabase.instance;
  @override
  Widget build(BuildContextcontext) {
    final DBref = databaseReference.reference();
    return new Scaffold(
        //backgroundColor: Color(0xff0B0500),
        appBar: new AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.menu),
            color: Colors.black,
            onPressed: () {
              print("GOOD MORNING");
            },
          ),
          title: Text(
            "Home",
            style: TextStyle(color: Colors.black),
          ),
          actions: <Widget>[
            FlatButton(
              //textColor: Colors.white,
              textColor: Colors.black,
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
                    heigh: MediaQuery.of(context).size.height,
                    parentIndex: 1,
                    locs: userLocations,
                    contex: context),
              ),
            ],
          ),
        ));
  }
}

Widget _buildHorizontalList(
    {double w_idth,
    double heigh,
    int parentIndex,
    List<Location> locs,
    BuildContext contex}) {
  double height = w_idth - 2;
  return SizedBox(
    height: heigh - 180,
    child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: locs.length,
        itemBuilder: (BuildContext content, int index) {
          return _buildItem(
              index: index + 1,
              color: Colors.deepPurpleAccent,
              parentSize: height,
              name: locs.elementAt(index).name,
              area: locs.elementAt(index).area,
              city: locs.elementAt(index).city,
              violations: locs.elementAt(index).activeViolation,
              img: locs.elementAt(index).locImg,
              heig: heigh - 180,
              storeID: locs.elementAt(index).id,
              context: contex);
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
    int violations,
    String img,
    double heig,
    String storeID,
    BuildContext context}) {
  double edgeSize = 8.0;
  double itemSize = parentSize - edgeSize * 2.0;
  if (img == 'n/a') {
    img =
        'https://coolbackgrounds.io/images/backgrounds/black/pure-black-background-f82588d3.jpg';
  }
  return Container(
    padding: EdgeInsets.all(edgeSize),
    child: InkWell(
      onTap: () {
        print("hi");
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => storeHistoryView(
                storeID: storeID,
              ),
            ));
      }, // Handle your callback
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
                    colors: [Colors.grey, color.withOpacity(0.75)],
                    begin: Alignment.centerRight,
                    end: new Alignment(-1.0, -1.0)),
                borderRadius: BorderRadius.circular(20)),
            child: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.fitHeight, image: NetworkImage(img)),
                    borderRadius: BorderRadius.all(Radius.circular(20.0))),
                alignment: Alignment.bottomCenter, //.bottomCenter,
                child: Padding(
                    padding: EdgeInsets.only(top: (heig - 190)),
                    child: SizedBox(
                      width: itemSize,
                      child: DecoratedBox(
                          decoration: BoxDecoration(
                              color: color,
                              gradient: new LinearGradient(
                                  colors: [
                                    Colors.grey.withOpacity(0.60),
                                    Colors.white.withOpacity(0.70)
                                  ],
                                  begin: Alignment.centerRight,
                                  end: new Alignment(-1.0, -1.0)),
                              borderRadius: BorderRadius.circular(20)),
                          child: Column(children: [
                            Text(
                              name,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(area + "," + city,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                )),
                            Text(
                                "Number of Violations: " +
                                    violations.toString(),
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                )),
                            Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  RawMaterialButton(
                                    onPressed: () {
                                      print("Delet" + storeID);
                                    },
                                    elevation: 2.0,
                                    fillColor: Colors.white,
                                    child: Icon(
                                      Icons.delete,
                                      size: 35.0,
                                    ),
                                    padding: EdgeInsets.all(15.0),
                                    shape: CircleBorder(),
                                  ),
                                ],
                              ),
                            ),
                          ])),
                    ))),
          ),
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
