import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:seemur_v1/auth/auth.dart';
import 'package:seemur_v1/components/widgets/clients_body.dart';
import 'package:seemur_v1/components/widgets/navigatorbar.dart';
import 'package:seemur_v1/login_admin/root_page.dart';
import 'package:seemur_v1/models/user_model.dart';
import 'package:seemur_v1/screens/notificaciones_page.dart';
import 'package:seemur_v1/services/databaseService.dart';
import 'package:seemur_v1/services/storageService.dart';

class PerfilPage extends StatefulWidget {
  PerfilPage({this.auth, this.datos, this.usuario});

  final BaseAuth auth;
  final datos;
  final Usuario usuario;

  @override
  _PerfilPageState createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilPage> {
  String usuarioName = 'Usuario'; //user
  String usuarioEmail = 'Email'; //userEmail
  String id;
  AuthStatus authStatus = AuthStatus.notSignIn;
  int _widgetIndex = 0;

  File _profileImage;

  _submit() async {
	  // Update user in database
	  String _profileImageUrl = '';
	
	  if (_profileImage == null) {
		  _profileImageUrl = widget.usuario.profileImageUrl;
	  } else {
		  _profileImageUrl = await StorageService.uploadUserProfileImage(
			  widget.usuario.profileImageUrl,
			  _profileImage,
		  );
	  }
	
	  Usuario usuario = Usuario(
		  uid: widget.usuario.uid,
		  profileImageUrl: _profileImageUrl,
	  );
	  // Database update
	  DatabaseService.updateUsuario(usuario);
	
	  Navigator.pop(context);
  }

  _handleImageFromGallery() async {
    File imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);

    if (imageFile != null) {
      setState(() {
        _profileImage = imageFile;
      });
      _submit();
    }
  }

  _displayProfileImage() {
    // No new profile image
    if (_profileImage == null) {
      // No existing profile image
      if (widget.usuario.profileImageUrl.isEmpty) {
        // Display placeholder
        return AssetImage('assets/images/Contenedordeimagenes.jpg');
      } else {
        // User profile image exists
        return CachedNetworkImageProvider(widget.usuario.profileImageUrl);
      }
    } else {
      // New profile image
      return FileImage(_profileImage);
    }
  }

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
        usuarioName = onValue.displayName;
        usuarioEmail = onValue.email;
        id = onValue.uid;

        print('ID $id');
      });
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
	            CupertinoIcons.bell,
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
                  InkWell(
                    onTap: () {
                      _handleImageFromGallery();
                    },
                    child: CircleAvatar(
                      radius: 60.0,
                      backgroundColor: Colors.grey,
                      backgroundImage: _displayProfileImage(),
                    ),
                  ),
	                // RaisedButton(
	                //     onPressed: () {
	                //       _submit();
	                //     },
	                //     child: Text('subir')),
                  Padding(
	                  padding: const EdgeInsets.only(top: 34.0),
                    child: Text('Hola,' + '$usuarioName',
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
	                  padding: const EdgeInsets.only(top: 14.0),
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
	                      height: 496,
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
                              .collection('calificar')
                              .where('uid', isEqualTo: id)
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
	            child:
	            NavigatorBar(navCallback: (i) => print("Navigating to $i")),
            ),
          ),
        ],
      ),
    );
  }

  Widget botonresenas() {
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

  Widget botonfavoritos(BuildContext context) {
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

  Widget botonvisitados() {
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
}
