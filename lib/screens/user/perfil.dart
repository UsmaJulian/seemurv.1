import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:seemur_v1/auth/auth.dart';
import 'package:seemur_v1/components/widgets/navigatorbar.dart';
import 'package:seemur_v1/login_admin/root_page.dart';
import 'package:seemur_v1/screens/user/lugaresfavoritos.dart';

class PerfilPage extends StatefulWidget {
  PerfilPage({this.auth});
  final BaseAuth auth;
  @override
  _PerfilPageState createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilPage> {
  String usuario = 'Usuario'; //user
  String usuarioEmail = 'Email'; //userEmail
  String id;
  AuthStatus authStatus = AuthStatus.notSignIn;

  void signOut() async {
    setState(() {
      authStatus = AuthStatus.notSignIn;
    });
  }

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
    return new Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              IconData(0xF3E1, fontFamily: 'CupertinoIcons'),
              color: Colors.black,
              size: 20,
            ),
            onPressed: () {},
          )
        ],
      ),
      body: Stack(
        children: <Widget>[
          SingleChildScrollView(
            child: Center(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 22.0),
                    child: new Container(
                        width: 80,
                        height: 80,
                        decoration: new BoxDecoration(color: Colors.red)),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 24.0),
                    child: Text('Hola,' + '$usuario',
                        style: TextStyle(
                          fontFamily: 'HankenGrotesk',
                          color: Color(0xff000000),
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          fontStyle: FontStyle.normal,
                          letterSpacing: -0.1000000014901161,
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text("¿Qué tal tu día?",
                        style: TextStyle(
                          fontFamily: 'OpenSans',
                          color: Color(0xff3d3d3d),
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.normal,
                          letterSpacing: 0,
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 58.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Container(
                          height: 32,
                          width: 88,
                          decoration: BoxDecoration(
                            border:
                                Border.all(width: 0, style: BorderStyle.none),
                            borderRadius: BorderRadius.horizontal(
                                left: Radius.circular(22),
                                right: Radius.circular(22)),
                            gradient: LinearGradient(
                              colors: [
                                new Color(0xFFFFE231),
                                new Color(0xFFF5AF00)
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                          ),
                          child: FlatButton(
                            child: Text('Visitados',
                                style: new TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'HankenGrotesk',
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w700,
                                )),
                            onPressed: () {
                              // Navigator.push(context,
                              //     new MaterialPageRoute(builder: (context) => FiltrosPage()));
                            },
                          ),
                        ),
                        Container(
                          height: 32,
                          width: 88,
                          decoration: BoxDecoration(
                            border:
                                Border.all(width: 0, style: BorderStyle.none),
                            borderRadius: BorderRadius.horizontal(
                                left: Radius.circular(22),
                                right: Radius.circular(22)),
                            gradient: LinearGradient(
                              colors: [
                                new Color(0xFFFFE231),
                                new Color(0xFFF5AF00)
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                          ),
                          child: FlatButton(
                            child: Text('Favoritos',
                                style: new TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'HankenGrotesk',
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w700,
                                )),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  new MaterialPageRoute(
                                      builder: (context) =>
                                          LugaresFavoritosPage(auth: Auth())));
                            },
                          ),
                        ),
                        Container(
                          height: 32,
                          width: 88,
                          decoration: BoxDecoration(
                            border:
                                Border.all(width: 0, style: BorderStyle.none),
                            borderRadius: BorderRadius.horizontal(
                                left: Radius.circular(22),
                                right: Radius.circular(22)),
                            gradient: LinearGradient(
                              colors: [
                                new Color(0xFFFFE231),
                                new Color(0xFFF5AF00)
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                          ),
                          child: FlatButton(
                            child: Text('Reseñas',
                                style: new TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'HankenGrotesk',
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w700,
                                )),
                            onPressed: () {
                              // Navigator.push(context,
                              //     new MaterialPageRoute(builder: (context) => FiltrosPage()));
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  new Container(
                      width: 375,
                      height: 446,
                      decoration: new BoxDecoration(
                          color: Color(0xfff6f7fa),
                          borderRadius: BorderRadius.circular(8)))
                ],
              ),
            ),
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
}
