import 'package:flutter/material.dart';
import 'package:seemur_v1/auth/auth.dart';
import 'package:seemur_v1/screens/home.dart';

class CommonThings {
  static Size size;
}

class LeadingPage extends StatefulWidget {
  @override
  _LeadingPageState createState() => _LeadingPageState();
}

class _LeadingPageState extends State<LeadingPage> {
  String userID;

  @override
  void initState() {
    super.initState();

    setState(() {
      Auth().currentUser().then((onValue) {
        userID = onValue;
        print(' $userID');
      });
    });
  }

  @override
  Widget build(BuildContext context) {
	  CommonThings.size = MediaQuery
			  .of(context)
			  .size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(children: <Widget>[
	
	      HomePage(
          auth: Auth(),
        ),
        // Positioned(
        //   bottom: 0,
        //   left: 0,
        //   right: 0,
        //   child: Container(
        //     width: MediaQuery.of(context).size.width,
        //     height: 70,
	      //     //child: NavigatorBar(navCallback: (i) => print("Navigating to $i")),
        //   ),
        //),
      ]),
    );
  }
}
