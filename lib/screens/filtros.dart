import 'package:flutter/material.dart';
import 'package:seemur_v1/components/widgets/navigatorbar.dart';
import 'package:seemur_v1/screens/filtro_chips_page.dart';


class FiltrosPage extends StatefulWidget {
  @override
  _FiltrosPageState createState() => _FiltrosPageState();
}

class _FiltrosPageState extends State<FiltrosPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text('Filtros',
            style: TextStyle(
              fontFamily: 'HankenGrotesk',
              color: Color(0xffffffff),
              fontSize: 15,
              fontWeight: FontWeight.w700,
              fontStyle: FontStyle.normal,
              letterSpacing: -0.5,
            )),
        backgroundColor: Color(0xff16202c),
        actions: <Widget>[
          FlatButton(
            child: Text('Cerrar',
                style: TextStyle(
                  fontFamily: 'HankenGrotesk',
                  color: Color(0xffffffff),
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  fontStyle: FontStyle.normal,
                  letterSpacing: 0,
                )),
            onPressed: () {
              Navigator.of(context).pop();
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(height: 750, child: FiltroChipsPage()),

          ],
        ),
      ),
      bottomNavigationBar: Container(
        constraints: BoxConstraints(maxHeight: 70),
        child: NavigatorBar(navCallback: (i) => print("Navigating to $i")),
      ),
      backgroundColor: Colors.transparent,
    );
  }
}
