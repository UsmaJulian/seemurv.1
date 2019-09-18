import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:seemur_v1/auth/auth.dart';
import 'package:seemur_v1/screens/admin/add_client.dart';
import 'package:seemur_v1/screens/user/perfil.dart';

class CheckRoles extends StatefulWidget {
  CheckRoles({Key key, this.auth, this.user}) : super(key: key);
  final BaseAuth auth;
  final FirebaseUser user;

  _CheckRolesState createState() => _CheckRolesState();
}

class _CheckRolesState extends State<CheckRoles> {
  
  String usuario = 'Usuario'; //user
  String usuarioEmail = 'Email'; //userEmail
  String id;
  @override
  void initState() {
    super.initState();
    widget.auth.infoUser().then((onValue) {
      setState(() {
        usuario = onValue.displayName;
        usuarioEmail = onValue.email;
        id = onValue.uid;
        print('ID $id');
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream:
            Firestore.instance.collection('usuarios').document(id).snapshots(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
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
      return ClientAddPage(
        auth: Auth(),
      );
    } else {
      return PerfilPage(
        auth: Auth(),
      );
    }
  }
}
