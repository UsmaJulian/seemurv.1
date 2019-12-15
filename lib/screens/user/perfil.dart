import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:seemur_v1/auth/auth.dart';
import 'package:seemur_v1/components/widgets/clients_body.dart';
import 'package:seemur_v1/components/widgets/navigatorbar.dart';
import 'package:seemur_v1/login_admin/root_page.dart';
import 'package:seemur_v1/screens/notificaciones_page.dart';

class PerfilPage extends StatefulWidget {
  PerfilPage({this.auth, this.datos});

  final BaseAuth auth;
  final datos;

  @override
  _PerfilPageState createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilPage> {
  String usuario = 'Usuario'; //user
  String usuarioEmail = 'Email'; //userEmail
  String id;
  AuthStatus authStatus = AuthStatus.notSignIn;
  int _widgetIndex = 0;
  File _image;
  String imageurl = '';

  void signOut() async {
    setState(() {
      authStatus = AuthStatus.notSignIn;
    });
  }

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

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      image = image;
      print('Image Path $_image');
    });
  }

  Future uploadPic(
    BuildContext context,
  ) async {
    String fileName = basename(_image.path);
    StorageReference firebaseStorageRef =
        FirebaseStorage.instance.ref().child(fileName);
    StorageUploadTask uploadTask = firebaseStorageRef.putFile(_image);
    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
    String imagenurl = (await firebaseStorageRef.getDownloadURL()).toString();
    print(imagenurl);

    setState(() {
      print("imagen de perfil actualizada");
      Scaffold.of(context).showSnackBar(
          SnackBar(content: Text('Imagen de perfil actualizada')));
    });
    setState(() {
      imageurl = imagenurl;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              IconData(0xF3E1, fontFamily: 'CupertinoIcons'),
              color: Colors.black,
              size: 30,
            ),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => NotificacionesPage()));
            },
          )
        ],
      ),
      body: Stack(
        children: <Widget>[
          SingleChildScrollView(
            child: Center(
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Builder(
                        builder: (context) => Padding(
                          padding: const EdgeInsets.only(
                            left: 40,
                          ),
                          child: Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                SizedBox(
                                  height: 10.0,
                                ),
                                Row(
                                  children: <Widget>[
                                    SizedBox(
                                      width: 100,
                                      height: 100,
                                      child: StreamBuilder(
                                          stream: Firestore.instance
                                              .collection('usuarios')
                                              .snapshots(),
                                          builder: (BuildContext context,
                                              AsyncSnapshot snapshot) {
                                            if (!snapshot.hasData) {
                                              return Text('Cargando');
                                            } else {
                                              return new ListView.builder(
                                                  shrinkWrap: true,
                                                  itemCount: snapshot
                                                      .data.documents.length,
                                                  itemBuilder:
                                                      (context, index) {
                                                    DocumentSnapshot ds =
                                                        snapshot.data
                                                            .documents[index];
                                                    return Container(
                                                      width: 100,
                                                      height: 100,
                                                      decoration:
                                                          new BoxDecoration(
                                                              color: Color(
                                                                  0xffd8d8d8),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          6)),
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            new BorderRadius
                                                                .circular(6.0),
                                                        // child: FadeInImage
                                                        //     .assetNetwork(
                                                        //   fit: BoxFit.fill,
                                                        //  // placeholder:
                                                        //      // ('assets/images/Contenedor de imagenes (375 x249).jpg'),
                                                        //  // image: ds['imagen'].toString(),
                                                        // ),
                                                      ),
                                                    );
                                                  });
                                            }
                                          }),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 60.0),
                                      child: IconButton(
                                        icon: Icon(
                                          CupertinoIcons.switch_camera,
                                          size: 30.0,
                                        ),
                                        onPressed: () {
                                          getImage();
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Row(
                                  children: <Widget>[
                                    RaisedButton(
                                      color: Colors.transparent,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              new BorderRadius.circular(22.0)),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      elevation: 0,
                                      child: Container(
                                        height: 32,
                                        width: 88,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              width: 0,
                                              style: BorderStyle.none),
                                          borderRadius: BorderRadius.horizontal(
                                              left: Radius.circular(22),
                                              right: Radius.circular(22)),
                                          gradient: LinearGradient(
                                            colors: [
                                              new Color(0xFFFFE231),
                                              new Color(0xFFF5AF00)
                                            ],
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                          ),
                                        ),
                                        child: Center(
                                          child: Text(
                                            'Cancelar',
                                            style: new TextStyle(
                                              color: Colors.black,
                                              fontFamily: 'HankenGrotesk',
                                              fontSize: 12.0,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 65.0,
                                    ),
                                    RaisedButton(
                                      color: Colors.transparent,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              new BorderRadius.circular(22.0)),
                                      onPressed: () => [
                                        uploadPic(
                                          context,
                                        ),
                                        subirImagen(imageurl),
                                      ],
                                      elevation: 0,
                                      child: Container(
                                        height: 32,
                                        width: 88,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              width: 0,
                                              style: BorderStyle.none),
                                          borderRadius: BorderRadius.horizontal(
                                              left: Radius.circular(22),
                                              right: Radius.circular(22)),
                                          gradient: LinearGradient(
                                            colors: [
                                              new Color(0xFFFFE231),
                                              new Color(0xFFF5AF00)
                                            ],
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                          ),
                                        ),
                                        child: Center(
                                          child: Text('Enviar',
                                              style: new TextStyle(
                                                color: Colors.black,
                                                fontFamily: 'HankenGrotesk',
                                                fontSize: 12.0,
                                                fontWeight: FontWeight.w700,
                                              )),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 24.0),
                    child: Text('Hola,' + '$usuario',
                        style: TextStyle(
                          fontFamily: 'HankenGrotesk',
                          color: Color(0xff000000),
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          fontStyle: FontStyle.normal,
                          letterSpacing: -0.1000000014901161,
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text("¿Qué tal tu día?",
                        style: TextStyle(
                          fontFamily: 'OpenSans',
                          color: Color(0xff3d3d3d),
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.normal,
                          letterSpacing: 0,
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 58.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        botonvisitados(),
                        botonfavoritos(context),
                        botonresenas(),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 32.0,
                  ),
                  IndexedStack(
                    index: _widgetIndex,
                    children: <Widget>[
                      Container(
                        //visitados
                        width: 375,
                        height: 446,
                        decoration: new BoxDecoration(
                            color: Color(0xfff6f7fa),
                            borderRadius: BorderRadius.circular(8)),
                        child: FutureBuilder(
                          future: Firestore.instance
                              .collection('usuarios')
                              .document(id)
                              .collection('visitados')
                              .getDocuments(),
                          builder:
                              (BuildContext context, AsyncSnapshot snapshot) {
                            if (!snapshot.hasData) {
                              Text('Loading');
                            } else {
                              return ListView.builder(
                                addAutomaticKeepAlives: true,
                                itemCount: snapshot.data.documents.length,
                                itemBuilder: (BuildContext context, index) {
                                  return Row(
                                    children: <Widget>[
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 16.0),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          child: FadeInImage.assetNetwork(
                                            width: 46,
                                            height: 46,
                                            fit: BoxFit.cover,
                                            placeholder:
                                            ('assets/images/Contenedordeimagenes.jpg'),
                                            image: (snapshot
                                                .data.documents[index]['logos']
                                                .toString()),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.6,
                                        height: 72.0,
                                        child: ListTile(
                                          dense: true,
                                          onTap: () {
                                            var datasnp = snapshot
                                                .data.documents[index].data;
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ClientBody(
                                                          datos: datasnp)),
                                            );
                                          },
                                          title: Container(
                                            child: Text(
                                              snapshot.data.documents[index]
                                                  ['taskname'],
                                              style: TextStyle(
                                                fontFamily: 'HankenGrotesk',
                                                color: Color(0xff000000),
                                                fontSize: 15,
                                                fontWeight: FontWeight.w700,
                                                fontStyle: FontStyle.normal,
                                                letterSpacing: -0.5,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              );
                            }
                            return Container();
                          },
                        ),
                      ),
                      Container(
                        //favoritos
                        width: 375,
                        height: 446,
                        decoration: new BoxDecoration(
                            color: Color(0xfff6f7fa),
                            borderRadius: BorderRadius.circular(8)),
                        child: FutureBuilder(
                          future: Firestore.instance
                              .collection('usuarios')
                              .document(id)
                              .collection('favoritos')
                              .getDocuments(),
                          builder:
                              (BuildContext context, AsyncSnapshot snapshot) {
                            if (!snapshot.hasData) {
                              Text('Loading');
                            } else {
                              return ListView.builder(
                                addAutomaticKeepAlives: true,
                                itemCount: snapshot.data.documents.length,
                                itemBuilder: (BuildContext context, index) {
                                  return Row(
                                    children: <Widget>[
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 16.0),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          child: FadeInImage.assetNetwork(
                                            width: 46,
                                            height: 46,
                                            fit: BoxFit.cover,
                                            placeholder:
                                            ('assets/images/Contenedordeimagenes.jpg'),
                                            image: (snapshot
                                                .data.documents[index]['logos']
                                                .toString()),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.6,
                                        height: 72.0,
                                        child: ListTile(
                                          dense: true,
                                          onTap: () {
                                            var datasnp = snapshot
                                                .data.documents[index].data;
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ClientBody(
                                                          datos: datasnp)),
                                            );
                                          },
                                          title: Container(
                                            child: Text(
                                              snapshot.data.documents[index]
                                                  ['taskname'],
                                              style: TextStyle(
                                                fontFamily: 'HankenGrotesk',
                                                color: Color(0xff000000),
                                                fontSize: 15,
                                                fontWeight: FontWeight.w700,
                                                fontStyle: FontStyle.normal,
                                                letterSpacing: -0.5,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              );
                            }
                            return Container();
                          },
                        ),
                      ),
                      Container(
                        //reseñas
                        width: 375,
                        height: 446,
                        decoration: new BoxDecoration(
                            color: Color(0xfff6f7fa),
                            borderRadius: BorderRadius.circular(8)),
                        child: FutureBuilder(
                          future: Firestore.instance
                              .collection('usuarios')
                              .document(id)
                              .collection('calificar')
                              .getDocuments(),
                          builder:
                              (BuildContext context, AsyncSnapshot snapshot) {
                            if (!snapshot.hasData) {
                              Text('Loading');
                            } else {
                              return ListView.builder(
                                addAutomaticKeepAlives: true,
                                itemCount: snapshot.data.documents.length,
                                itemBuilder: (BuildContext context, index) {
                                  return Row(
                                    children: <Widget>[
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 16.0),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          child: FadeInImage.assetNetwork(
                                            width: 46,
                                            height: 46,
                                            fit: BoxFit.cover,
                                            placeholder:
                                            ('assets/images/Contenedordeimagenes.jpg'),
                                            image: (snapshot
                                                .data.documents[index]['logos']
                                                .toString()),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.6,
                                        height: 72.0,
                                        child: ListTile(
                                          dense: true,
                                          onTap: () {
                                            var datasnp = snapshot
                                                .data.documents[index].data;
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ClientBody(
                                                          datos: datasnp)),
                                            );
                                          },
                                          title: Container(
                                            child: Text(
                                              snapshot.data.documents[index]
                                                  ['taskname'],
                                              style: TextStyle(
                                                fontFamily: 'HankenGrotesk',
                                                color: Color(0xff000000),
                                                fontSize: 15,
                                                fontWeight: FontWeight.w700,
                                                fontStyle: FontStyle.normal,
                                                letterSpacing: -0.5,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              );
                            }
                            return Container();
                          },
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 70,
              child: NavigatorBar(),
            ),
          ),
        ],
      ),
    );
  }

  botonresenas() {
    return Container(
      height: 32,
      width: 88,
      decoration: BoxDecoration(
        border: Border.all(width: 0, style: BorderStyle.none),
        borderRadius: BorderRadius.horizontal(
            left: Radius.circular(22), right: Radius.circular(22)),
        gradient: LinearGradient(
          colors: [new Color(0xFFFFE231), new Color(0xFFF5AF00)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: FlatButton(
        child: Text('Reseñas',
            style: new TextStyle(
              color: Colors.black,
              fontFamily: 'HankenGrotesk',
              fontSize: 12.0,
              fontWeight: FontWeight.w700,
            )),
        onPressed: () {
          _widgetIndex == 2 ? null : setState(() => _widgetIndex = 2);
          // Navigator.push(
          //     context,
          //     new MaterialPageRoute(
          //         builder: (context) => ResenasPage(auth: Auth())));
        },
      ),
    );
  }

  botonfavoritos(BuildContext context) {
    return Container(
      height: 32,
      width: 88,
      decoration: BoxDecoration(
        border: Border.all(width: 0, style: BorderStyle.none),
        borderRadius: BorderRadius.horizontal(
            left: Radius.circular(22), right: Radius.circular(22)),
        gradient: LinearGradient(
          colors: [new Color(0xFFFFE231), new Color(0xFFF5AF00)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: FlatButton(
        child: Text('Favoritos',
            style: new TextStyle(
              color: Colors.black,
              fontFamily: 'HankenGrotesk',
              fontSize: 12.0,
              fontWeight: FontWeight.w700,
            )),
        onPressed: () {
          _widgetIndex == 1 ? null : setState(() => _widgetIndex = 1);
          // Navigator.push(
          //     context,
          //     new MaterialPageRoute(
          //         builder: (context) => LugaresFavoritosPage(auth: Auth())));
        },
      ),
    );
  }

  botonvisitados() {
    return Container(
      height: 32,
      width: 88,
      decoration: BoxDecoration(
        border: Border.all(width: 0, style: BorderStyle.none),
        borderRadius: BorderRadius.horizontal(
            left: Radius.circular(22), right: Radius.circular(22)),
        gradient: LinearGradient(
          colors: [new Color(0xFFFFE231), new Color(0xFFF5AF00)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: FlatButton(
        child: Text('Visitados',
            style: new TextStyle(
              color: Colors.black,
              fontFamily: 'HankenGrotesk',
              fontSize: 12.0,
              fontWeight: FontWeight.w700,
            )),
        onPressed: () {
          _widgetIndex == 0 ? null : setState(() => _widgetIndex = 0);
          // Navigator.push(
          //     context,
          //     new MaterialPageRoute(
          //         builder: (context) => LugaresVistadosPage(auth: Auth())));
        },
      ),
    );
  }

  subirImagen(String imageurl) {
    setState(() {
      Firestore.instance
          .collection('usuarios')
          .document(id)
          .updateData({'imagen': imageurl.toString()});
    });
  }
}
