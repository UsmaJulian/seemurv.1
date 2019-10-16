import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:seemur_v1/auth/auth.dart';
import 'package:seemur_v1/models/user_model.dart';

class EditarDatosPage extends StatefulWidget {
  EditarDatosPage(
      {this.auth,
      this.nombre,
      this.email,
      this.telefono,
      this.usuario,
      this.id,
      this.user});
  final FirebaseUser user;
  final BaseAuth auth;
  final String nombre;
  final String email;
  final String telefono;
  final Usuario usuario;
  final String id;
  @override
  _EditarDatosPageState createState() => _EditarDatosPageState();
}

class _EditarDatosPageState extends State<EditarDatosPage> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController _ucontroller = TextEditingController();
  final TextEditingController _econtroller = TextEditingController();
  final TextEditingController _tcontroller = TextEditingController();
  String _nombre; //user
  String _email; //userEmail
  String id;
  String user;
  String _usuario;
  String _telefono;
  bool _isInAsyncCall = false;
  Auth auth = Auth();
  @override
  void initState() {
    super.initState();
    widget.auth.infoUser().then((onValue) {
      setState(() {
        this._nombre = onValue.displayName;
        this._email = onValue.email;
        this.user = onValue.uid;
        this._telefono = onValue.phoneNumber;
        print('ID $id');
        print('ID $_nombre');
      });
    });
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
        _isInAsyncCall = false;
      });
      auth.currentUser().then((onValue) {
        setState(() {
          _nombre = onValue;
          _email = onValue;
        });
        if (_nombre != null) {
          setState(() {
            Firestore.instance
                .collection('usuarios')
                .document(user)
                .updateData({
                  'nombre': _nombre,
                  'email': _email,
                  'telefono': _telefono,
                })
                .then((value) => Navigator.of(context).pop())
                .catchError(
                    (onError) => print('Error al editar el cliente en la bd'));
            //_isInAsyncCall = false;
          });
        }
      }).catchError((onError) => _isInAsyncCall = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    print('ID2 $_nombre');
    print('ID2 $_email');
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: new IconButton(
            icon: new Icon(
              CupertinoIcons.back,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
          backgroundColor: Color.fromRGBO(22, 32, 44, 1),
          title: Center(
              child: Padding(
            padding: const EdgeInsets.only(right: 50.0),
            child: Text('Editar datos personales ',
                style: TextStyle(
                  fontFamily: 'HankenGrotesk',
                  color: Color(0xffffffff),
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  fontStyle: FontStyle.normal,
                  letterSpacing: -0.5,
                )),
          )),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: <Widget>[
                Text("Datos Personales",
                    style: TextStyle(
                      fontFamily: 'HankenGrotesk',
                      color: Color(0xff000000),
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      fontStyle: FontStyle.normal,
                      letterSpacing: -0.1000000014901161,
                    )),
                Text("Nombre y apellidos",
                    style: TextStyle(
                      fontFamily: 'HankenGrotesk',
                      color: Color(0xff000000),
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      fontStyle: FontStyle.normal,
                      letterSpacing: -0.1000000014901161,
                    )),
                TextFormField(
                  controller: _ucontroller,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: _nombre,
                  ),
                  onSaved: (value) => _nombre = value.trim(),
                ),
                Text("Correo electrónico",
                    style: TextStyle(
                      fontFamily: 'HankenGrotesk',
                      color: Color(0xff000000),
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      fontStyle: FontStyle.normal,
                      letterSpacing: -0.1000000014901161,
                    )),
                TextFormField(
                  controller: _econtroller,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: _email,
                  ),
                  onSaved: (value) => _email = value.trim(),
                ),
                Text("Teléfono",
                    style: TextStyle(
                      fontFamily: 'HankenGrotesk',
                      color: Color(0xff000000),
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      fontStyle: FontStyle.normal,
                      letterSpacing: -0.1000000014901161,
                    )),
                TextFormField(
                  controller: _tcontroller,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: _telefono,
                  ),
                  validator: (value) =>
                      value.isEmpty ? 'El campo Email esta vacio' : null,
                  onSaved: (value) => _telefono = value.trim(),
                ),
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: RaisedButton(
                      color: Colors.transparent,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(22.0)),
                      onPressed: _enviar,
                      child: Container(
                        width: 181.0,
                        height: 44.0,
                        decoration: BoxDecoration(
                          border: Border.all(width: 0, style: BorderStyle.none),
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
                          child: Text('Guardar',
                              style: TextStyle(
                                fontFamily: 'HankenGrotesk',
                                color: Color(0xff16202c),
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                fontStyle: FontStyle.normal,
                              )),
                        ),
                      )),
                ),
              ],
            ),
          ),
        ));
  }

  void dispose() {
    _ucontroller.dispose();
    _econtroller.dispose();
    _tcontroller.dispose();

    super.dispose();
  }
}
