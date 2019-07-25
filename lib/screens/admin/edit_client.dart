import 'package:image_picker/image_picker.dart' as img;
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:path_provider/path_provider.dart';
import 'package:seemur_v1/auth/auth.dart';
import 'package:seemur_v1/models/client_model.dart';

class EditClient extends StatefulWidget {
  EditClient({
    this.client,
    this.idClient,
    this.uid,
    this.taskdescription,
    this.taskname,
    this.tasklocation,
    this.taskphone,
    this.taskprice,
    this.tasktime,
  });
  final String idClient;
  final String uid;
  final Client client;
  final String taskdescription;
  final String tasklocation;
  final String taskname;
  final String taskphone;
  final String taskprice;
  final String tasktime;

  @override
  _EditClientState createState() => _EditClientState();
}

enum SelectSource { camara, galeria }

class _EditClientState extends State<EditClient> {
  final formKey = GlobalKey<FormState>();
  String _taskname;
  String _taskdescription;
  String _tasklocation;
  String _taskphone;
  String _taskprice;
  String _tasktime;

  File _taskclientimage; //
  String urlFoto = '';
  Auth auth = Auth();
  bool _isInAsyncCall = false;
  String usuario;

  BoxDecoration box = BoxDecoration(
      border: Border.all(width: 1.0, color: Colors.black),
      shape: BoxShape.circle,
      image: DecorationImage(
          fit: BoxFit.fill, image: AssetImage('assets/images/azucar.gif')));

  @override
  void initState() {
    setState(() {
      this._taskname = widget.client.taskname;
      this._taskdescription = widget.client.taskdescription;
      this._tasklocation = widget.client.tasklocation;
      this._taskphone = widget.client.taskphone;
      this._taskprice = widget.client.taskprice;
      this._tasktime = widget.client.tasktime;

      captureImage(null, widget.client.taskclientimage);
    });

    print('uid client : ' + widget.idClient);
    super.initState();
  }

  //create method for download url image
  static var httpClient = new HttpClient();
  Future<File> _downloadFile(String url, String filename) async {
    var request = await httpClient.getUrl(Uri.parse(url));
    var response = await request.close();
    var bytes = await consolidateHttpClientResponseBytes(response);
    String dir = (await getApplicationDocumentsDirectory()).path;
    File file = new File('$dir/$filename');
    await file.writeAsBytes(bytes);
    return file;
  }

  Future captureImage(SelectSource opcion, String url) async {
    File taskclientimage;
    if (url == null) {
      print('taskclientimage');
      opcion == SelectSource.camara
          ? taskclientimage = await img.ImagePicker.pickImage(
              source: img.ImageSource.camera) //source: ImageSource.camera)
          : taskclientimage =
              await img.ImagePicker.pickImage(source: img.ImageSource.gallery);

      setState(() {
        taskclientimage = taskclientimage;
        box = BoxDecoration(
            border: Border.all(width: 1.0, color: Colors.black),
            shape: BoxShape.circle,
            image: DecorationImage(
                fit: BoxFit.fill, image: FileImage(taskclientimage)));
      });
    } else {
      print('descarga la imagen');
      _downloadFile(url, widget.client.taskname).then((onValue) {
        taskclientimage = onValue;
        setState(() {
          box = BoxDecoration(
              border: Border.all(width: 1.0, color: Colors.black),
              shape: BoxShape.circle,
              image: DecorationImage(
                  fit: BoxFit.fill, image: FileImage(taskclientimage)));
          ////  imageReceta = FileImage(_foto);
        });

        // : FileImage(_imagen)))
      });
    }
  }

  Future getImage() async {
    AlertDialog alerta = new AlertDialog(
      content: Text('Seleccione para capturar la imagen'),
      title: Text('Seleccione Imagen'),
      actions: <Widget>[
        FlatButton(
          onPressed: () {
            // seleccion = SelectSource.camara;
            captureImage(SelectSource.camara, null);
            Navigator.of(context, rootNavigator: true).pop();
          },
          child: Row(
            children: <Widget>[Text('Camara'), Icon(Icons.camera)],
          ),
        ),
        FlatButton(
          onPressed: () {
            // seleccion = SelectSource.galeria;
            captureImage(SelectSource.galeria, null);
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

  bool _validar() {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  void _enviar() {
    //send the information to firestore
    if (_validar()) {
      setState(() {
        _isInAsyncCall = true;
      });
      auth.currentUser().then((onValue) {
        setState(() {
          usuario = onValue;
        });
        if (_taskclientimage != null) {
          final StorageReference fireStoreRef = FirebaseStorage.instance
              .ref()
              .child('client')
              .child('$_taskname.jpg');
          final StorageUploadTask task = fireStoreRef.putFile(
              _taskclientimage, StorageMetadata(contentType: 'image/jpeg'));

          task.onComplete.then((onValue) {
            onValue.ref.getDownloadURL().then((onValue) {
              setState(() {
                urlFoto = onValue.toString();
                Firestore.instance
                    .collection('client')
                    .document(widget.idClient)
                    .updateData({
                      'taskname': _taskname,
                      'taskclientimage': urlFoto,
                      'taslocation': _tasklocation,
                      'taskphone': _taskphone,
                      'taskprice': _taskprice,
                      'taskdescription': _taskdescription,
                      'tasktime': _tasktime,
                    })
                    .then((value) => Navigator.of(context).pop())
                    .catchError((onError) =>
                        print('Error al editar el cliente en la bd'));
                _isInAsyncCall = false;
              });
            });
          });
        } else {
          Firestore.instance
              .collection('client')
              .add({
                'taskname': _taskname,
                'taskclientimage': urlFoto,
                'taskdescription': _taskdescription, 'taslocation': _tasklocation,
                      'taskphone': _taskphone,
                      'taskprice': _taskprice,'tasktime': _tasktime,
              })
              .then((value) => Navigator.of(context).pop())
              .catchError(
                  (onError) => print('Error editar el usuario en la bd'));
          _isInAsyncCall = false;
        }
      }).catchError((onError) => _isInAsyncCall = false);
    } else {
      print('objeto no validado');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Client Edit'),
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
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                              child: GestureDetector(
                                onDoubleTap: getImage,
                              ),
                              margin: EdgeInsets.only(top: 20),
                              height: 120,
                              width: 120,
                              decoration: box)
                        ]),
                    Text('Doble click para cambiar imagen'),
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                    ),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      initialValue: _taskname,
                      decoration: InputDecoration(
                        labelText: 'Nombre',
                      ),
                      validator: (value) =>
                          value.isEmpty ? 'El campo Nombre esta vacio' : null,
                      onSaved: (value) => _taskname = value.trim(),
                    ),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      initialValue: _taskdescription,
                      decoration: InputDecoration(
                        labelText: 'Descripción',
                      ),
                      validator: (value) => value.isEmpty
                          ? 'El campo Descripción esta vacio'
                          : null,
                      onSaved: (value) => _taskdescription = value.trim(),
                    ),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      initialValue: _tasklocation,
                      decoration: InputDecoration(
                        labelText: 'Ubicación',
                      ),
                      validator: (value) =>
                          value.isEmpty ? 'El campo Ubicacín esta vacio' : null,
                      onSaved: (value) => _tasklocation = value.trim(),
                    ),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      initialValue: _taskphone,
                      decoration: InputDecoration(
                        labelText: 'Teléfono',
                      ),
                      validator: (value) =>
                          value.isEmpty ? 'El campo Teléfono esta vacio' : null,
                      onSaved: (value) => _taskphone = value.trim(),
                    ),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      initialValue: _taskprice,
                      decoration: InputDecoration(
                        labelText: 'Precio',
                      ),
                      validator: (value) =>
                          value.isEmpty ? 'El campo Precio esta vacio' : null,
                      onSaved: (value) => _taskprice = value.trim(),
                    ),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      initialValue: _tasktime,
                      decoration: InputDecoration(
                        labelText: 'Horario',
                      ),
                      validator: (value) =>
                          value.isEmpty ? 'El campo Horario esta vacio' : null,
                      onSaved: (value) => _tasktime = value.trim(),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 50),
                    )
                  ],
                ),
              ),
            )),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.orange,
            onPressed: _enviar,
            child: Icon(Icons.edit)),
        bottomNavigationBar: BottomAppBar(
          elevation: 20.0,
          color: Colors.blue,
          child: ButtonBar(),
        ));
  }
}