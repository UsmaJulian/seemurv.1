import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:seemur_v1/components/widgets/clients_body.dart';

class BaresyDiscosParaTi extends StatefulWidget {
  _BaresyDiscosParaTiState createState() => _BaresyDiscosParaTiState();
}

class _BaresyDiscosParaTiState extends State<BaresyDiscosParaTi> {
  Future getEvent() async {
    var firestore = Firestore.instance;

    QuerySnapshot qn = await firestore.collection('client').getDocuments();
    return qn.documents;
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return StreamBuilder(
        stream: Firestore.instance
            .collection('client')
            .where('tasktags', arrayContains: 'Disco para ti')
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            const Text('loading');
          } else {
            return Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 24.0,
                    ),
                    child: Text(
                      "Bares y discotecas para ti",
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
                    height: 94,
                    child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (ctx, idx) {
                          final datasnp = snapshot.data.documents[idx].data;
                          return Card(
                            color: Color.fromRGBO(246, 247, 250, 5),
                            elevation: 2,
                            child: InkWell(
                              onTap: () {
                                // print('${snapshot.data[index].data['taskname']}');
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ClientBody(
                                            datos: datasnp,
                                          )),
                                );
                              },
                              child: Row(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(left: 16.0),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: FadeInImage.assetNetwork(
                                        width: 46,
                                        height: 46,
                                        fit: BoxFit.cover,
                                        placeholder:
                                        ('assets/images/Contenedordeimagenes.jpg'),
                                        image: (snapshot.data.documents[idx]
                                            ['logos']),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.6,
                                    height: 72.0,
                                    child: ListTile(
                                      contentPadding:
                                          EdgeInsets.fromLTRB(14, 0, 50, 0),
                                      title: Column(
                                        children: <Widget>[
                                          SizedBox(
                                            height: 16.0,
                                          ),
                                          Container(
                                            child: Text(
                                              snapshot.data.documents[idx]
                                                  ['taskname'],
                                              style: TextStyle(
                                                fontFamily: 'HankenGrotesk',
                                                color: Color(0xff000000),
                                                fontSize: 15,
                                                fontWeight: FontWeight.w700,
                                                fontStyle: FontStyle.normal,
                                                letterSpacing: -0.5,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 6.0,
                                          ),
                                          Container(
                                            child: Text(
                                              snapshot.data.documents[idx]
                                                  ['tipo de recomendado bar'],
                                              style: TextStyle(
                                                fontFamily: 'OpenSans',
                                                color: Color(0xff3d3d3d),
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400,
                                                fontStyle: FontStyle.normal,
                                                letterSpacing:
                                                    0.2000000029802322,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 16.0,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
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
