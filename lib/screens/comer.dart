import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:seemur_v1/components/widgets/clients_body.dart';
import 'package:seemur_v1/components/widgets/navigatorbar.dart';
import 'package:seemur_v1/screens/subcatscreens/bares.dart';
import 'package:seemur_v1/screens/subcatscreens/gastropubs.dart';
import 'package:seemur_v1/screens/subcatscreens/hoteles.dart';
import 'package:seemur_v1/screens/subcatscreens/restaurantes.dart';

class CommonThings {
  static Size size; //size screen
}

class ComerPage extends StatefulWidget {
  //ComerPage({Key key}) : super(key: key);

  _ComerPageState createState() => _ComerPageState();
}

class _ComerPageState extends State<ComerPage> {
  Future getClient() async {
    var firestore = Firestore.instance;

    QuerySnapshot qn = await firestore
        .collection('client')
        .where('tasktags', arrayContains: 'Comer')
        .getDocuments();
    return qn.documents;
  }

  @override
  Widget build(BuildContext context) {
    CommonThings.size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(107.0),
        child: AppBar(
          centerTitle: true,
          automaticallyImplyLeading: false,
          backgroundColor: Color.fromRGBO(22, 32, 44, 1),
          title: Padding(
            padding: const EdgeInsets.only(top: 30.0),
            child: Text(
              'Comer',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          leading: Padding(
            padding: const EdgeInsets.only(top: 22.0),
            child: new IconButton(
              icon: new Icon(
                CupertinoIcons.back,
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
        ),
      ),
      body: Column(
        children: <Widget>[
          Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Positioned(
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding:
                              EdgeInsets.only(top: 48.0, left: 0, right: 125.0),
                          child: Text('Sugerencias para ti',
                              style: TextStyle(
                                fontFamily: 'HankenGrotesk',
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.normal,
                                letterSpacing: -0.1,
                              )),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 24.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(26)),
                                margin: EdgeInsets.symmetric(vertical: 30.0),
                                height: 125,
                                child: ListView(
                                  scrollDirection: Axis.horizontal,
                                  children: <Widget>[
                                    Container(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: <Widget>[
                                          Container(
                                            width: 105,
                                            height: 92,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    new BorderRadius.circular(
                                                        6),
                                                color: Color(0xff16202c),
                                              ),
                                              child: Center(
                                                child: Wrap(
                                                  children: <Widget>[
                                                    FlatButton(
                                                      child: Image.asset(
                                                        'assets/images/restaurantsIcon@3x.png',
                                                        width: 38,
                                                        height: 38,
                                                      ),
                                                      onPressed: () {
                                                        Navigator.of(context).push(
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        RestaurantesPage()));
                                                      },
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          Text('Restaurantes',
                                              style: TextStyle(
                                                fontFamily: 'HankenGrotesk',
                                                color: Color(0xff000000),
                                                fontSize: 15,
                                                fontWeight: FontWeight.w700,
                                                fontStyle: FontStyle.normal,
                                                letterSpacing: -0.5,
                                              )),
                                          Text('',
                                              style: TextStyle(
                                                fontFamily: 'OpenSans',
                                                color: Color(0xff3d3d3d),
                                                fontSize: 11,
                                                fontWeight: FontWeight.w400,
                                                fontStyle: FontStyle.normal,
                                                letterSpacing:
                                                    0.2000000029802322,
                                              ))
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: 12.0,
                                    ),
                                    Container(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: <Widget>[
                                          Container(
                                            width: 105,
                                            height: 92,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    new BorderRadius.circular(
                                                        6),
                                                color: Color(0xff16202c),
                                              ),
                                              child: Center(
                                                child: Wrap(
                                                  children: <Widget>[
                                                    SizedBox(
                                                      height: 92,
                                                      width: 105,
                                                      child: FlatButton(
                                                        child: Image.asset(
                                                          'assets/images/gastroPubIcon@3x.png',
                                                          width: 38,
                                                          height: 38,
                                                        ),
                                                        onPressed: () {
                                                          Navigator.of(context).push(
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          GastroPubsPage()));
                                                        },
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          Text('GastroPubs',
                                              style: TextStyle(
                                                fontFamily: 'HankenGrotesk',
                                                color: Color(0xff000000),
                                                fontSize: 15,
                                                fontWeight: FontWeight.w700,
                                                fontStyle: FontStyle.normal,
                                                letterSpacing: -0.5,
                                              )),
                                          Text('',
                                              style: TextStyle(
                                                fontFamily: 'OpenSans',
                                                color: Color(0xff3d3d3d),
                                                fontSize: 11,
                                                fontWeight: FontWeight.w400,
                                                fontStyle: FontStyle.normal,
                                                letterSpacing:
                                                    0.2000000029802322,
                                              ))
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: 12.0,
                                    ),
                                    Container(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: <Widget>[
                                          Container(
                                            width: 105,
                                            height: 92,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    new BorderRadius.circular(
                                                        6),
                                                color: Color(0xff16202c),
                                              ),
                                              child: Center(
                                                child: Wrap(
                                                  children: <Widget>[
                                                    SizedBox(
                                                      height: 92,
                                                      width: 105,
                                                      child: FlatButton(
                                                        child: Image.asset(
                                                          'assets/images/barIcon@3x.png',
                                                          width: 38,
                                                          height: 38,
                                                        ),
                                                        onPressed: () {
                                                          Navigator.of(context).push(
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          BaresPage()));
                                                        },
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          Text('Bares',
                                              style: TextStyle(
                                                fontFamily: 'HankenGrotesk',
                                                color: Color(0xff000000),
                                                fontSize: 15,
                                                fontWeight: FontWeight.w700,
                                                fontStyle: FontStyle.normal,
                                                letterSpacing: -0.5,
                                              )),
                                          Text('',
                                              style: TextStyle(
                                                fontFamily: 'OpenSans',
                                                color: Color(0xff3d3d3d),
                                                fontSize: 11,
                                                fontWeight: FontWeight.w400,
                                                fontStyle: FontStyle.normal,
                                                letterSpacing:
                                                    0.2000000029802322,
                                              ))
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: 12.0,
                                    ),
                                    Container(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: <Widget>[
                                          Container(
                                            width: 105,
                                            height: 92,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    new BorderRadius.circular(
                                                        6),
                                                color: Color(0xff16202c),
                                              ),
                                              child: Center(
                                                child: Wrap(
                                                  children: <Widget>[
                                                    SizedBox(
                                                      height: 92,
                                                      width: 105,
                                                      child: FlatButton(
                                                        child: Image.asset(
                                                          'assets/images/hotelIcon@3x.png',
                                                          width: 38,
                                                          height: 38,
                                                        ),
                                                        onPressed: () {
                                                          Navigator.of(context).push(
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          HotelesPage()));
                                                        },
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          Text('Hoteles',
                                              style: TextStyle(
                                                fontFamily: 'HankenGrotesk',
                                                color: Color(0xff000000),
                                                fontSize: 15,
                                                fontWeight: FontWeight.w700,
                                                fontStyle: FontStyle.normal,
                                                letterSpacing: -0.5,
                                              )),
                                          Text('',
                                              style: TextStyle(
                                                fontFamily: 'OpenSans',
                                                color: Color(0xff3d3d3d),
                                                fontSize: 11,
                                                fontWeight: FontWeight.w400,
                                                fontStyle: FontStyle.normal,
                                                letterSpacing:
                                                    0.2000000029802322,
                                              )),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    child: Padding(
                      padding: EdgeInsets.only(
                        top: 300.0,
                      ),
                      child: Column(
                        children: <Widget>[
                          Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: new BoxDecoration(
                              color: Colors.white,
                            ),
                            child: FutureBuilder(
                              future: getClient(),
                              builder: (BuildContext context,
                                  AsyncSnapshot snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return Center(
                                    child: Text('Cargando Datos...'),
                                  );
                                } else {
                                  return ListView.builder(
                                    itemCount: snapshot.data.length,
                                    itemBuilder: (BuildContext context, index) {
                                      final datasnp = snapshot.data[index].data;
                                      return Container(
                                          child: Card(
                                        color: Color.fromRGBO(246, 247, 250, 5),
                                        elevation: 1,
                                        child: InkWell(
                                          onTap: () {
                                            //print('${snapshot.data[index].data['taskname']}');
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ClientBody(
                                                        datos: datasnp,
                                                      )),
                                            );
                                          },
                                          child: Row(
                                            children: <Widget>[
                                              SizedBox(
                                                  width: 30.0, height: 47.0),
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                child: FadeInImage.assetNetwork(
                                                  width: 47,
                                                  height: 47,
                                                  fit: BoxFit.fill,
                                                  placeholder:
                                                      ('assets/images/Contenedor de imagenes (375 x249).jpg'),
                                                  image: (snapshot.data[index]
                                                      .data['logos']),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 21.0,
                                                height: 47.0,
                                              ),
                                              Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.6,
                                                height: 72.0,
                                                child: ListTile(
                                                  title: Container(
                                                    child: Text(
                                                      snapshot.data[index]
                                                          .data['taskname'],
                                                      style: TextStyle(
                                                        fontFamily:
                                                            'HankenGrotesk',
                                                        color:
                                                            Color(0xff000000),
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        fontStyle:
                                                            FontStyle.normal,
                                                        letterSpacing: -0.5,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ));
                                    },
                                  );
                                }
                              },
                            ),
                          ),
                          //Text('Lugares',
                          //     style: TextStyle(
                          //       fontFamily: 'HankenGrotesk',
                          //       color: Colors.black,
                          //       fontSize: 15,
                          //       fontWeight: FontWeight.bold,
                          //       fontStyle: FontStyle.normal,
                          //       letterSpacing: -0.5,
                          //     )),
                        ],
                      ),
                    ),
                  ),
                  // Positioned(
                  //   child: Padding(
                  //     padding: EdgeInsets.only(
                  //       top: 372.0,
                  //     ),
                  //     child: Column(
                  //       children: <Widget>[
                  //         Container(
                  //           width: MediaQuery.of(context).size.width,
                  //           height: 50.0,
                  //           decoration: new BoxDecoration(
                  //             color: Colors.white,
                  //           ),
                  //           child: Padding(
                  //             padding:
                  //                 const EdgeInsets.only(top: 15.0, left: 24),
                  //             child: Text('Lugares Cerrados',
                  //                 style: TextStyle(
                  //                   fontFamily: 'HankenGrotesk',
                  //                   color: Colors.black,
                  //                   fontSize: 15,
                  //                   fontWeight: FontWeight.bold,
                  //                   fontStyle: FontStyle.normal,
                  //                   letterSpacing: -0.5,
                  //                 )),
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ],
          ),
          Expanded(
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 70,
            child: NavigatorBar(),
          ),
        ],
      ),
    );
  }
}
