//create stf with the name ViewClient
import 'dart:io';
import 'package:image_picker/image_picker.dart' as img;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:path_provider/path_provider.dart';
import 'package:seemur_v1/auth/auth.dart';
import 'package:seemur_v1/models/client_model.dart';

class ViewClient extends StatefulWidget {
  ViewClient({this.client, this.idClient, this.uid});
  final String idClient;
  final String uid;
  final Client client;
  @override
  _ViewClientState createState() => _ViewClientState();
}

enum SelectSource { camara, galeria }

class _ViewClientState extends State<ViewClient> {
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
      shape: BoxShape.rectangle,
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

    print('uid cliente : ' + widget.idClient);
    super.initState();
  }

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
      print('imagen');
      opcion == SelectSource.camara
          ? taskclientimage = await img.ImagePicker.pickImage(
              source: img.ImageSource.camera) //source: ImageSource.camera)
          : taskclientimage =
              await img.ImagePicker.pickImage(source: img.ImageSource.gallery);

      setState(() {
        _taskclientimage = taskclientimage;
        box = BoxDecoration(
            border: Border.all(width: 1.0, color: Colors.black),
            shape: BoxShape.rectangle,
            image: DecorationImage(fit: BoxFit.fill, image: FileImage(_taskclientimage)));
      });
    } else {
      print('descarga la imagen');
      _downloadFile(url, widget.client.taskname).then((onValue) {
        _taskclientimage = onValue;
        setState(() {
          box = BoxDecoration(
              borderRadius: BorderRadius.circular(30.0),
              color: Colors.white,
              image:
                  DecorationImage(fit: BoxFit.fill, image: FileImage(_taskclientimage)),
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.black,
                    blurRadius: 10.0,
                    spreadRadius: 2.0,
                    offset: Offset(2.0, 10.0))
              ]);
        });
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('View Client'),
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
                          margin: EdgeInsets.only(top: 10),
                          height: 250,
                          width: 330,
                          decoration: box,
                        )
                      ]),
                  Padding(
                    padding: EdgeInsets.only(top: 10),
                  ),
                  TextFormField(
                    enabled: false,
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
                    maxLines: 10,
                    enabled: false,
                    keyboardType: TextInputType.text,
                    initialValue: _tasklocation,
                    decoration: InputDecoration(
                      labelText: 'Ubicación',
                    ),
                    validator: (value) =>
                        value.isEmpty ? 'El campo Ubicación esta vacio' : null,
                    onSaved: (value) => _tasklocation = value.trim(),
                  ),
                  TextFormField(
                    maxLines: 10,
                    enabled: false,
                    keyboardType: TextInputType.text,
                    initialValue: _taskdescription,
                    decoration: InputDecoration(
                      labelText: 'Descripción',
                    ),
                    validator: (value) =>
                        value.isEmpty ? 'El campo Descripción esta vacio' : null,
                    onSaved: (value) => _taskdescription = value.trim(),
                  ),
                  TextFormField(
                    maxLines: 10,
                    enabled: false,
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
                    maxLines: 10,
                    enabled: false,
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
                    maxLines: 10,
                    enabled: false,
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
    );
  }
}