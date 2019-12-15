import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:seemur_v1/auth/auth.dart';
import 'package:seemur_v1/models/client_model.dart';

class ClientTop extends StatefulWidget {
  @override
  _ClientTopState createState() => _ClientTopState();
}

class _ClientTopState extends State<ClientTop> {
  StreamController<String> streamController = new StreamController();

  String userID;
  //Widget content;

  @override
  void initState() {
    super.initState();

    setState(() {
      Auth().currentUser().then((onValue) {
        userID = onValue;
        print('print userid $userID');
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
    var height = MediaQuery.of(context).size.height * 0.15;
    return Container(
        color: Colors.black,
        height: height,
        width: double.infinity,
        child: StreamBuilder(
            stream: Firestore.instance.collection("client").snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Text("loading....");
              } else {
                if (snapshot.data.documents.length == 0) {
                } else {
                  return Container(
                    color: Colors.black,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: snapshot.data.documents.map((document) {
                        return Row(
                          children: <Widget>[
                            InkWell(
                              onTap: () {
                                Client taskname = Client(
                                  taskname: document['taskname'].toString(),
                                  taskclientimage:
                                      document['taskclientimage'].toString(),
                                  taskdescription:
                                      document['taskdescription'].toString(),
                                  taskphone: document['taskphone'].toString(),
                                  taskprice: document['taskprice'].toString(),
                                  tasklocation:
                                      document['tasklocation'].toString(),
                                  tasktime: document['tasktime'].toString(),
                                );
                              },
                              child: Container(
                                height: 100.0,
                                margin: EdgeInsets.only(right: 20.0),
                                child: Card(
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 20.0, vertical: 10.0),
                                    child: Row(
                                      children: <Widget>[
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: FadeInImage(
                                            fit: BoxFit.cover,
                                            width: 65,
                                            height: 65,
                                            placeholder: AssetImage(
		                                            'assets/images/Contenedordeimagenes.jpg'),
                                            image: NetworkImage(
                                                document["taskclientimage"]),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 2.0,
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Text(
                                              document["taskname"].toString(),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16.0),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      }).toList(),
                    ),
                  );
                }
              }
            }));
  }
}
