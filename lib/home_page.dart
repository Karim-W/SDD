import 'package:flutter/rendering.dart';
import 'package:playground/Models/manager.dart';

import 'authentication_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _myHomePageState();
  }
}

class _myHomePageState extends State<HomePage> {
  @override
  Widget build(BuildContextcontext) {
    return new Scaffold(
        appBar: new AppBar(
          title: Text('Hello'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("HOME"),
              RaisedButton(
                onPressed: () {
                  context.read<AuthenticationService>().signOut();
                },
                child: Text("Sign out"),
              ),
            ],
          ),
        ));
  }
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
