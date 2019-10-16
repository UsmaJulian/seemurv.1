import 'package:flutter/material.dart';
import 'package:seemur_v1/screens/registrarse.dart';

class CustomAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff16202c),
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('Términos y condiciones',
            style: new TextStyle(
              color: Colors.white,
              fontFamily: 'HankenGrotesk',
              fontSize: 14.0,
              fontWeight: FontWeight.w700,
            )),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Container(
              width: 115,
              height: 64,
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
              child: FlatButton(
                onPressed: () {},
                child: Text('Aceptar',
                    style: new TextStyle(
                      color: Colors.black,
                      fontFamily: 'HankenGrotesk',
                      fontSize: 14.0,
                      fontWeight: FontWeight.w700,
                    )),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
