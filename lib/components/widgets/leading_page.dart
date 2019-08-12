import 'package:flutter/material.dart';
import 'package:seemur_v1/auth/auth.dart';
import 'package:seemur_v1/screens/home.dart';

class CommonThings{
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
    CommonThings.size=MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body:HomePage(auth: Auth(),),
    );
  }
}
