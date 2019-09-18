import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
//import 'package:localstorage/localstorage.dart';
import 'package:seemur_v1/auth/auth.dart';
import 'package:seemur_v1/login_admin/checkroles.dart';

import 'package:seemur_v1/models/user_model.dart';
import 'package:seemur_v1/screens/admin/add_client.dart';
import 'package:seemur_v1/screens/descubrir.dart';
import 'package:seemur_v1/screens/home.dart';
import 'package:seemur_v1/screens/user/perfil.dart';

//final LocalStorage storage = new LocalStorage('userdata');
class NavigatorBar extends StatefulWidget {
  const NavigatorBar({Key key, this.user, this.auth}) : super(key: key);
  final usuario = Usuario;
  final FirebaseUser user;
  final BaseAuth auth;

  _NavigatorBarState createState() => _NavigatorBarState();
}

class _NavigatorBarState extends State<NavigatorBar> {
  @override
  Widget build(BuildContext context) {
    // tODO: implement build
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: 173,
        decoration: BoxDecoration(color: Color(0xffffffff)),
        child: Row(
          //mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Column(
              children: <Widget>[
                IconButton(
                  focusColor: Colors.red,
                  tooltip: 'Inicio',
                  icon: Icon(
                    Icons.home,
                  ),
                  iconSize: 34,
                  color: Color(0xff17202c),
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (BuildContext context) {
                      return HomePage(
                        auth: Auth(),
                      );
                    }));
                  },
                ),
                Text("Inicio",
                    style: TextStyle(
                      fontFamily: 'HankenGrotesk',
                      color: Color(0xff17202c),
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      fontStyle: FontStyle.normal,
                    ))
              ],
            ),
            Column(
              children: <Widget>[
                IconButton(
                  icon: Icon(
                    FontAwesomeIcons.compass,
                    color: Color(0xff3d3d3d),
                    size: 34,
                  ),
                  iconSize: 34,
                  color: Colors.black,
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (BuildContext context) {
                      return Descubrir();
                    }));
                  },
                ),
                Text("Descubrir",
                    style: TextStyle(
                      fontFamily: 'HankenGrotesk',
                      color: Color(0xff3d3d3d),
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      fontStyle: FontStyle.normal,
                    ))
              ],
            ),
            Column(
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.person_outline),
                  iconSize: 34,
                  color: Colors.black,
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (BuildContext context) {
                      return CheckRoles(
                        auth: Auth(),
                      );

                      //return ClientAddPage ();
                    }));
                  },
                ),
                Text("Perfil",
                    style: TextStyle(
                      fontFamily: 'HankenGrotesk',
                      color: Color(0xff3d3d3d),
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      fontStyle: FontStyle.normal,
                    ))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
