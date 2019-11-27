import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:seemur_v1/auth/auth.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class MisResenasPage extends StatefulWidget {
  final BaseAuth auth;
  MisResenasPage({this.auth});

  _MisResenasPageState createState() => _MisResenasPageState();
}

class _MisResenasPageState extends State<MisResenasPage> {
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
    Stream<String> getData() async* {}

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
              child: Text('Mis reseñas',
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
      body: StreamBuilder(
        stream: Firestore.instance
            .collection("reseñas")
            .where("uid", isEqualTo: id)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            Text('Loading');
          } else {
            return ListView.separated(
              separatorBuilder: (context, index) =>
                  Divider(
                    color: Colors.black,
                  ),
              addAutomaticKeepAlives: true,
              itemCount: snapshot.data.documents.length,
              itemBuilder: (BuildContext context, idx) {
                return Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0, bottom: 110.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: FadeInImage.assetNetwork(
                          width: 46,
                          height: 46,
                          fit: BoxFit.cover,
                          placeholder:
                          ('assets/images/Contenedor de imagenes (375 x249).jpg'),
                          image: snapshot.data.documents[idx]['logos'],
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.6,
                      height: 226.0,
                      child: ListTile(
                        // dense: true,
                        // onTap: () {
                        //   var datasnp = snapshot.data.documents[idx].data;
                        //   Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) =>
                        //             ClientBody(datos: datasnp)),
                        //   );
                        // },
                        title: Padding(
                          padding: const EdgeInsets.only(top: 32.0),
                          child: Container(
                            child: Text(
                              snapshot.data.documents[idx]['taskname'],
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
                        subtitle: Container(
                          width: MediaQuery
                              .of(context)
                              .size
                              .width,
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(top: 12.0),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: SmoothStarRating(
                                    borderColor: Color(0xff16202C),
                                    color: Color(0xfff5af00),
                                    allowHalfRating: true,
                                    rating: double.parse(
                                        snapshot.data.documents[idx]['rating']),
                                    size: 13.0,
                                    starCount: 5,
                                    spacing: 2.0,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 16.0),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    snapshot.data.documents[idx]["reseña"]
                                        .toString(),
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
                            ],
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
