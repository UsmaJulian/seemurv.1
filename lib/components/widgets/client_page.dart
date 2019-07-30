import 'package:flutter/material.dart';
import 'package:seemur_v1/auth/auth.dart';
//import 'package:seemur_v1/components/widgets/client_top.dart';
import 'package:seemur_v1/components/widgets/clients_body.dart';

class ClientPage extends StatefulWidget {
  @override
  _ClientPageState createState() => _ClientPageState();
}

class _ClientPageState extends State<ClientPage> {
  String userID;

  @override
  void initState() {
    super.initState();

    setState(() {
      Auth().currentUser().then((onValue) {
        userID = onValue;
        print('el futuro Cheft $userID');
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Stack(children: <Widget>[
          Column(
            children: <Widget>[
              Container(
                color: Colors.white,
                height: 2800,
                child: ClientBody(),
              ),
            ],
          ),
        ]),
      ),
    );
  }
}
