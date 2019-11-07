import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:seemur_v1/auth/auth.dart';
import 'package:seemur_v1/components/widgets/navigatorbar.dart';
import 'package:url_launcher/url_launcher.dart';

class EventoBody extends StatefulWidget {
  final datosevent;

  EventoBody({this.datosevent});

  @override
  _EventoBodyState createState() => _EventoBodyState();
}

class _EventoBodyState extends State<EventoBody> {
  String userID;

  @override
  void initState() {
    super.initState();

    setState(() {
      Auth().currentUser().then((onValue) {
        userID = onValue;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var numero = widget.datosevent['telefono'];
    return Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  height: MediaQuery
                      .of(context)
                      .size
                      .height,
                  alignment: Alignment.center,
                  color: Color.fromRGBO(246, 247, 250, 1),
                  child: StreamBuilder(
                      stream:
                      Firestore.instance.collection('evento').snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (!snapshot.hasData) {
                          return Text("loading....");
                        } else {
                          if (snapshot.data.documents.length == 0) {} else {
                            return SingleChildScrollView(
                              child: Container(
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Stack(
                                      children: <Widget>[
                                        Column(
                                          children: <Widget>[
                                            Stack(
                                              children: <Widget>[
                                                Container(
                                                  width: MediaQuery
                                                      .of(context)
                                                      .size
                                                      .width,
                                                  height: 226.0,
                                                  child:
                                                  FadeInImage.assetNetwork(
                                                    fit: BoxFit.fill,
                                                    placeholder:
                                                    ('assets/images/seemurIsotipo.png'),
                                                    image: (widget
                                                        .datosevent['imagen']),
                                                  ),
                                                ),
                                                Positioned(
                                                  top: 25.0,
                                                  left: 0,
                                                  child: IconButton(
                                                    icon: new Icon(
                                                      CupertinoIcons.back,
                                                      color: Colors.white,
                                                      size: 40.0,
                                                    ),
                                                    onPressed: () =>
                                                        Navigator.of(context)
                                                            .pop(),
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(
                                              top: 190, left: 4.0, right: 4.0),
                                          child: Card(
                                            child: Container(
                                              padding: EdgeInsets.all(20),
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                  BorderRadius.circular(
                                                      8.0),
                                                  boxShadow: [
                                                    BoxShadow(
                                                        color: Colors.black26,
                                                        blurRadius: 4,
                                                        offset: Offset(0, 1))
                                                  ]),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Text(
                                                      widget
                                                          .datosevent['nombre']
                                                          .toString(),
                                                      style: TextStyle(
                                                        fontFamily:
                                                        'HankenGrotesk',
                                                        color:
                                                        Color(0xff000000),
                                                        fontSize: 24,
                                                        fontWeight:
                                                        FontWeight.w700,
                                                        fontStyle:
                                                        FontStyle.normal,
                                                        letterSpacing:
                                                        -0.4000000059604645,
                                                      )),
                                                  SizedBox(height: 20),
                                                  Text(
                                                    widget.datosevent[
                                                    'descripcion']
                                                        .toString(),
                                                    style: TextStyle(
                                                      fontFamily: 'OpenSans',
                                                      color: Color(0xff3d3d3d),
                                                      fontSize: 14,
                                                      fontWeight:
                                                      FontWeight.w400,
                                                      fontStyle:
                                                      FontStyle.normal,
                                                    ),
                                                  ),
                                                  SizedBox(height: 20),
                                                  Text('Lugar:'),
                                                  SizedBox(height: 10),
                                                  Text(
                                                      widget.datosevent['lugar']
                                                          .toString(),
                                                      style: TextStyle(
                                                        fontFamily:
                                                        'HankenGrotesk',
                                                        color:
                                                        Color(0xff000000),
                                                        fontSize: 14,
                                                        fontWeight:
                                                        FontWeight.w700,
                                                        fontStyle:
                                                        FontStyle.normal,
                                                        letterSpacing:
                                                        -0.4000000059604645,
                                                      )),
                                                  SizedBox(height: 48.0),
                                                  Row(
                                                    mainAxisSize:
                                                    MainAxisSize.max,
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                    children: <Widget>[
                                                      FloatingActionButton(
                                                        onPressed: () {},
                                                        backgroundColor:
                                                        Color(0xff16202c),
                                                        mini: true,
                                                        child: Icon(
                                                          Icons.share,
                                                          color:
                                                          Color(0xff4cd964),
                                                        ),
                                                      ),
                                                      Spacer(),
                                                      MaterialButton(
                                                        onPressed: () {},
                                                        color:
                                                        Color(0xff16202c),
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                20)),
                                                        child: Row(
                                                          mainAxisSize:
                                                          MainAxisSize.min,
                                                          children: <Widget>[
                                                            Icon(
                                                              Icons.phone,
                                                              color:
                                                              Colors.white,
                                                            ),
                                                            FlatButton(
                                                              onPressed: () =>
                                                                  launch(
                                                                      "tel://$numero"),
                                                              child: Text(
                                                                "Información",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      )
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 40),
                                    Container(
                                      child: Column(
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 130.0),
                                            child: Text(
                                              'Información del evento',
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold),
                                              textAlign: TextAlign.left,
                                            ),
                                          ),
                                          SizedBox(height: 32),
                                          Column(
                                            children: <Widget>[
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 246.0),
                                                child: Text('Cómo llegar',
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                        FontWeight.bold)),
                                              ),
                                              ListTile(
                                                leading: Icon(
                                                  CupertinoIcons.location,
                                                  color: Colors.black,
                                                  size: 20.0,
                                                ),
                                                title: Text(widget
                                                    .datosevent['ubicacion']),
                                                trailing: Icon(
                                                  CupertinoIcons.forward,
                                                  color: Colors.black,
                                                ),
                                                onTap: () {},
                                              ),
                                              Divider()
                                            ],
                                          ),
                                          SizedBox(height: 32),
                                          Column(
                                            children: <Widget>[
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 280.0),
                                                child: Text('Horario',
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                        FontWeight.bold)),
                                              ),
                                              ListTile(
                                                leading: Icon(
                                                  FontAwesomeIcons
                                                      .calendarCheck,
                                                  color: Colors.black,
                                                  size: 20.0,
                                                ),
                                                title: Text(widget
                                                    .datosevent['horario']),
                                              ),
                                              Divider()
                                            ],
                                          ),
                                          SizedBox(height: 32),
                                          Column(
                                            children: <Widget>[
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 210.0),
                                                child: Text('Valor de Ingreso',
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                        FontWeight.bold)),
                                              ),
                                              ListTile(
                                                leading: Icon(
                                                  Icons.attach_money,
                                                  color: Colors.black,
                                                  size: 20.0,
                                                ),
                                                title: Text(widget
                                                    .datosevent['precio']),
                                              ),
                                              Divider()
                                            ],
                                          ),
                                          SizedBox(height: 32),
                                          Column(
                                            children: <Widget>[
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 210.0),
                                                child: Text('Tipo de vestuario',
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                        FontWeight.bold)),
                                              ),
                                              ListTile(
                                                leading: Icon(
                                                  FontAwesomeIcons.tshirt,
                                                  color: Colors.black,
                                                  size: 15.0,
                                                ),
                                                title: Text(widget.datosevent[
                                                'tipodevestuario']),
                                              ),
                                              Divider(),
                                              SizedBox(height: 90),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }
                          return Text("loading....");
                        }
                      }),
                ),
                Positioned(
                    bottom: 0,
                    child: Container(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width,
                      height: 70,
                      child: NavigatorBar(),
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
