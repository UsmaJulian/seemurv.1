import 'package:cloud_firestore/cloud_firestore.dart';

class Usuario {
  String uid;
  String foto;
  String nombre;
  String email;
  String password;
  String telefono;
  
  List calificaciones;
  
  Usuario({this.uid,
    this.foto,
    this.email,
    this.nombre,
    this.password,
    this.telefono,
    this.calificaciones});
  
  factory Usuario.fromDoc(DocumentSnapshot doc) {
    return Usuario(
        uid: doc.documentID,
        nombre: doc['nombre'],
        foto: doc['imagen'],
        email: doc['email'],
        telefono: doc['telefono']);
  }
}
