import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:seemur_v1/auth/auth.dart';
import 'package:seemur_v1/components/widgets/calificar.dart';
import 'package:seemur_v1/components/widgets/navigatorbar.dart';
import 'package:seemur_v1/screens/mapsPage.dart';
import 'package:seemur_v1/screens/plato_seleccionado_screen.dart';
import 'package:share/share.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
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
  String text = '';
  String subject = '';
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
                                                ('assets/images/Contenedordeimagenes.jpg'),
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
                                                            .document(widget
		                                                        .datos[
                                                        'taskname']
		                                                        .toString())
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

                                Container(
                                  child: Column(
                                    children: <Widget>[
                                      Text("Reseñas destacadas",
                                          style: TextStyle(
                                            fontFamily: 'HankenGrotesk',
                                            color: Color(0xff000000),
                                            fontSize: 20,
                                            fontWeight: FontWeight.w700,
                                            fontStyle: FontStyle.normal,
                                            letterSpacing: -0.1000000014901161,
                                          )),
                                      Container(
                                        height: 200,
                                        child: StreamBuilder(
                                          stream: Firestore.instance
                                              .collection('calificar')
                                              .where("taskname",
		                                          isEqualTo:
		                                          widget.datos['taskname'])
                                              .snapshots(),
                                          builder: (BuildContext context,
                                              AsyncSnapshot<QuerySnapshot>
                                              snapshot) {
                                            if (!snapshot.hasData) {
                                              Text('Loading');
                                            } else {
                                              return ListView.separated(
                                                  separatorBuilder:
                                                      (context, index) =>
		                                                  Divider(
			                                                  color: Colors.black,
		                                                  ),
                                                  itemCount: snapshot
                                                      .data.documents.length,
                                                  itemBuilder:
                                                      (BuildContext context,
		                                                  index) {
                                                    return Column(
                                                      children: <Widget>[
                                                        Row(
                                                          children: <Widget>[
                                                            SmoothStarRating(
                                                              borderColor: Color(
                                                                  0xff16202C),
                                                              color: Color(
                                                                  0xfff5af00),
                                                              allowHalfRating:
                                                              true,
                                                              rating: double
		                                                              .parse(
		                                                              snapshot
				                                                              .data
				                                                              .documents[index]
		                                                              [
		                                                              'rating']),
                                                              size: 18.0,
                                                              starCount: 5,
                                                              spacing: 2.0,
                                                            ),
                                                            SizedBox(
                                                              width: 16.0,
                                                            ),
                                                            Text(
                                                                snapshot
                                                                    .data
                                                                    .documents[
                                                                index][
                                                                'rating']
                                                                    .toString(),
                                                                style:
                                                                TextStyle(
                                                                  fontFamily:
                                                                  'HankenGrotesk',
                                                                  color: Color(
                                                                      0xff000000),
                                                                  fontSize: 24,
                                                                  fontWeight:
                                                                  FontWeight
		                                                                  .w700,
                                                                  fontStyle:
                                                                  FontStyle
		                                                                  .normal,
                                                                  letterSpacing:
                                                                  -0.4000000059604645,
                                                                )),
                                                          ],
                                                        ),
                                                        Row(
                                                          children: <Widget>[
                                                            Container(
		                                                            width: MediaQuery
				                                                            .of(
				                                                            context)
				                                                            .size
				                                                            .width *
                                                                    0.6,
                                                                height: 226.0,
                                                                child: ListTile(
                                                                  title:
                                                                  Container(
                                                                    child: Text(
                                                                        snapshot
                                                                            .data
                                                                            .documents[index]['nombre del usuario'],
                                                                        style: TextStyle(
                                                                          fontFamily:
                                                                          'HankenGrotesk',
                                                                          color:
                                                                          Color(
		                                                                          0xff000000),
                                                                          fontSize:
                                                                          15,
                                                                          fontWeight:
                                                                          FontWeight
		                                                                          .w700,
                                                                          fontStyle:
                                                                          FontStyle
		                                                                          .normal,
                                                                          letterSpacing:
                                                                          -0.5,
                                                                        )),
                                                                  ),
                                                                  subtitle:
                                                                  Container(
                                                                    child: Text(
		                                                                    snapshot
				                                                                    .data
				                                                                    .documents[0]['opinion'] ??
                                                                            'pendiente',
                                                                        style:
                                                                        TextStyle(
                                                                          fontFamily:
                                                                          'HankenGrotesk',
                                                                          color:
                                                                          Color(
		                                                                          0xff000000),
                                                                          fontSize:
                                                                          15,
                                                                          fontWeight:
                                                                          FontWeight
		                                                                          .w700,
                                                                          fontStyle:
                                                                          FontStyle
		                                                                          .normal,
                                                                          letterSpacing:
                                                                          -0.5,
                                                                        )),
                                                                  ),
                                                                ))
                                                          ],
                                                        )
                                                      ],
                                                    );
                                                  });
                                            }
                                            return Container();
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                SizedBox(height: 85),
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
              child:
              NavigatorBar(navCallback: (i) => print("Navigating to $i")),
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
            Container(
              height: 13.0,
              child: StreamBuilder(
                stream: Firestore.instance
                    .collection('calificar')
                    .where("taskname", isEqualTo: widget.datos['taskname'])
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    Text('Loading');
                  } else {
                    return ListView.builder(
                        itemCount: snapshot.data.documents.length,
                        itemBuilder: (BuildContext context, idx) {
                          return Row(
                            children: <Widget>[
                              SmoothStarRating(
                                borderColor: Color(0xff16202C),
                                color: Color(0xfff5af00),
                                allowHalfRating: true,
                                rating: double.parse(
                                    snapshot.data.documents[idx]['rating']),
                                size: 14.0,
                                starCount: 5,
                                spacing: 2.0,
                              ),
                              SizedBox(
                                width: 16.0,
                              ),
                              Text(snapshot.data.documents[idx]['rating']
                                  .toString())
                            ],
                          );
                        });
                  }
                  return Container();
                },
              ),
            ),
            SizedBox(height: 10),
            getHoursDistance(),
            SizedBox(height: 30),
            getCardButtons(),
          ],
        ),
      ),
    );
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
	      getFav3(
		      Icons.share,
		      Color(0xff4cd964),
		      widget.datos['taskname'],
		      widget.datos['taskdescription'],
	      ),
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

  getFav3(IconData iconData,
		  Color color,
		  String nombre,
		  String descripcion,) {
	  String nombre = widget.datos['taskname'];
	  String descripcion = widget.datos['taskdescription'];
    return FloatingActionButton(
      heroTag: "button3",
	    onPressed: () =>
			    share(context, nombre = nombre, descripcion = descripcion),
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
                                ('assets/images/Contenedordeimagenes.jpg'),
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
	      InkWell(
		      onTap: () {
			      Navigator.push(
					      context,
					      MaterialPageRoute(
							      builder: (context) =>
									      MapsPage(
										      lugar: widget.datos['taskname'].toString(),
									      )));
		      },
		      child: ListTile(
			      dense: true,
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
		      ),
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
    Widget buildRow(String title, int likes, index) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          children: <Widget>[
            Text(
              '$title',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Spacer(),
            InkWell(
              child: Icon(Icons.thumb_up, color: Colors.teal),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
		                    builder: (context) =>
				                    PlatoSeleccionadoPage(
						                    nombrePlato: widget
								                    .datos['taskrecommendeddishes']
                                [index],
						                    nombrerestaurante: widget.datos['taskname']
								                    .toString()
								                    .replaceAll(new RegExp(r'[^\w\s]+'), ''))));
              },
            ),
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
                    1022,
                    0),
                buildRow(
                    widget.datos['taskrecommendeddishes'][1]
                        .toString()
                        .replaceAll(new RegExp(r'[^\w\s]+'), ''),
                    1022,
                    1),
                buildRow(
                    widget.datos['taskrecommendeddishes'][2]
                        .toString()
                        .replaceAll(new RegExp(r'[^\w\s]+'), ''),
                    1022,
                    2),

                // buildRow("Tempura", 126),
              ],
            ))
      ].toList(),
    );
  }

  void favoritos() {
    setState(() {
      Firestore.instance
          .collection('usuarios')
          .document(userID)
          .collection('favoritos')
          .document(widget.datos['taskname'].toString())
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

  share(BuildContext context, nombre, descripcion) {
	  String text = nombre;
	  final RenderBox box = context.findRenderObject();
	  Share.share(text,
			  subject: descripcion,
			  sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
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
              placeholder: ('assets/images/Contenedordeimagenes.jpg'),
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
