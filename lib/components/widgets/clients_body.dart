import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:seemur_v1/auth/auth.dart';
import 'package:seemur_v1/components/widgets/calificar.dart';
import 'package:seemur_v1/components/widgets/navigatorbar.dart';
import 'package:seemur_v1/components/widgets/sharebutton.dart';
import 'package:url_launcher/url_launcher.dart';

class ClientBody extends StatefulWidget {
  ClientBody({
    this.datos,
  });
  final datos;

  @override
  _ClientBodyState createState() => _ClientBodyState();
}

class _ClientBodyState extends State<ClientBody> {
  StreamController<String> streamController = new StreamController();

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
  void dispose() {
    streamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
              height: MediaQuery.of(context).size.height,
              alignment: Alignment.center,
              color: Color.fromRGBO(246, 247, 250, 1),
              child: StreamBuilder(
                stream: Firestore.instance.collection("client").snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return Text("loading....");
                  } else {
                    if (snapshot.data.documents.length == 0) {
                    } else {
                      return SingleChildScrollView(
                        child: Container(
                            width: MediaQuery.of(context).size.width,
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
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              height: 226.0,
                                              child: FadeInImage.assetNetwork(
                                                fit: BoxFit.fill,
                                                placeholder:
                                                    ('assets/images/Contenedor de imagenes (375 x249).jpg'),
                                                image: (widget
                                                    .datos['taskclientimage']),
                                              ),
                                            ),
                                            Positioned(
                                              top: 55.0,
                                              left: 0,
                                              child: IconButton(
                                                icon: new Icon(
                                                  CupertinoIcons.back,
                                                  color: Colors.white,
                                                  size: 40.0,
                                                ),
                                                onPressed: () =>
                                                    Navigator.of(context).pop(),
                                              ),
                                            ),
                                            Positioned(
                                              top: 55.0,
                                              right: 5.0,
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
                                                    child: Row(
                                                      children: <Widget>[
                                                        cambiarIcono(),
                                                        Text('Visitado',
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
                                                      ],
                                                    ),
                                                    onPressed: () {
                                                      setState(() {
                                                        Firestore.instance
                                                            .collection(
                                                                'usuarios')
                                                            .document(userID)
                                                            .collection(
                                                                'visitados')
                                                            .document()
                                                            .setData({
                                                          'taskname': widget
                                                              .datos['taskname']
                                                              .toString(),
                                                          'logos': widget
                                                              .datos['logos']
                                                              .toString(),
                                                          'taskclientimage': widget
                                                              .datos[
                                                                  'taskclientimage']
                                                              .toString(),
                                                          'taskdescription': widget
                                                              .datos[
                                                                  'taskdescription']
                                                              .toString(),
                                                          'taskenvironments':
                                                              widget.datos[
                                                                  'taskenvironments'],
                                                          'taskfeaturedimages':
                                                              widget.datos[
                                                                  'taskfeaturedimages'],
                                                          'taskfeatures': widget
                                                                  .datos[
                                                              'taskfeatures'],
                                                          'taskfoods':
                                                              widget.datos[
                                                                  'taskcfoods'],
                                                          'taskhomeservice': widget
                                                              .datos[
                                                                  'taskhomeservice']
                                                              .toString(),
                                                          'tasklocation': widget
                                                              .datos[
                                                                  'tasklocation']
                                                              .toString(),
                                                          'taskoutfit': widget
                                                              .datos[
                                                                  'taskoutfit']
                                                              .toString(),
                                                          'taskpayment': widget
                                                              .datos[
                                                                  'taskpayment']
                                                              .toString(),
                                                          'taskphone': widget
                                                              .datos[
                                                                  'taskphone']
                                                              .toString(),
                                                          'taskplans':
                                                              widget.datos[
                                                                  'taskplans'],
                                                          'taskprice': widget
                                                              .datos[
                                                                  'taskprice']
                                                              .toString(),
                                                          'taskrecommendeddishes':
                                                              widget.datos[
                                                                  'taskrecommendeddishes'],
                                                          'taskservices': widget
                                                                  .datos[
                                                              'taskservices'],
                                                          'tasktags':
                                                              widget.datos[
                                                                  'tasktags'],
                                                          'tasktime': widget
                                                              .datos['tasktime']
                                                              .toString(),
                                                        });
                                                      });
                                                    },
                                                  )),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(
                                          top: 190, left: 4.0, right: 4.0),
                                      child: getMainCard(),
                                    )
                                  ],
                                ),

                                SizedBox(height: 40),

                                // otro widget

                                getFotosDestacadas(),

                                SizedBox(height: 40),

                                getPanelInformacion(),
                                SizedBox(height: 40),
                                getPlatosRecomendados(),
                                SizedBox(height: 40),
                                getReviews(),
                                // como llegar.
                              ],
                            )),
                      );
                    }
                  }
                  return Text("loading....");
                },
              )),
          Positioned(
            bottom: 0,
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

  Icon cambiarIcono() {
    return Icon(
      Icons.add,
    );
  }

  getMainCard() {
    return Card(
      child: Container(
//      margin: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
            boxShadow: [
              BoxShadow(
                  color: Colors.black26, blurRadius: 4, offset: Offset(0, 1))
            ]),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(widget.datos['taskname'].toString(),
                style: TextStyle(
                  fontFamily: 'HankenGrotesk',
                  color: Color(0xff000000),
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  fontStyle: FontStyle.normal,
                  letterSpacing: -0.4000000059604645,
                )),
            SizedBox(height: 20),
            Text(
              widget.datos['taskdescription'].toString(),
              style: TextStyle(
                fontFamily: 'OpenSans',
                color: Color(0xff3d3d3d),
                fontSize: 14,
                fontWeight: FontWeight.w400,
                fontStyle: FontStyle.normal,
              ),
            ),
            SizedBox(height: 20),
            getStarRating(4),
            SizedBox(height: 10),
            getHoursDistance(),
            SizedBox(height: 30),
            getCardButtons(),
          ],
        ),
      ),
    );
  }

  getStarRating(int num) {
    String str = List.generate(
          5,
          (idx) => idx < num ? "★" : "☆",
        ).join('') +
        "  ${num.toStringAsFixed(1)}";
    return Text(str,
        style: TextStyle(
          fontFamily: 'HankenGrotesk',
          color: Color(0xff000000),
          fontSize: 15,
          fontWeight: FontWeight.w700,
          fontStyle: FontStyle.normal,
          letterSpacing: -0.5,
        ));
  }

  getHoursDistance() {
    var style1 = TextStyle(fontSize: 14);
    var style2 = TextStyle(fontSize: 18, fontWeight: FontWeight.bold);
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("Horarios:", style: style1),
            Text(widget.datos['tasktime'].toString(), style: style2)
          ],
        ),
        Spacer(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("Distancia:", style: style1),
            Text(widget.datos['tasklocation'].toString(), style: style2)
          ],
        ),
        SizedBox(width: 20),
      ],
    );
  }

  getCardButtons() {
    var numero = widget.datos['taskphone'];
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        getFav1(Icons.favorite_border, Color(0xffff2f8e)),
        getFav2(
          Icons.star_border,
          Color(0xfff5af00),
        ),
        getFav3(Icons.share, Color(0xff4cd964)),
        Spacer(),
        MaterialButton(
          onPressed: () {},
          color: Color(0xff16202c),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(
                Icons.phone,
                color: Colors.white,
              ),
              FlatButton(
                onPressed: () => launch("tel://$numero"),
                child: Text(
                  "Llamar",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
        )
      ],
    );
  }

  getFav1(IconData iconData, Color color) {
    return FloatingActionButton(
      heroTag: "button1",
      onPressed: () {
        favoritos();
      },
      backgroundColor: Color(0xff16202c),
      mini: true,
      child: Icon(
        iconData,
        color: color,
      ),
    );
  }

  getFav2(
    IconData iconData,
    Color color,
  ) {
    var datos = widget.datos;

    return FloatingActionButton(
      heroTag: "button2",
      onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CalificarPage(
                datos: datos,
                auth: Auth(),
              ),
            ));
      },
      backgroundColor: Color(0xff16202c),
      mini: true,
      child: Icon(
        iconData,
        color: color,
      ),
    );
  }

  getFav3(IconData iconData, Color color) {
    return FloatingActionButton(
      heroTag: "button3",
      onPressed: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => ShareButtonPage()));
      },
      backgroundColor: Color(0xff16202c),
      mini: true,
      child: Icon(
        iconData,
        color: color,
      ),
    );
  }

  getFotosDestacadas() {
    return Flexible(
      child: Column(
        //        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 24.0),
            child: Text(
              "Fotos destacadas",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 10),
          StreamBuilder(
            stream: Firestore.instance.collection('client').snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                const Text('loading');
              } else {
                return SizedBox(
                  height: 110,
                  child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (ctx, idx) {
                        return Container(
                          width: 150,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 4,
                                  offset: Offset(0, 1),
                                )
                              ]),
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                idx = idx;
                              });
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (_) {
                                var datos = widget.datos['taskfeaturedimages']
                                        [idx]
                                    .toString();
                                return DetailScreen(infoimagen: datos);
                              }));
                            },
                            child: FadeInImage.assetNetwork(
                                width: 47,
                                height: 47,
                                fit: BoxFit.cover,
                                placeholder:
                                    ('assets/images/Contenedor de imagenes (375 x249).jpg'),
                                image: (widget.datos['taskfeaturedimages'][idx]
                                    .toString())),
                          ),
                        );
                      },
                      separatorBuilder: (ctx, idx) {
                        return SizedBox(width: 15);
                      },
                      padding: EdgeInsets.fromLTRB(24, 0, 0, 0),
                      itemCount: widget.datos['taskfeaturedimages'].length),
                );
              }

              return Text("loading....");
            },
          )
        ],
      ),
    );
  }

  getPanelInformacion() {
    Widget buildInfoItem(String title, String desc, IconData icon) {
      return Container(
        height: 85,
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(
                    color: Colors.black.withOpacity(.24), width: 1))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 2),
            Padding(
              padding: const EdgeInsets.only(left: 24.0),
              child: Text(
                title,
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2),
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 24.0, top: 15),
                  child: Icon(icon, color: Colors.black),
                ),
                SizedBox(width: 20),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Text(
                    desc,
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                Spacer(),
              ],
            )
          ],
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 24.0),
          child: Text(
            "Informacion",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: 40),
        Padding(
          padding: const EdgeInsets.only(left: 24.0),
          child: Text(
            'Cómo llegar',
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, letterSpacing: 1.2),
          ),
        ),
        ListTile(
          leading: Icon(
            CupertinoIcons.location,
            color: Colors.black,
            size: 22.0,
          ),
          title: Text(widget.datos['tasklocation']),
          trailing: Icon(
            CupertinoIcons.forward,
            color: Colors.black,
          ),
          onTap: () {},
        ),
        Divider(
          color: Colors.black,
        ),
        buildInfoItem("Precio Mínimo", widget.datos['taskprice'].toString(),
            Icons.attach_money),
        SizedBox(
          height: 20.0,
        ),
        buildInfoItem("Tipo de Vestuario",
            widget.datos['taskoutfit'].toString(), FontAwesomeIcons.tshirt),
        SizedBox(
          height: 20.0,
        ),
        buildInfoItem("Domicilio", widget.datos['taskhomeservice'].toString(),
            FontAwesomeIcons.motorcycle),
      ],
    );
  }

  getPlatosRecomendados() {
    Widget buildRow(String title, int likes) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          children: <Widget>[
            Text(
              '$title',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Spacer(),
            Icon(Icons.thumb_up, color: Colors.teal),
            SizedBox(width: 10),
            SizedBox(
                width: 50,
                child: Text(
                  "",
                  // "$likes",
                  style: TextStyle(fontSize: 14, color: Colors.teal),
                )),
          ],
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 24.0),
          child: Text(
            "Recomendamos",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: 10),
        Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  )
                ]),
            child: Column(
              children: [
                buildRow(
                    widget.datos['taskrecommendeddishes'][0]
                        .toString()
                        .replaceAll(new RegExp(r'[^\w\s]+'), ''),
                    1022),
                buildRow(
                    widget.datos['taskrecommendeddishes'][1]
                        .toString()
                        .replaceAll(new RegExp(r'[^\w\s]+'), ''),
                    1022),
                buildRow(
                    widget.datos['taskrecommendeddishes'][2]
                        .toString()
                        .replaceAll(new RegExp(r'[^\w\s]+'), ''),
                    1022),

                // buildRow("Tempura", 126),
              ],
            ))
      ].toList(),
    );
  }

  final String loremipsum =
      "Vivamus sit amet justo dapibus, ultrices metus vel, viverra mi. Morbi malesuada mauris quam, ut consequat turpis posuere vel. Morbi dictum erat a arcu bibendum condimentum. Integer volutpat eleifend eros, ut porttitor lacus imperdie . Integer volutpat eleifend eros, ut porttitor lacus imperdie ";

  getReviews() {
    Widget buildReviewItem(
        String name, int stars, int mins, int votes, String text) {
      return Container(
        height: 250,
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // logo
                Padding(
                  padding: const EdgeInsets.only(left: 24.0),
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.limeAccent,
                        border: Border.all(color: Colors.grey.withOpacity(.4))),
                  ),
                ),
                SizedBox(width: 20),
                // contenido.
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        name,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        "$votes votos",
                        style: TextStyle(
                          fontWeight: FontWeight.w300,
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        "$text",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(height: 20),
                      FlatButton(
                        onPressed: () {},
                        child: Text(
                          "Ver mas",
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 20),
                Text("$mins mins"),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 60.0),
              child: Divider(color: Colors.grey),
            ),
          ],
        ),
      );
    }

    List buildReviewList() {
      return [
        buildReviewItem(
            "Mike Hernandez", 4, 22, 23, loremipsum.substring(0, 220)),
        buildReviewItem(
            "Mike Nichols", 3, 20, 23, loremipsum.substring(0, 150)),
        buildReviewItem(
            "Claudia Hopkins", 5, 12, 23, loremipsum.substring(20, 120)),
      ];
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 24.0),
          child: Text(
            "Reseñas destacadas",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 24.0),
              child: Icon(Icons.star, color: Color(0xfff5af00)),
            ),
            SizedBox(width: 5),
            Text(
              "4.0",
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.w800),
            ),
            SizedBox(width: 20),
            Text(
              "+2K opiniones",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w200),
            ),
          ],
        ),
        SizedBox(height: 4),
        Divider(height: 1, color: Colors.grey),
        SizedBox(height: 20),
        ...buildReviewList(),
      ],
    );
  }

  void favoritos() {
    setState(() {
      Firestore.instance
          .collection('usuarios')
          .document(userID)
          .collection('favoritos')
          .document()
          .setData({
        'taskname': widget.datos['taskname'].toString(),
        'logos': widget.datos['logos'].toString(),
        'taskclientimage': widget.datos['taskclientimage'].toString(),
        'taskdescription': widget.datos['taskdescription'].toString(),
        'taskenvironments': widget.datos['taskenvironments'],
        'taskfeaturedimages': widget.datos['taskfeaturedimages'],
        'taskfeatures': widget.datos['taskfeatures'],
        'taskfoods': widget.datos['taskcfoods'],
        'taskhomeservice': widget.datos['taskhomeservice'].toString(),
        'tasklocation': widget.datos['tasklocation'].toString(),
        'taskoutfit': widget.datos['taskoutfit'].toString(),
        'taskpayment': widget.datos['taskpayment'].toString(),
        'taskphone': widget.datos['taskphone'].toString(),
        'taskplans': widget.datos['taskplans'],
        'taskprice': widget.datos['taskprice'].toString(),
        'taskrecommendeddishes': widget.datos['taskrecommendeddishes'],
        'taskservices': widget.datos['taskservices'],
        'tasktags': widget.datos['tasktags'],
        'tasktime': widget.datos['tasktime'].toString(),
      });
    });
  }
}

class DetailScreen extends StatefulWidget {
  final infoimagen;
  DetailScreen({this.infoimagen});

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black12,
      body: GestureDetector(
        child: Center(
          child: Hero(
            tag: 'imageHero2',
            child: FadeInImage.assetNetwork(
              width: MediaQuery.of(context).size.width,
              height: 340,
              fit: BoxFit.fill,
              placeholder:
                  ('assets/images/Contenedor de imagenes (375 x249).jpg'),
              image: (widget.infoimagen),
            ),
          ),
        ),
        onTap: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
