import 'package:cloud_firestore/cloud_firestore.dart';

class Usuario {
  String uid;
  String profileImageUrl;
  String nombre;
  String email;
  String password;
  String telefono;

  List calificaciones;

  Usuario({this.uid,
	  this.profileImageUrl,
	  this.email,
	  this.nombre,
	  this.password,
	  this.telefono,
	  this.calificaciones});

  factory Usuario.fromDoc(DocumentSnapshot doc) {
    return Usuario(
        uid: doc.documentID,
        nombre: doc['nombre'],
		    profileImageUrl: doc['imagen'],
        email: doc['email'],
        telefono: doc['telefono']);
  }
}
