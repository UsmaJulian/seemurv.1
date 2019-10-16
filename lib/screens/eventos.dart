import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ProximosEventosPage extends StatefulWidget {
  _ProximosEventosPageState createState() => _ProximosEventosPageState();
}

class _ProximosEventosPageState extends State<ProximosEventosPage> {
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
                    height: 94,
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
                              child: FadeInImage.assetNetwork(
                                width: 149,
                                height: 94,
                                fit: BoxFit.contain,
                                placeholder:
                                    ('assets/images/seemurIsotipo.png'),
                                image: (snapshot.data.documents[idx]['imagen']),
                              ));
                        },
                        separatorBuilder: (ctx, idx) {
                          return SizedBox(width: 15);
                        },
                        padding: EdgeInsets.zero,
                        itemCount: snapshot.data.documents.length),
                  )
                ]);
          }
        });
  }
}
