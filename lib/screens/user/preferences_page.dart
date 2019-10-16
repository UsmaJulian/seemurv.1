import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:seemur_v1/auth/auth.dart';
import 'package:seemur_v1/components/widgets/navigatorbar.dart';
import 'package:seemur_v1/screens/Informaciondestacada.dart';
import 'package:seemur_v1/screens/ayuda.dart';
import 'package:seemur_v1/screens/cuenta.dart';
import 'package:seemur_v1/screens/empresas.dart';
import 'package:seemur_v1/screens/splash_screen%20_one_loading.dart';

class PreferencesPage extends StatefulWidget {
  PreferencesPage({this.auth, this.onSignOut});

  final BaseAuth auth;
  final VoidCallback onSignOut;

  @override
  _PreferencesPageState createState() => _PreferencesPageState();
}

class _PreferencesPageState extends State<PreferencesPage> {
  String usuario = 'Usuario'; //user
  String usuarioEmail = 'Email'; //userEmail
  String id;
  @override
  @override
  Widget build(BuildContext context) {
    void _signOut() async {
      try {
        await widget.auth.signOut();
        //onSignOut();
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => SplashScreenOneLoading()));
      } catch (e) {
        print(e);
      }
    }

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(22, 32, 44, 1),
          title: Center(
              child: Text('Ajustes',
                  style: TextStyle(
                    fontFamily: 'HankenGrotesk',
                    color: Color(0xffffffff),
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    fontStyle: FontStyle.normal,
                    letterSpacing: -0.5,
                  ))),
        ),
        body: Stack(
          children: <Widget>[
            SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Card(
                    child: Container(
                      height: 80.0,
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        children: <Widget>[
                          SizedBox(
                            width: 24.0,
                            height: 80.0,
                          ),
                          Container(
                              width: 20,
                              height: 24,
                              decoration: new BoxDecoration(color: Colors.red)),
                          SizedBox(
                            width: 24.0,
                            height: 80.0,
                          ),
                          Text('$usuario',
                              style: TextStyle(
                                fontFamily: 'HankenGrotesk',
                                color: Color(0xff000000),
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                fontStyle: FontStyle.normal,
                                letterSpacing: -0.1000000014901161,
                              )),
                        ],
                      ),
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
                                  builder: (context) => CuentaPage(
                                        auth: Auth(),
                                      )),
                            );
                          },
                          child: Row(
                            children: <Widget>[
                              Icon(
                                IconData(59558, fontFamily: 'MaterialIcons'),
                                size: 20.0,
                                color: Color.fromRGBO(245, 175, 0, 1),
                              ),
                              SizedBox(
                                width: 12.0,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 216),
                                child: new Text('Cuenta',
                                    style: new TextStyle(
                                        fontSize: 14.0, color: Colors.black)),
                              ),
                              Icon(
                                IconData(
                                  0xF3D3,
                                  fontFamily: 'CupertinoIcons',
                                ),
                                size: 16,
                                color: Colors.black,
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
                                  builder: (context) => InfoDestacadaPage(
                                        auth: Auth(),
                                      )),
                            );
                          },
                          child: Row(
                            children: <Widget>[
                              Icon(
                                IconData(0xF4B2, fontFamily: 'CupertinoIcons'),
                                size: 20.0,
                                color: Color.fromRGBO(245, 175, 0, 1),
                              ),
                              SizedBox(
                                width: 12.0,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 116),
                                child: new Text('Información destacada',
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
                          onPressed: () {},
                          child: Row(
                            children: <Widget>[
                              Icon(
                                IconData(0xF442, fontFamily: 'CupertinoIcons'),
                                size: 20.0,
                                color: Color.fromRGBO(245, 175, 0, 1),
                              ),
                              SizedBox(
                                width: 12.0,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 146),
                                child: new Text('Invitar a un amigo ',
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
                                  builder: (context) => EmpresasPage(
                                        auth: Auth(),
                                      )),
                            );
                          },
                          child: Row(
                            children: <Widget>[
                              Icon(
                                FontAwesomeIcons.building,
                                size: 20.0,
                                color: Color.fromRGBO(245, 175, 0, 1),
                              ),
                              SizedBox(
                                width: 12.0,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 196),
                                child: new Text('Empresas',
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
                                  builder: (context) => AyudaPage(
                                        auth: Auth(),
                                      )),
                            );
                          },
                          child: Row(
                            children: <Widget>[
                              Icon(
                                IconData(0xF445, fontFamily: 'CupertinoIcons'),
                                size: 20.0,
                                color: Color.fromRGBO(245, 175, 0, 1),
                              ),
                              SizedBox(
                                width: 12.0,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 218),
                                child: new Text('ayuda',
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
                          onPressed: _signOut,
                          child: Row(
                            children: <Widget>[
                              Icon(
                                IconData(59558, fontFamily: 'MaterialIcons'),
                                size: 20.0,
                                color: Color.fromRGBO(245, 175, 0, 1),
                              ),
                              SizedBox(
                                width: 12.0,
                              ),
                              new Text('Cerrar Sesión',
                                  style: new TextStyle(
                                      fontSize: 14.0, color: Colors.black)),
                            ],
                          )),
                    ),
                  ),
                  Card(
                    child: Container(
                      color: Color.fromRGBO(246, 247, 250, 1),
                      height: 66.0,
                      width: MediaQuery.of(context).size.width,
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 70,
                child: NavigatorBar(
                  auth: Auth(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
