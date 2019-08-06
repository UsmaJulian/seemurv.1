import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:seemur_v1/auth/auth.dart';
import 'package:seemur_v1/login_admin/login_page.dart';
import 'package:seemur_v1/login_admin/root_page.dart';
import 'package:seemur_v1/screens/onboard.dart';


class Ciudades extends StatefulWidget {
  @override
  _CiudadesState createState() => new _CiudadesState();
}

class _CiudadesState extends State<Ciudades> {
  int _radioValue1 = -1;
  void _handleRadioValueChange1(int e) {
    setState(() {
      if (e == 1) {
        _radioValue1 = 1;
      } else if (e == 2) {
        _radioValue1 = 2;
      } else if (e == 3) {
        _radioValue1 = 3;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      //appBar: AppBar(),
      body: new Container(
        color: Color.fromRGBO(246, 247, 250, 100),
        child: new Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 130, left: 0, right: 95),
              child: new Text(
                '¿En que ciudad estás?',
                style: new TextStyle(
                  color: Colors.black,
                  fontFamily: 'HankenGrotesk',
                  fontSize: 24.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Padding(
              padding: new EdgeInsets.only(top: 16, left: 30, right: 48),
              child: new Text(
                'Selecciona tu ubicación para descubrir los mejores lugares y eventos cerca de ti. Podrás cambiar esta opción en cualquier momento.',
                textAlign: TextAlign.justify,
                style: new TextStyle(
                  color: Colors.black,
                  fontFamily: 'HankenGrotesk',
                  fontSize: 14.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 32, left: 0, right: 0),
              child: new Divider(
                color: Colors.transparent,
              ),
            ),
            Container(
              color: Colors.white,
              child: new Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 23, bottom: 23, left: 30, right: 178),
                    child: new Text(
                      'Manizales',
                      style: new TextStyle(
                        color: Colors.black,
                        fontFamily: 'HankenGrotesk',
                        fontSize: 16.0,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 0, bottom: 0, left: 61, right: 0),
                    child: new Radio(
                      value: 1,
                      groupValue: _radioValue1,
                      onChanged: (int e) => _handleRadioValueChange1(e),
                      activeColor: Color.fromRGBO(245, 175, 0, 100),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 0, left: 0, right: 0),
              child: new Divider(
                height: 2,
                color: Colors.transparent,
              ),
            ),
            Container(
              color: Colors.white,
              child: new Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 23, bottom: 23, left: 30, right: 260),
                    child: new Text(
                      'Pereira',
                      style: new TextStyle(
                        color: Colors.black,
                        fontFamily: 'HankenGrotesk',
                        fontSize: 16.0,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 0, bottom: 0, left: 0, right: 0),
                    child: new Radio(
                      value: null,
                      groupValue: _radioValue1,
                      onChanged: (int e) => _handleRadioValueChange1(e),
                      activeColor: Color.fromRGBO(245, 175, 0, 100),
                    ),
                  ),
                ],
              ),
            ),
            new Divider(
              height: 2,
              color: Colors.transparent,
            ),
            Container(
              color: Colors.white,
              child: new Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 23, bottom: 23, left: 30, right: 199),
                    child: new Text(
                      'Bogotá',
                      style: new TextStyle(
                        color: Colors.black,
                        fontFamily: 'HankenGrotesk',
                        fontSize: 16.0,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 0, bottom: 0, left: 61, right: 0),
                    child: new Radio(
                      value: null,
                      groupValue: _radioValue1,
                      onChanged: (int e) => _handleRadioValueChange1(e),
                      activeColor: Color.fromRGBO(245, 175, 0, 100),
                    ),
                  ),
                ],
              ),
            ),
            new Padding(
              padding: EdgeInsets.only(top: 32, bottom: 0, left: 30, right: 30),
            ),
            Container(
              width: 315,
              height: 44,
              decoration: BoxDecoration(
                border: Border.all(width: 0, style: BorderStyle.none),
                borderRadius: BorderRadius.horizontal(
                    left: Radius.circular(22), right: Radius.circular(22)),
                gradient: LinearGradient(
                  colors: [new Color(0xFFFFE231), new Color(0xFFF5AF00)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: new FlatButton(
                child: new Text("Continuar",
                    style: new TextStyle(
                      color: Colors.black,
                      fontFamily: 'HankenGrotesk',
                      fontSize: 14.0,
                      fontWeight: FontWeight.w700,
                    )),
                onPressed: () {
                  Navigator.push(
                    context,
                    new MaterialPageRoute(
                      builder: (context) => RootPage(auth: Auth(),)
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
