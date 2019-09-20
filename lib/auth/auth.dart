import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:seemur_v1/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class BaseAuth {
  Future<String> signInEmailPassword(String email, String password);
  Future<String> signUpEmailPassword(Usuario usuario); //model/usuarios.dart
  Future<void> signOut();
  Future<String> currentUser();
  Future<FirebaseUser> infoUser();
  Future<String> getIdUser();
}

class Auth implements BaseAuth {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<String> signInEmailPassword(String email, String password) async {
    await Firestore().settings(timestampsInSnapshotsEnabled: true);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    FirebaseUser user = (await _firebaseAuth.signInWithEmailAndPassword(
            email: email, password: password))
        .user;
    await prefs.setString('userdata', user.uid);
    return user.uid;
  }

  Future<String> signUpEmailPassword(Usuario usuarioModel) async {
    await Firestore().settings(timestampsInSnapshotsEnabled: true);
    FirebaseUser user = (await _firebaseAuth.createUserWithEmailAndPassword(
            email: usuarioModel.email, password: usuarioModel.password))
        .user;

    UserUpdateInfo usuario = UserUpdateInfo();
    usuario.displayName = usuarioModel.nombre;
    await Firestore().settings(timestampsInSnapshotsEnabled: true);
    await user.updateProfile(usuario);
    await user
        .sendEmailVerification()
        .then((onValue) => print('Email de verificacion enviado'))
        .catchError(
            (onError) => print('Error de Email de verificacion: $onError'));

    await Firestore.instance
        .collection('usuarios')
        .document('${user.uid}')
        .setData({
          'nombre': usuarioModel.nombre, //name
          'telefono': usuarioModel.telefono, //phone
          'email': usuarioModel.email,
          //'ciudad': usuarioModel.ciudad, //city
          //'direccion': usuarioModel.direccion,
          "uid": usuarioModel.uid
        })
        .then((value) => print('Usuario registrado en la bd'))
        .catchError(
            (onError) => print('Error en registrar el usuario en la bd'));
    return user.uid;
  }

  Future<void> signOut() async {
    await Firestore().settings(timestampsInSnapshotsEnabled: true);
    return _firebaseAuth.signOut();
  }

  Future<String> currentUser() async {
    await Firestore().settings(timestampsInSnapshotsEnabled: true);
    FirebaseUser user = await _firebaseAuth.currentUser();
    String userId = user != null ? user.uid : 'no_login';
    return userId;
  }

  Future<FirebaseUser> infoUser() async {
    await Firestore().settings(timestampsInSnapshotsEnabled: true);
    FirebaseUser user = await _firebaseAuth.currentUser();
    String userId = user != null ? user.uid : 'No se pudo recuperar el usuario';
    print('recuperando usuario + $userId');

    return user;
  }

  Future<String> getIdUser() async {
    await Firestore().settings(timestampsInSnapshotsEnabled: true);
    FirebaseUser user = await _firebaseAuth.currentUser();
    print(user.uid);
    String userId = user != null ? user.uid : 'No se pudo recuperar el usuario';
    print('recuperando usuario + $userId');
    return userId;
  }
}
