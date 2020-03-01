import 'package:flutter/material.dart';
import 'package:seemur_v1/auth/auth.dart';
import 'package:seemur_v1/screens/filtros_resultados.dart';

class BotonFiltrar extends StatefulWidget {
  @override
  _BotonFiltrarState createState() => _BotonFiltrarState();
}

class _BotonFiltrarState extends State<BotonFiltrar> {
  @override
  void initState() {
    super.initState();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140.0,
      height: 44.0,
      decoration: BoxDecoration(
        border: Border.all(width: 0, style: BorderStyle.none),
        borderRadius: BorderRadius.horizontal(
            left: Radius.circular(22), right: Radius.circular(22)),
        gradient: LinearGradient(
          colors: [new Color(0xFFFFE231), new Color(0xFFF5AF00)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 1.0, // has the effect of softening the shadow
            spreadRadius: 0, // has the effect of extending the shadow
            offset: Offset(
              0, // horizontal, move right 10
              0, // vertical, move down 10
            ),
          ),
        ],
      ),
      child: FlatButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Filtrosresult(
                        auth: Auth(),
                      )));
        },
        child: Text('Filtrar',
            style: new TextStyle(
              color: Colors.black,
              fontFamily: 'HankenGrotesk',
              fontSize: 14.0,
              fontWeight: FontWeight.w700,
            )),
      ),
    );
  }
}
