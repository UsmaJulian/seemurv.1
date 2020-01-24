import 'dart:async';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:seemur_v1/components/widgets/navigatorbar.dart';

class PlatoSeleccionadoPage extends StatefulWidget {
  final nombrePlato;
  final nombrerestaurante;

  PlatoSeleccionadoPage({this.nombrePlato, this.nombrerestaurante});

  @override
  _PlatoSeleccionadoPageState createState() => _PlatoSeleccionadoPageState();
}

class _PlatoSeleccionadoPageState extends State<PlatoSeleccionadoPage> {
  PageController pageController;
  StreamController<String> streamController = new StreamController();

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: 1, viewportFraction: 0.8);
  }

  @override
  void dispose() {
    streamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: Firestore.instance
            .collection('recomendados')
            .where('nombre', isEqualTo: widget.nombrePlato)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            const Text('loading');
          } else {
            return Stack(
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Flexible(
                      child: PageView.builder(
                        controller: pageController,
                        itemCount: 3,
                        itemBuilder: (BuildContext context, position) {
                          return imageSlider(snapshot, position);
                        },
                      ),
                    ),
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 80.0),
                        child: Container(child: _tambien_Podria_Gustarte()),
                      ),
                    ),
                  ],
                ),
                _CardPersonalizada(snapshot),
              ],
            );
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }

  imageSlider(snapshot, int index) {
    var lista = snapshot.data.documents[0]['imagenes'];
    String images = jsonEncode(lista);
    print('lista1-----');
    print(images);
    List list2 = jsonDecode(images);
    print('lista2-----');
    print(list2);

    return AnimatedBuilder(
      animation: pageController,
      builder: (context, widget) {
        double value = 1;
        if (pageController.position.haveDimensions) {
          value = pageController.page - index;
          value = (1 - (value.abs() * 0.3)).clamp(0.0, 1.0);
        }

        return Column(
          children: <Widget>[
            Center(
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.226,
                width: double.infinity,
                child: widget,
              ),
            ),
          ],
        );
      },
      child: Container(
        margin: EdgeInsets.fromLTRB(1, 0, 1, 0),
        child: Image.network(list2[index], fit: BoxFit.fill),
      ),
    );
  }

  _CardPersonalizada(snapshot) {
    return Padding(
      padding: const EdgeInsets.only(top: 150.0),
      child: ListView.builder(
          itemCount: 1,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: Card(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child:
                          Text(snapshot.data.documents[0]['nombre'].toString(),
                              style: TextStyle(
                                fontFamily: 'HankenGrotesk',
                                color: Color(0xff16202c),
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                fontStyle: FontStyle.normal,
                              )),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(28.0),
                      child: Text(
                          snapshot.data.documents[0]['descripcion'].toString(),
                          style: TextStyle(
                            fontFamily: 'HankenGrotesk',
                            color: Color(0xff16202c),
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            fontStyle: FontStyle.normal,
                          )),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(28.0),
                      child: Row(
                        children: <Widget>[
                          Icon(Icons.attach_money),
                          Text(snapshot.data.documents[0]['precio'].toString(),
                              style: TextStyle(
                                fontFamily: 'HankenGrotesk',
                                color: Color(0xff16202c),
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                fontStyle: FontStyle.normal,
                              )),
                          SizedBox(
                            width: 10.0,
                          ),
                          Text('COP',
                              style: TextStyle(
                                fontFamily: 'HankenGrotesk',
                                color: Color(0xff16202c),
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                fontStyle: FontStyle.normal,
                              )),
                          Spacer(),
                          Icon(Icons.thumb_up, color: Colors.teal),
                          SizedBox(
                            width: 10.0,
                          ),
                          Text(
                              snapshot.data.documents[0]['valoracion']
                                  .toString(),
                              style: TextStyle(
                                fontFamily: 'HankenGrotesk',
                                color: Color(0xff16202c),
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                fontStyle: FontStyle.normal,
                              ))
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }

  _tambien_Podria_Gustarte() {
    return Column(
      children: <Widget>[
        Expanded(
          child: Row(
            children: <Widget>[
              Expanded(
                child: StreamBuilder(
                    stream: Firestore.instance
                        .collection('recomendados')
                        .snapshots(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (!snapshot.hasData) {
                        const Text('loading');
                      } else {
                        return Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text('Tambíen podría gustarte',
                                  style: TextStyle(
                                    fontFamily: 'HankenGrotesk',
                                    color: Color(0xff16202c),
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                    fontStyle: FontStyle.normal,
                                  )),
                            ),
                            Expanded(
                              child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: snapshot.data.documents.length,
                                  itemBuilder: (BuildContext context, index) {
                                    var listado = snapshot.data.documents[index]
                                        ['imagenes'];

                                    String imagesslid = jsonEncode(listado);
                                    print('lista1-----');
                                    print(imagesslid);
                                    List list2_2 = jsonDecode(imagesslid);
                                    print('lista2-----');
                                    print(list2_2);

                                    return Column(
                                      children: <Widget>[
                                        Container(
                                          height: 100,
                                          width: 150,
                                          child: Card(
                                              child: Image.network(
                                            list2_2[index],
                                            fit: BoxFit.cover,
                                          )),
                                        ),
                                        Text(
                                            snapshot.data.documents[index]
                                                ['nombre'],
                                            style: TextStyle(
                                              fontFamily: 'HankenGrotesk',
                                              color: Color(0xff16202c),
                                              fontSize: 20,
                                              fontWeight: FontWeight.w700,
                                              fontStyle: FontStyle.normal,
                                            )),
                                      ],
                                    );
                                  }),
                            ),
                          ],
                        );
                      }
                      return Container();
                    }),
              ),
            ],
          ),
        ),
        Expanded(
            child: Padding(
          padding: const EdgeInsets.only(top: 90),
          child: NavigatorBar(navCallback: (i) => print("Navigating to $i")),
        ))
      ],
    );
  }
}
