import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:seemur_v1/auth/auth.dart';

class LugaresFavoritosPage extends StatefulWidget {
  final BaseAuth auth;
  LugaresFavoritosPage({this.auth});
  _LugaresFavoritosPageState createState() => _LugaresFavoritosPageState();
}

class _LugaresFavoritosPageState extends State<LugaresFavoritosPage> {
  String id;

  @override
  void initState() {
    super.initState();
    widget.auth.infoUser().then((onValue) {
      setState(() {
        id = onValue.uid;
        print('ID $id');
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: new IconButton(
          icon: new Icon(
            CupertinoIcons.back,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Color.fromRGBO(22, 32, 44, 1),
        title: Center(
            child: Padding(
          padding: const EdgeInsets.only(right: 50.0),
          child: Text('Lugares favoritos',
              style: TextStyle(
                fontFamily: 'HankenGrotesk',
                color: Color(0xffffffff),
                fontSize: 15,
                fontWeight: FontWeight.w700,
                fontStyle: FontStyle.normal,
                letterSpacing: -0.5,
              )),
        )),
      ),
      body: FutureBuilder(
        future: Firestore.instance
            .collection('usuarios')
            .document(id)
            .collection('favoritos')
            .getDocuments(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            Text('Loading');
          } else {
            return ListView.builder(
              addAutomaticKeepAlives: true,
              itemCount: snapshot.data.documents.length,
              itemBuilder: (BuildContext context, index) {
                return Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: FadeInImage.assetNetwork(
                          width: 46,
                          height: 46,
                          fit: BoxFit.cover,
                          placeholder: ('assets/images/seemurIsotipo.png'),
                          image: (snapshot.data.documents[index]['logos']
                              .toString()),
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.6,
                      height: 72.0,
                      child: ListTile(
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
                );
              },
            );
          }
          return Container();
        },
      ),
    );
  }
}
