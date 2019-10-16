import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LugaresFavoritosPage extends StatefulWidget {
  LugaresFavoritosPage({Key key}) : super(key: key);

  _LugaresFavoritosPageState createState() => _LugaresFavoritosPageState();
}

class _LugaresFavoritosPageState extends State<LugaresFavoritosPage> {
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
          child: Text('Lugares favoritos',
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
    );
  }
}
