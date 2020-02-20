import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

final _firestore = Firestore.instance;
final storageRef = FirebaseStorage.instance.ref();
final usersRef = _firestore.collection('usuarios');
final clientsRef = _firestore.collection('client').document();
final calificarRef = _firestore.collection('calificar');
final ciudadesRef = _firestore.collection('ciudades');
final eventoRef = _firestore.collection('evento');
final filtroRef = _firestore.collection('filtros').getDocuments();
