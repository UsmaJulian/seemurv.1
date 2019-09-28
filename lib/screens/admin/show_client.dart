import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:seemur_v1/auth/auth.dart';
import 'package:seemur_v1/models/client_model.dart';
import 'package:seemur_v1/screens/admin/add_client.dart';
import 'package:seemur_v1/screens/admin/edit_client.dart';
import 'package:seemur_v1/screens/admin/view_client.dart';

class CommonThings {
  static Size size;
}

TextEditingController tasknameInputController;
TextEditingController taskdescriptionInputController;
TextEditingController tasklocationInputController;
TextEditingController taskphoneInputController;
TextEditingController taskpriceInputController;
TextEditingController tasktimeInputController;
TextEditingController taskclientimageInputController;
String id;
final db = Firestore.instance;
String taskdescription;
String tasklocation;
String taskname;
String taskphone;
String taskprice;
String tasktime;
String taskclientimage;

class ShowClientPage extends StatefulWidget {
  final String id;
  ShowClientPage({this.auth, this.onSignedOut, this.id});
  final BaseAuth auth;
  final VoidCallback onSignedOut;

  @override
  _ShowClientPageState createState() => _ShowClientPageState();
}

class _ShowClientPageState extends State<ShowClientPage> {
  StreamController<String> streamController = new StreamController();
  String userID;
  //Widget content;

  @override
  void initState() {
    super.initState();

    setState(() {
      Auth().currentUser().then((onValue) {
        userID = onValue;
        print('user id $userID');
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
    CommonThings.size = MediaQuery.of(context).size;
    //print('Width of the screen: ${CommonThings.size.width}');
    return new Scaffold(
      body: StreamBuilder(
        stream: Firestore.instance.collection("client").snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Text("loading....");
          } else {
            if (snapshot.data.documents.length == 0) {
              return Center(
                child: Column(
                  children: <Widget>[
                    Card(
                      margin: EdgeInsets.all(15),
                      shape: BeveledRectangleBorder(
                          side: BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.circular(5.0)),
                      elevation: 5.0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            '\nAgrega un cliente.\n',
                            style: TextStyle(fontSize: 24, color: Colors.blue),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              );
            } else {
              //print("from the streamBuilder: "+ snapshot.data.documents[]);
              // print(length.toString() + " doc length");

              return ListView(
                children: snapshot.data.documents.map((document) {
                  return Card(
                    elevation: 5.0,
                    child: Row(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.all(5.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: FadeInImage(
                              fit: BoxFit.cover,
                              width: 100,
                              height: 100,
                              placeholder:
                                  AssetImage('assets/images/azucar.gif'),
                              image: NetworkImage(document["taskclientimage"]),
                            ),
                          ),
                        ),
                        Expanded(
                          child: ListTile(
                            title: Text(
                              document['taskname'].toString().toUpperCase(),
                              style: TextStyle(
                                color: Colors.blueAccent,
                                fontSize: 17.0,
                              ),
                            ),
                            subtitle: Text(
                              document['taskdescription']
                                  .toString()
                                  .toUpperCase(),
                              style: TextStyle(
                                  color: Colors.black, fontSize: 12.0),
                            ),
                            //editar la receta
                            onTap: () {
                              Client client = Client(
                                taskname: document['taskname'].toString(),
                                taskclientimage:
                                    document['taskclientimage'].toString(),
                                taskdescription:
                                    document['taskdescription'].toString(),
                                tasklocation:
                                    document['tasklocation'].toString(),
                                taskphone: document['taskphone'].toString(),
                                taskprice: document['taskprice'].toString(),
                                tasktime: document['tasktime'].toString(),
                              );
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => EditClient(
                                          client: client,
                                          idClient: document.documentID,
                                          uid: userID)));
                            },
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.delete,
                            color: Colors.redAccent,
                          ),
                          onPressed: () {
                            document.data.remove('key');
                            Firestore.instance
                                .collection('client')
                                .document(document.documentID)
                                .delete();
                            FirebaseStorage.instance
                                .ref()
                                .child(
                                    'client/$userID/uid/client/${document['taskname'].toString()}.jpg')
                                .delete()
                                .then((onValue) {
                              print('foto eliminada');
                            });
                          }, //funciona
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.remove_red_eye,
                            color: Colors.blueAccent,
                          ),
                          //Visualizar la receta,
                          onPressed: () {
                            Client taskdescription = Client(
                              taskname: document['taskname'].toString(),
                              taskclientimage:
                                  document['taskclientimage'].toString(),
                              taskdescription:
                                  document['taskdescription'].toString(),
                              tasklocation: document['tasklocation'].toString(),
                              taskphone: document['taskphone'].toString(),
                              taskprice: document['taskprice'].toString(),
                              tasktime: document['tasktime'].toString(),
                            );
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ViewClient(
                                        client: taskdescription,
                                        idClient: document.documentID,
                                        uid: userID)));
                          },
                        ),
                      ],
                    ),
                  );
                }).toList(),
              );
            }
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Colors.pinkAccent,
        onPressed: () {
          Route route =
              MaterialPageRoute(builder: (context) => ClientAddPage());
          Navigator.push(context, route);
        },
      ),
    );
  }
}
