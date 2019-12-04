import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:seemur_v1/auth/auth.dart';
import 'package:seemur_v1/screens/user/cierre_calificar_page.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class CalificarPage extends StatefulWidget {
  final datos;
  final BaseAuth auth;

  CalificarPage({this.datos, this.auth});

  _CalificarPageState createState() => _CalificarPageState();
}

class _CalificarPageState extends State<CalificarPage> {
  String usuario = 'Usuario';
  String userID;
  var rating = 0.0;
  TextEditingController resenacontroller = TextEditingController();
  String uid;
  String taskdescription;
  String tasklocation;
  String taskname;
  String taskphone;
  String taskprice;
  String tasktime;
  String taskclientimage;
  String taskhomeservice;
  List taskfoods;
  String taskpayment;
  List taskservices;
  List taskplans;
  List taskfeatures;
  List taskenvironments;
  List tasktags;
  String taskoutfit;
  List taskrecommendeddishes;
  List taskfeaturedimages;
  String urlFoto;
  String ratingcount;
  String totalrating;
  String logos;
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
        print('usuario');
      });
    });
  }

  Stream<QuerySnapshot> getData() async* {
    yield* Firestore.instance.collection('client').snapshots();
  }

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
      body: SingleChildScrollView(
        child: StreamBuilder(
            stream: getData(),
            builder: (context, snapshot) {
              var datos = widget.datos;
              return Container(
                decoration: new BoxDecoration(color: Color(0xfff6f7fa)),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 78.0),
                      child: Text(
                          'Calificar a ' + widget.datos['taskname'].toString(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'HankenGrotesk',
                            color: Color(0xff000000),
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                            fontStyle: FontStyle.normal,
                            letterSpacing: -0.4000000059604645,
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 32.0),
                      child: Container(
                        width: 375,
                        height: 66,
                        decoration: new BoxDecoration(color: Color(0xffffffff)),
                        child: Center(
                            child: SmoothStarRating(
                          borderColor: Color(0xff16202C),
                          color: Color(0xfff5af00),
                          allowHalfRating: true,
                          rating: rating,
                          size: 45,
                          starCount: 5,
                          spacing: 2.0,
                          onRatingChanged: (value) {
                            setState(() {
                              rating = value;
                            });
                          },
                        )),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 32.0, right: 160.0),
                      child: Text('Escribe un comentario',
                          style: TextStyle(
                            fontFamily: 'HankenGrotesk',
                            color: Color(0xff3d3d3d),
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            fontStyle: FontStyle.normal,
                            letterSpacing: 0,
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 12.0),
                      child: Container(
                        width: 327.0,
                        height: 140,
                        decoration: BoxDecoration(
                            color: Color(0xffffffff),
                            border:
                                Border.all(color: Color(0xffd9d9d9), width: 1),
                            borderRadius: BorderRadius.circular(8)),
                        child: TextField(
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "¿Qué opinas de este lugar?"),
                          style: TextStyle(
                            fontFamily: 'OpenSans',
                            color: Color(0xffada9a9),
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.normal,
                          ),
                          controller: resenacontroller,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 32.0),
                      child: Container(
                        height: 44.0,
                        width: MediaQuery.of(context).size.width * 0.84,
                        decoration: BoxDecoration(
                          border: Border.all(width: 0, style: BorderStyle.none),
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
                          child: Text('Calificar',
                              style: new TextStyle(
                                color: Colors.black,
                                fontFamily: 'HankenGrotesk',
                                fontSize: 15.0,
                                fontWeight: FontWeight.w700,
                              )),
                          onPressed: () => [
                            miscalificaciones(),
                            //misresenas(),
                            resenasdestacadas(),

                            Navigator.push(
                                context,
                                new MaterialPageRoute(
                                    builder: (context) =>
                                        CierrePage(datos: datos))),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
      ),
    );
  }

  void miscalificaciones() {
    print(rating);
    setState(() {
      Firestore.instance
          .collection('usuarios')
          .document(id)
          .collection('mis calificaciones')
          .document()
          .setData({
        'taskname': widget.datos['taskname'].toString(),
        'rating': rating.toStringAsFixed(1)
      });
    });
  }

  void resenasdestacadas() {
    setState(() {
      Firestore.instance.collection('calificar').document().setData({
        'logos': widget.datos['logos'].toString(),
        'taskname': widget.datos['taskname'].toString(),
        'opinion': resenacontroller.text.toString(),
        'rating': rating.toStringAsFixed(1),
        'nombre del usuario': usuario,
        'uid': id,
      });
    });
  }
}
