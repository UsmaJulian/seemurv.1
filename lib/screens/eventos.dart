import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:seemur_v1/components/widgets/evento_body.dart';

class ProximosEventosPage extends StatefulWidget {
  final datos;
  ProximosEventosPage({this.datos});
  _ProximosEventosPageState createState() => _ProximosEventosPageState();
}

class _ProximosEventosPageState extends State<ProximosEventosPage> {
  var idx;
  // Future getEvent() async {
  //   var firestore = Firestore.instance;

  //   QuerySnapshot qn = await firestore.collection('evento').getDocuments();
  //   return qn.documents;
  // }

  @override
  Widget build(
    BuildContext context,
  ) {
    return StreamBuilder(
        stream: Firestore.instance.collection('evento').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            const Text('loading');
          } else {
            return Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 24.0),
                    child: Text(
                      "Próximos eventos",
                      style: TextStyle(
                        fontFamily: 'HankenGrotesk',
                        color: Color(0xff000000),
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        fontStyle: FontStyle.normal,
                        letterSpacing: -0.1000000014901161,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 25.0,
                  ),
                  SizedBox(
                    height: 130,
                    child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (ctx, idx) {
                          return Column(
                            children: <Widget>[
                              Container(
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
                                        var datos =
                                            snapshot.data.documents[idx];
                                        return EventoBody();
                                        //DetailScreen(infoimagen: datos);
                                      }));
                                    },
                                    child: FadeInImage.assetNetwork(
                                      width: 149,
                                      height: 94,
                                      fit: BoxFit.cover,
                                      placeholder:
                                          ('assets/images/seemurIsotipo.png'),
                                      image: (snapshot.data.documents[idx]
                                          ['imagen']),
                                    ),
                                  )),
                              Text(
                                  snapshot.data.documents[idx]["nombre"]
                                      .toString(),
                                  style: TextStyle(
                                    fontFamily: 'HankenGrotesk',
                                    color: Color(0xff000000),
                                    fontSize: 15,
                                    fontWeight: FontWeight.w700,
                                    fontStyle: FontStyle.normal,
                                  )),
                              Text(
                                  snapshot.data.documents[idx]["tipo evento"]
                                      .toString(),
                                  style: TextStyle(
                                    fontFamily: 'OpenSans',
                                    color: Color(0xff3d3d3d),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    fontStyle: FontStyle.normal,
                                    letterSpacing: 0.2000000029802322,
                                  )),
                            ],
                          );
                        },
                        separatorBuilder: (ctx, idx) {
                          return SizedBox(width: 15);
                        },
                        padding: EdgeInsets.fromLTRB(24.0, 0, 0, 0),
                        itemCount: snapshot.data.documents.length),
                  ),
                ]);
          }
          return Container();
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
      body: GestureDetector(
        child: Center(
          child: Hero(
            tag: 'imageHero',
            child: FadeInImage.assetNetwork(
              width: MediaQuery.of(context).size.width,
              height: 294,
              fit: BoxFit.cover,
              placeholder: ('assets/images/seemurIsotipo.png'),
              image: (widget.infoimagen['imagen'].toString()),
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
