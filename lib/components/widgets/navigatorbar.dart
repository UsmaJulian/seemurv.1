import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:seemur_v1/screens/descubrir.dart';
import 'package:seemur_v1/screens/home.dart';
import 'package:seemur_v1/screens/user/perfil.dart';

class NavigatorBar extends StatefulWidget {
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
                  tooltip: 'Inicio',
                  icon: Icon(
                    Icons.home,
                  ),
                  iconSize: 34,
                  color: Color(0xff17202c),
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (BuildContext context) {
                      return HomePage();
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
                      return PerfilPage();
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
