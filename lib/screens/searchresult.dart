import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:seemur_v1/components/widgets/clients_body.dart';

class SearchResult extends StatefulWidget {
  final valor;
  SearchResult({this.valor});
  _SearchResultState createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResult> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: <Widget>[
          FlatButton(
            child: Text('Cancelar',
                style: TextStyle(
                  fontFamily: 'HankenGrotesk',
                  color: Color(0xffffffff),
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  fontStyle: FontStyle.normal,
                  letterSpacing: 0,
                )),
            onPressed: () {
              Navigator.of(context).pop();
            },
          )
        ],
        backgroundColor: Color.fromRGBO(22, 32, 44, 1),
        title: Text('Buscar',
            style: TextStyle(
              fontFamily: 'HankenGrotesk',
              color: Color(0xffffffff),
              fontSize: 15,
              fontWeight: FontWeight.w700,
              fontStyle: FontStyle.normal,
              letterSpacing: -0.5,
            )),
        centerTitle: true,
      ),
      body: FutureBuilder(
          future: Firestore.instance
              .collection('client')
              .where('tasktags', arrayContains: widget.valor)
              .getDocuments(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data != null) {
                return ListView.builder(
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      elevation: 0,
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
                                image: (snapshot.data.documents[index]['logos']
                                    .toString()),
                              ),
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.6,
                            height: 72.0,
                            child: ListTile(
                              onTap: () {
                                var datasnp =
                                    snapshot.data.documents[index].data;
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ClientBody(datos: datasnp)),
                                );
                              },
                              title: Container(
                                child: Text(
                                  snapshot.data.documents[index]['taskname'],
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
                    );
                  },
                  itemCount: snapshot.data.documents.length,
                );
              }
            } else {
              return Center(child: new CircularProgressIndicator());
            }
            return Container(
            );
          },
      ),
    );
  }
}
