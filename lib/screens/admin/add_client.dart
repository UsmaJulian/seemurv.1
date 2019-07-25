import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:seemur_v1/auth/auth.dart';
import 'package:seemur_v1/login_admin/login_page.dart';

class CommonThings {
  static Size size; //size screen
}

class ClientAddPage extends StatefulWidget {
  final String id;
  const ClientAddPage({this.id});
  @override
  _ClientAddPageState createState() => _ClientAddPageState();
}

class _ClientAddPageState extends State<ClientAddPage> {
  //we declare the variables

  File _foto;
  String urlFoto;
  bool _isInAsyncCall = false;
  String client;
  Auth auth = Auth();

  TextEditingController taskdescriptionInputController;
  TextEditingController tasknameInputController;
  TextEditingController taskclientimageInputController;
  TextEditingController tasklocationInputController;
  TextEditingController taskpriceInputController;
  TextEditingController taskphoneInputController;
  TextEditingController tasktimeInputController;

  String id;
  final db = Firestore.instance;
  final _formKey = GlobalKey<FormState>();
  String uid;
  String taskdescription;
  String tasklocation;
  String taskname;
  String taskphone;
  String taskprice;
  String tasktime;
  String taskclientimage;

  //we create a method to obtain the image from the camera or the gallery

  Future captureImage(SelectSource opcion) async {
    File taskclientimage;

    opcion == SelectSource.camara
        ? taskclientimage =
            await ImagePicker.pickImage(source: ImageSource.camera)
        : taskclientimage =
            await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _foto = taskclientimage;
    });
  }

  Future getImage() async {
    AlertDialog alerta = new AlertDialog(
      content: Text('Seleccione de donde desea capturar la imagen'),
      title: Text('Seleccione Imagen'),
      actions: <Widget>[
        FlatButton(
          onPressed: () {
            // seleccion = SelectSource.camara;
            captureImage(SelectSource.camara);
            Navigator.of(context, rootNavigator: true).pop();
          },
          child: Row(
            children: <Widget>[Text('Camara'), Icon(Icons.camera)],
          ),
        ),
        FlatButton(
          onPressed: () {
            // seleccion = SelectSource.galeria;
            captureImage(SelectSource.galeria);
            Navigator.of(context, rootNavigator: true).pop();
          },
          child: Row(
            children: <Widget>[Text('Galeria'), Icon(Icons.image)],
          ),
        )
      ],
    );
    showDialog(context: context, child: alerta);
  }

  Widget divider() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
      child: Container(
        width: 0.8,
        color: Colors.black,
      ),
    );
  }

  //crated a method validate
  bool _validarlo() {
    final form = _formKey.currentState;

    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  //create a method send and create recipe in Cloud Firestore
  void _enviar() {
    if (_validarlo()) {
      setState(() {
        _isInAsyncCall = true;
      });
      auth.currentUser().then((onValue) {
        setState(() {
          uid = onValue;
        });
        if (_foto != null) {
          final StorageReference fireStoreRef = FirebaseStorage.instance
              .ref()
              .child('client')
              .child(uid)
              .child('uid')
              .child('tasklocation')
              .child('taskname')
              .child('taskphone')
              .child('taskprice')
              .child('tasktime')
              .child('taskdescription')
              .child('$taskclientimage.jpg');
          final StorageUploadTask task = fireStoreRef.putFile(
              _foto, StorageMetadata(contentType: 'image/jpeg'));

          task.onComplete.then((onValue) {
            onValue.ref.getDownloadURL().then((onValue) {
              setState(() {
                urlFoto = onValue.toString();
                Firestore.instance
                    .collection('client')
                    .add({
                      'uid': uid,
                      'taskclientimage': taskclientimage,
                      'taskclientimage': urlFoto,
                      'taskdescription': taskdescription,
                      'tasklocation': tasklocation,
                      'taskname': taskname,
                      'taskphone': taskphone,
                      'taskprice': taskprice,
                      'tasktime': tasktime,
                    })
                    .then((value) => Navigator.of(context).pop())
                    .catchError((onError) =>
                        print('Error en registrar el usuario en la bd'));
                _isInAsyncCall = false;
              });
            });
          });
        } else {
          Firestore.instance
              .collection('client')
              .add({
                'uid': uid,
                'taskclientimage': taskclientimage,
                'taskclientimage': urlFoto,
                'taskdescription': taskdescription,
                'tasklocation': tasklocation,
                'taskname': taskname,
                'taskphone': taskphone,
                'taskprice': taskprice,
                'tasktime': tasktime,
              })
              .then((value) => Navigator.of(context).pop())
              .catchError(
                  (onError) => print('Error en registrar el usuario en la bd'));
          _isInAsyncCall = false;
        }
      }).catchError((onError) => _isInAsyncCall = false);

      //

    } else {
      print('objeto no validado');
    }
  }

  @override
  Widget build(BuildContext context) {
    CommonThings.size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(
          title: Text('Add Client'),
        ),
        body: ModalProgressHUD(
          inAsyncCall: _isInAsyncCall,
          opacity: 0.5,
          dismissible: false,
          progressIndicator: CircularProgressIndicator(),
          color: Colors.blueGrey,
          child: SingleChildScrollView(
            padding: EdgeInsets.only(left: 10, right: 15),
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Container(
                        child: GestureDetector(
                          onTap: getImage,
                        ),
                        margin: EdgeInsets.only(top: 20),
                        height: 120,
                        width: 120,
                        decoration: BoxDecoration(
                            border: Border.all(width: 1.0, color: Colors.black),
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                fit: BoxFit.fill,
                                image: _foto == null
                                    ? AssetImage('assets/images/azucar.gif')
                                    : FileImage(_foto))),
                      )
                    ],
                  ),
                  Text('click para cambiar foto'),
                  Padding(
                    padding: EdgeInsets.only(top: 10),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Nombre',
                        fillColor: Colors.grey[300],
                        filled: true,
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter some text';
                        }
                      },
                      onSaved: (value) => taskname = value.trim(),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: TextFormField(
                      maxLines: 4, //numero de lineas aceptadas
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Descripción',
                        fillColor: Colors.grey[300],
                        filled: true,
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter some description';
                        }
                      },
                      onSaved: (value) => taskdescription = value,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: TextFormField(
                      maxLines: 1, //numero de lineas aceptadas
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Ubicación',
                        fillColor: Colors.grey[300],
                        filled: true,
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter some location';
                        }
                      },
                      onSaved: (value) => tasklocation = value,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: TextFormField(
                      maxLines: 1, //numero de lineas aceptadas
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Telefono',
                        fillColor: Colors.grey[300],
                        filled: true,
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter some phone';
                        }
                      },
                      onSaved: (value) => taskphone = value,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: TextFormField(
                      maxLines: 1, //numero de lineas aceptadas
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Precio',
                        fillColor: Colors.grey[300],
                        filled: true,
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter some price';
                        }
                      },
                      onSaved: (value) => taskprice = value,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: TextFormField(
                      maxLines: 1, //numero de lineas aceptadas
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Horario',
                        fillColor: Colors.grey[300],
                        filled: true,
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter some time';
                        }
                      },
                      onSaved: (value) => tasktime = value,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      RaisedButton(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                        onPressed: _enviar,
                        child: Text('Crear',
                            style: TextStyle(color: Colors.white)),
                        color: Color(0xff16202c),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ));
  }
}