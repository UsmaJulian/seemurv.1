import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:seemur_v1/auth/auth.dart';
import 'package:seemur_v1/login_admin/root_page.dart';
import 'package:seemur_v1/screens/user/preferences_page.dart';

class PerfilPage extends StatefulWidget {
   PerfilPage({this.auth});
  final BaseAuth auth;
  @override
  _PerfilPageState createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilPage> {
   AuthStatus authStatus = AuthStatus.notSignIn;
    
    void signOut() async {
    setState(() {
      authStatus = AuthStatus.notSignIn;
    });
  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        //backgroundColor: Colors.red,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          automaticallyImplyLeading: false,
          actions: <Widget>[
            IconButton(
              icon: Icon(
                CupertinoIcons.gear,
                color: Colors.black,
              ),
              onPressed: () {
                 Navigator.of(context).push(
                        MaterialPageRoute(builder: (BuildContext context) {
                      return  PreferencesPage(auth: Auth(),);
                      //return ClientAddPage ();
                    }));
              },
            ),
            IconButton(
              icon: Icon(
                CupertinoIcons.bell,
                color: Colors.black,
              ),
              onPressed: () {},
            ),
          ],
        ),
        body: Stack(
          children: <Widget>[
            Positioned(
              top: 18.0,
              left: 165.0,
              right: 165.0,
              child: Container(
                width: 80.0,
                height: 80.0,
                decoration: BoxDecoration(
                  color: Color.fromRGBO(216, 216, 216, 1),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(6.0),
                      topRight: Radius.circular(6.0),
                      bottomLeft: Radius.circular(6.0),
                      bottomRight: Radius.circular(6.0)),
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 18.0, right: 18.0),
                    child: SvgPicture.asset(
                      'assets/images/Seemur-Isotipo.svg',
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 120,
              left: 160,
              right: 160,
              child: Column(
              children: <Widget>[
                Container(width: 100,height: 100,
                  child: StreamBuilder(
                    stream: Firestore.instance.collection('usuarios').snapshots(),
                    builder: (context, snapshot){
                      if(!snapshot.hasData)return Text('cargando datos');
                      return Column(
                        children: <Widget>[
                          Text('Hola,')
                        ],
                      );
                    },
                  ),
                ),
              ],
            )

            )
          ],
        ));
  }
}
