import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:seemur_v1/auth/auth.dart';
import 'package:seemur_v1/components/widgets/navigatorbar.dart';
import 'package:seemur_v1/screens/politicadeprivacidad.dart';
import 'package:seemur_v1/screens/terminos_condiciones.dart';
import 'package:url_launcher/url_launcher.dart';

class AyudaPage extends StatefulWidget {
  AyudaPage({this.auth});
  final BaseAuth auth;

  _AyudaPageState createState() => _AyudaPageState();
}

class _AyudaPageState extends State<AyudaPage> {
  String usuario = 'Usuario'; //user
  String usuarioEmail = 'Email'; //userEmail
  String id;
  @override
  void initState() {
    super.initState();
    widget.auth.infoUser().then((onValue) {
      setState(() {
        usuario = onValue.displayName;
        usuarioEmail = onValue.email;
        id = onValue.uid;
        print('ID $id');
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: new IconButton(
          icon: new Icon(
            CupertinoIcons.back,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Color.fromRGBO(22, 32, 44, 1),
        title: Center(
            child: Padding(
          padding: const EdgeInsets.only(right: 50.0),
          child: Text('Ayuda',
              style: TextStyle(
                fontFamily: 'HankenGrotesk',
                color: Color(0xffffffff),
                fontSize: 15,
                fontWeight: FontWeight.w700,
                fontStyle: FontStyle.normal,
                letterSpacing: -0.5,
              )),
        )),
      ),
      body: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              Card(
                child: Container(
                  height: 66.0,
                  width: MediaQuery.of(context).size.width,
                  child: new FlatButton(
                      onPressed: () {
                        _launchURL();
                      },
                      child: Row(
                        children: <Widget>[
                          SizedBox(
                            width: 12.0,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 111),
                            child: new Text('Información de la aplicación ',
                                style: new TextStyle(
                                    fontSize: 14.0, color: Colors.black)),
                          ),
                          Icon(
                            IconData(
                              0xF3D3,
                              fontFamily: 'CupertinoIcons',
                            ),
                            size: 16,
                          ),
                        ],
                      )),
                ),
              ),
              Card(
                child: Container(
                  height: 66.0,
                  width: MediaQuery.of(context).size.width,
                  child: new FlatButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    PoliticaDePrivacidadPage()));
                      },
                      child: Row(
                        children: <Widget>[
                          SizedBox(
                            width: 12.0,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 156),
                            child: new Text('Política de Privacidad',
                                style: new TextStyle(
                                    fontSize: 14.0, color: Colors.black)),
                          ),
                          Icon(
                            IconData(
                              0xF3D3,
                              fontFamily: 'CupertinoIcons',
                            ),
                            size: 16,
                          ),
                        ],
                      )),
                ),
              ),
              Card(
                child: Container(
                  height: 66.0,
                  width: MediaQuery.of(context).size.width,
                  child: new FlatButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    TerminosCondicionesPage()));
                      },
                      child: Row(
                        children: <Widget>[
                          SizedBox(
                            width: 12.0,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 140.0),
                            child: new Text('Terminos y Condiciones',
                                style: new TextStyle(
                                    fontSize: 14.0, color: Colors.black)),
                          ),
                          Icon(
                            IconData(
                              0xF3D3,
                              fontFamily: 'CupertinoIcons',
                            ),
                            size: 16,
                          ),
                        ],
                      )),
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 70,
              child: NavigatorBar(),
            ),
          ),
        ],
      ),
    );
  }

  _launchURL() async {
    const url = 'https://www.seemur.com/establecimientos';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'No se puede lanzar la url $url';
    }
  }
}
