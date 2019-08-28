import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:seemur_v1/auth/auth.dart';
import 'package:seemur_v1/screens/admin/add_client.dart';
import 'package:seemur_v1/screens/admin/show_client.dart';
import 'package:seemur_v1/screens/user/perfil.dart';
import 'package:localstorage/localstorage.dart';

final LocalStorage storage = new LocalStorage(id);
class CheckRolePage extends StatelessWidget {
  const CheckRolePage({Key key, this.user, this.auth}) : super(key: key);
  final FirebaseUser user;
  final BaseAuth auth;

  @override
  Widget build(BuildContext context) {
    // print('IDUsuario'+storage.getItem('userdata') );
    return Scaffold(
      body: StreamBuilder(
        stream: Firestore.instance
            .collection('usuarios')
            .document(storage.getItem('userdata'))
            .snapshots(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          print('imprimiendo');
          //print(storage.getItem('userdata'));
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (snapshot.hasData) {
            return checkRole(snapshot.data);
          }
          return LinearProgressIndicator();
        },
      ),
    );
  }

  Widget checkRole(DocumentSnapshot snapshot) {
    if (snapshot.data == null) {
      return Center(
        child: Text('no data set in the userId document in firestore'),
      );
    }
    if (snapshot.data['role'] == 'admin') {
      return ClientAddPage();
    } else {
      return PerfilPage();
    }
  }
}
