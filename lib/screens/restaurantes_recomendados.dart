import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:seemur_v1/components/widgets/clients_body.dart';

class RestaurantesParaTi extends StatefulWidget {
  _RestaurantesParaTiState createState() => _RestaurantesParaTiState();
}

class _RestaurantesParaTiState extends State<RestaurantesParaTi> {
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
            .where('tasktags', arrayContains: 'Restaurante para ti')
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
                    padding: const EdgeInsets.only(left: 24.0),
                    child: Text(
                      "Restaurantes para ti",
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
                                //print('${snapshot.data[index].data['taskname']}');
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
                                            ('assets/images/seemurIsotipo.png'),
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
                                      title: Container(
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
                  )
                ]);
          }
          return Container();
        });
  }
}
