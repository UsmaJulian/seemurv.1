import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:seemur_v1/components/widgets/clients_body.dart';

class CierrePage extends StatefulWidget {
  final datos;

  CierrePage({this.datos});

  @override
  _CierrePageState createState() => _CierrePageState();
}

class _CierrePageState extends State<CierrePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(22, 32, 44, 1),
        automaticallyImplyLeading: false,
        leading: new IconButton(
          icon: new Icon(
            CupertinoIcons.back,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Calificar a ' + widget.datos['taskname'].toString(),
          textAlign: TextAlign.center,
        ),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 128.0),
            child: Center(
                child: Icon(
              Icons.sentiment_satisfied,
              size: 50,
            )),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 24.0),
            child: Center(
              child: Text("!Gracias por tu opinión!",
                  style: TextStyle(
                    fontFamily: 'HankenGrotesk',
                    color: Color(0xff000000),
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    fontStyle: FontStyle.normal,
                    letterSpacing: -0.4000000059604645,
                  )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16.0, left: 22.0, right: 22.0),
            child: Center(
              child: Text(
                  "Tu reseña será revisada para verificar que cumpla los términos y condiciones. Este proceso podría tardar hasta 24 horas.",
                  style: TextStyle(
                    fontFamily: 'OpenSans',
                    color: Color(0xff3d3d3d),
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.normal,
                    letterSpacing: 1,
                  )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 32.0),
            child: Container(
                height: MediaQuery.of(context)
                    .size
                    .height *
                    0.055,
                width: MediaQuery.of(context)
                    .size
                    .width *
                    0.30,
                decoration: new BoxDecoration(
                    borderRadius:
                    BorderRadius.circular(
                        22),
                    gradient: LinearGradient(
                        colors: [
                          Color(0xfffbd800),
                          Color(0xfff5af00)
                        ],
                        stops: [
                          0,
                          1
                        ])),
                child: FlatButton(
                  child:
                      Center(
                        child: Text('Entendido',
                            style: TextStyle(
                              fontFamily:
                              'HankenGrotesk',
                              color: Color(
                                  0xff16202c),
                              fontSize: 12,
                              fontWeight:
                              FontWeight
                                  .w700,
                              fontStyle:
                              FontStyle
                                  .normal,
                            )),
                      ),

                  onPressed: () {
                    Navigator.push(context, new MaterialPageRoute(builder: (context) =>ClientBody(datos: widget.datos,)));
                  }
                )),
          ),
        ],
      ),
    );
  }
}
