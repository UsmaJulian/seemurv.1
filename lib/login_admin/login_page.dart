import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:http/http.dart' as http;
import 'package:seemur_v1/auth/auth.dart';
import 'package:seemur_v1/models/user_model.dart';
import 'package:seemur_v1/screens/cambiar_contraseña.dart';
import 'package:seemur_v1/screens/terminos_condiciones.dart';

class LoginPage extends StatefulWidget {
  LoginPage({this.auth, this.onSignIn});
  
  final BaseAuth auth;
  final VoidCallback onSignIn;
  
  @override
  _LoginPageState createState() => _LoginPageState();
}

enum FormType { login, registro }
enum SelectSource { camara, galeria }

class _LoginPageState extends State<LoginPage> {
  FirebaseUser currentUser;
  final formKey = GlobalKey<FormState>();
  
  //Declaramos las variables
  String _email;
  String _password;
  String _nombre;
  String _telefono;
  String _urlFoto = '';
  String usuario;
  bool isLoggedIn = false;
  
  bool _obscureText = true;
  FormType _formType = FormType.login;
  
  Future<FirebaseUser> facebookLogin() async {
    // fbLogin.loginBehavior = FacebookLoginBehavior.webViewOnly;
    // if you remove above comment then facebook login will take username and pasword for login in Webview
    try {
      final FacebookLoginResult facebookLoginResult =
      await FacebookLogin().logIn(['email']);
      if (facebookLoginResult.status == FacebookLoginStatus.loggedIn) {
        FacebookAccessToken facebookAccessToken =
            facebookLoginResult.accessToken;
        AuthCredential credential = FacebookAuthProvider.getCredential(
            accessToken: facebookAccessToken.token);
        FirebaseUser user =
            (await FirebaseAuth.instance.signInWithCredential(credential)).user;
        print("signed in" + user.displayName);
        getUserInfo(facebookLoginResult);
        return user;
      }
    } catch (e) {
      print(e);
    }
    return currentUser;
  }
  
  getUserInfo(facebookLoginResult) async {
    final token = facebookLoginResult.accessToken.token;
    final graphResponse = await http.get(
        'https://graph.facebook.com/v2.12/me?fields=name,picture.width(800).height(800),first_name,last_name,email&access_token=${token}');
    final profile = json.decode(graphResponse.body);
    Firestore.instance
        .collection('usuarios')
        .document('${currentUser.uid}')
        .setData({
      'nombre': profile['name'], //name
      
      'email': profile['email'].toString(),
      'imagen': profile['picture']['data']['url'],
      "uid": currentUser.uid,
    });
    
    widget.onSignIn();
    
    Navigator.of(context).pop();
    return usuario;
  }
  
  void _logIn() {
    facebookLogin().then((response) {
      if (response != null) {
        currentUser = response;
        isLoggedIn = true;
        
        setState(() {});
      }
    });
  }
  
  bool _isChecked = false;
  
  void onChanged(value) {
    setState(() {
      _isChecked = value;
    });
  }
  
  //Facebooklogin
  
  bool _validarGuardar() {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }
  
  //we create a method validate and send
  void _validarEnviar() async {
    if (_validarGuardar()) {
      try {
        String userId =
        await widget.auth.signInEmailPassword(_email, _password);
        print('Usuario logueado : $userId '); //ok
        widget.onSignIn();
        
        Navigator.of(context).pop();
      } catch (e) {
        print('Error .... $e');
        AlertDialog alerta = new AlertDialog(
          content: Text('Error en la Autenticación Usuario no encontrado'),
          title: Text('Error'),
          actions: <Widget>[],
        );
        showDialog(context: context, child: alerta);
      }
    }
  }
  
  //Now create a method validate and register
  void _validarRegistrar() async {
    if (_validarGuardar()) {
      try {
        Usuario usuario = Usuario(
          nombre: _nombre,
          email: _email,
          password: _password,
          telefono: _telefono,
          profileImageUrl: _urlFoto,
        );
        String userId = await widget.auth.signUpEmailPassword(usuario);
        print('Usuario logueado : $userId'); //ok
        widget.onSignIn();
        
        Navigator.of(context).pop();
      } catch (e) {
        print('Error .... $e');
        AlertDialog alerta = new AlertDialog(
          content: Text('Error en el registro'),
          title: Text('Error'),
          actions: <Widget>[],
        );
        showDialog(context: context, child: alerta);
      }
    }
  }
  
  //method go register
  void _irRegistro() {
    setState(() {
      formKey.currentState.reset();
      _formType = FormType.registro;
    });
  }
  
  //method go Login
  void _irLogin() {
    setState(() {
      formKey.currentState.reset();
      _formType = FormType.login;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          tooltip: MaterialLocalizations.of(context).backButtonTooltip,
          onPressed: () {
            Navigator.maybePop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: SizedBox(
            child: Container(
                padding: EdgeInsets.all(8.0),
                child: Center(
                    child: Form(
                      key: formKey,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment
                              .stretch, //ajusta los widgets a lso extremos
                          children: buildInputs() + buildSubmitButtons()),
                    ))),
          )),
    );
  }
  
  List<Widget> buildInputs() {
    if (_formType == FormType.login) {
      return [
        //list or array
        Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 84.0, right: 90.0, left: 5.0),
              child: Container(
                  width: 245.0,
                  height: 28.0,
                  child: Text('Inicia sesión',
                      style: new TextStyle(
                        color: Colors.black,
                        fontFamily: 'HankenGrotesk',
                        fontSize: 24.0,
                        fontWeight: FontWeight.w700,
                      ))),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 16.0, right: 180.0),
          child: Column(
            children: <Widget>[
              Container(
                width: 147.0,
                height: 28.0,
                child: Text('Correo electrónico',
                    style: new TextStyle(
                      color: Colors.black,
                      fontFamily: 'HankenGrotesk',
                      fontSize: 14.0,
                      fontWeight: FontWeight.w700,
                    )),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            top: 6.0,
            left: 7.5,
            right: 7.5,
          ),
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(width: 0, style: BorderStyle.solid),
                borderRadius: BorderRadius.horizontal(
                    left: Radius.circular(8), right: Radius.circular(8)),
                color: Color.fromRGBO(246, 247, 250, 100)),
            child: Padding(
              padding: const EdgeInsets.only(left: 8.5),
              child: TextFormField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  labelText: 'Email',
                ),
                validator: (value) =>
                value.isEmpty ? 'El campo Email está vacio' : null,
                onSaved: (value) => _email = value.trim(),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
              top: 12.0, left: 7.5, right: 15.0, bottom: 6.0),
          child: Container(
            width: 294.0,
            height: 14.0,
            child: Text('Contraseña (Mínimo 8 caractéres)',
                style: new TextStyle(
                  color: Colors.black,
                  fontFamily: 'HankenGrotesk',
                  fontSize: 14.0,
                  fontWeight: FontWeight.w700,
                )),
          ),
        ),
        
        Padding(
          padding: const EdgeInsets.only(
            top: 12.0,
            left: 7.5,
            right: 7.5,
          ),
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(width: 0, style: BorderStyle.solid),
                borderRadius: BorderRadius.horizontal(
                    left: Radius.circular(8), right: Radius.circular(8)),
                color: Color.fromRGBO(246, 247, 250, 100)),
            child: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: TextFormField(
                keyboardType: TextInputType.text,
                obscureText: _obscureText,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    labelText: 'Contraseña',
                    suffixIcon: GestureDetector(
                      onTap: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Icon(
                          _obscureText
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                      ),
                    )),
                validator: (value) => value.isEmpty
                    ? 'El campo password debe tener\nal menos 6 caracteres'
                    : null,
                onSaved: (value) => _password = value.trim(),
              ),
            ),
          ),
        ),
        
        Padding(
          padding: const EdgeInsets.only(top: 16.0, left: 134.0, right: 0),
          child: Container(
            width: 147.5,
            height: 20,
            child: FlatButton(
              child: Text('¿Olvidaste tu contraseña?',
                  textAlign: TextAlign.right,
                  style: new TextStyle(
                    color: Colors.black,
                    fontFamily: 'HankenGrotesk',
                    fontSize: 14.0,
                    fontWeight: FontWeight.w700,
                  )),
              onPressed: () {
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) => RenewContrasena()));
              },
            ),
          ),
        ),
      ];
    } else {
      return [
        Container(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 0, right: 90, left: 0),
                child: Container(
                    width: 245.0,
                    height: 30.0,
                    child: Text('Crea una cuenta',
                        style: new TextStyle(
                          color: Colors.black,
                          fontFamily: 'HankenGrotesk',
                          fontSize: 24.0,
                          fontWeight: FontWeight.w700,
                        ))),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 32, right: 30),
          child: Column(
            children: <Widget>[
              Container(
                width: 294.0,
                height: 14.0,
                child: Text('Nombre y apellidos',
                    style: new TextStyle(
                      color: Colors.black,
                      fontFamily: 'HankenGrotesk',
                      fontSize: 14.0,
                      fontWeight: FontWeight.w700,
                    )),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 6.0, left: 7.5, right: 7.5),
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(width: 0, style: BorderStyle.solid),
                borderRadius: BorderRadius.horizontal(
                    left: Radius.circular(8), right: Radius.circular(8)),
                color: Color.fromRGBO(246, 247, 250, 100)),
            child: Padding(
              padding: const EdgeInsets.only(left: 17),
              child: TextFormField(
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  labelText: 'Nombre y apellidos',
                ),
                validator: (value) =>
                value.isEmpty ? 'El campo Nombre esta vacio' : null,
                onSaved: (value) => _nombre = value.trim(),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 16.0, right: 25.0),
          child: Column(
            children: <Widget>[
              Container(
                width: 294.0,
                height: 14.0,
                child: Text('Teléfono',
                    style: new TextStyle(
                      color: Colors.black,
                      fontFamily: 'HankenGrotesk',
                      fontSize: 14.0,
                      fontWeight: FontWeight.w700,
                    )),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            top: 6.0,
            left: 7.5,
            right: 7.5,
          ),
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(width: 0, style: BorderStyle.solid),
                borderRadius: BorderRadius.horizontal(
                    left: Radius.circular(8), right: Radius.circular(8)),
                color: Color.fromRGBO(246, 247, 250, 100)),
            child: Padding(
              padding: const EdgeInsets.only(left: 17),
              child: TextFormField(
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  labelText: '(+57)',
                ),
                validator: (value) =>
                value.isEmpty ? 'El campo Telefono esta vacio' : null,
                onSaved: (value) => _telefono = value.trim(),
              ),
            ),
          ),
        ),
        
        // Container(
        //   child: DropdownButtonFormField(
        //     validator: (value) =>
        //         value == '0' ? 'Debe seleccionar una ciudad' : null,
        //     decoration: InputDecoration(
        //       labelText: 'Ciudad',
        //     ),
        //     value: _itemCiudad,
        //     items: _ciudadItems,
        //     onChanged: (value) {
        //       setState(() {
        //         _itemCiudad = value;
        //       });
        //     }, //seleccionarCiudadItem,
        //     onSaved: (value) => _itemCiudad = value,
        //   ),
        // ),
        Padding(
          padding: const EdgeInsets.only(top: 16.0, right: 25.0),
          child: Column(
            children: <Widget>[
              // Container(
              //   width: 294.0,
              //   height: 14.0,
              //   child: Text('Dirección',
              //       style: new TextStyle(
              //         color: Colors.black,
              //         fontFamily: 'HankenGrotesk',
              //         fontSize: 14.0,
              //         fontWeight: FontWeight.w700,
              //       )),
              // ),
            ],
          ),
        ),
        // Padding(
        //   padding: const EdgeInsets.only(top: 12, left: 15, right: 15),
        //   child: Container(
        //     decoration: BoxDecoration(
        //         border: Border.all(width: 0, style: BorderStyle.solid),
        //         borderRadius: BorderRadius.horizontal(
        //             left: Radius.circular(8), right: Radius.circular(8)),
        //         color: Color.fromRGBO(246, 247, 250, 100)),
        //     child: Padding(
        //       padding: const EdgeInsets.only(left: 17),
        //       child: TextFormField(
        //           keyboardType: TextInputType.text,
        //           decoration: InputDecoration(
        //             border: InputBorder.none,
        //             labelText: 'Dirección',
        //           ),
        //           validator: (value) =>
        //               value.isEmpty ? 'El campo Direccion está vacio' : null,
        //           onSaved: (value) => _direccion = value.trim()),
        //     ),
        //   ),
        // ),
        Padding(
          padding: const EdgeInsets.only(top: 1.0, right: 30.0),
          child: Column(
            children: <Widget>[
              Container(
                width: 294.0,
                height: 14.0,
                child: Text('Correo electrónico',
                    style: new TextStyle(
                      color: Colors.black,
                      fontFamily: 'HankenGrotesk',
                      fontSize: 14.0,
                      fontWeight: FontWeight.w700,
                    )),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 6.0, left: 7.5, right: 7.5),
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(width: 0, style: BorderStyle.solid),
                borderRadius: BorderRadius.horizontal(
                    left: Radius.circular(8), right: Radius.circular(8)),
                color: Color.fromRGBO(246, 247, 250, 100)),
            child: Padding(
              padding: const EdgeInsets.only(left: 8.5),
              child: TextFormField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  labelText: 'Email',
                ),
                validator: (value) =>
                value.isEmpty ? 'El campo Email esta vacio' : null,
                onSaved: (value) => _email = value.trim(),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 12.0, left: 7.5, right: 20),
          child: Container(
            width: 294.0,
            height: 20.0,
            child: Text('Contraseña (Mínimo 8 caractéres)',
                style: new TextStyle(
                  color: Colors.black,
                  fontFamily: 'HankenGrotesk',
                  fontSize: 14.0,
                  fontWeight: FontWeight.w700,
                )),
          ),
        ),
        Container(
          child: Padding(
            padding: const EdgeInsets.only(
              top: 6.0,
              left: 7.5,
              right: 7.5,
            ),
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(width: 0, style: BorderStyle.solid),
                  borderRadius: BorderRadius.horizontal(
                      left: Radius.circular(8), right: Radius.circular(8)),
                  color: Color.fromRGBO(246, 247, 250, 100)),
              child: Padding(
                padding: const EdgeInsets.only(left: 8.5),
                child: TextFormField(
                  obscureText: _obscureText, //password
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      labelText: 'Contraseña',
                      suffixIcon: GestureDetector(
                        onTap: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                        child: Icon(
                          _obscureText
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                      )),
                  validator: (value) => value.isEmpty
                      ? 'El campo password debe tener\nal menos 6 caracteres'
                      : null,
                  onSaved: (value) => _password = value.trim(),
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            top: 8.0,
            left: 5.0,
          ),
          child: Row(
            children: <Widget>[
              Checkbox(
                value: _isChecked,
                onChanged: (bool value) {
                  onChanged(value);
                },
                activeColor: Color.fromRGBO(245, 175, 0, 100),
              ),
              Container(
                width: 290.0,
                height: 20.0,
                child: FlatButton(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text('Acepto ',
                          textAlign: TextAlign.left,
                          style: new TextStyle(
                            color: Colors.black,
                            fontFamily: 'HankenGrotesk',
                            fontSize: 14.0,
                            fontWeight: FontWeight.w700,
                          )),
                      Text('términos y condiciones',
                          textAlign: TextAlign.left,
                          style: new TextStyle(
                            color: Color.fromRGBO(225, 161, 0, 100),
                            fontFamily: 'HankenGrotesk',
                            fontSize: 14.0,
                            fontWeight: FontWeight.w700,
                          )),
                    ],
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (context) =>
                            new TerminosCondicionesPage()));
                  },
                ),
              ),
            ],
          ),
        ),
        //cerrar
      ];
    }
  }
  
  List<Widget> buildSubmitButtons() {
    if (_formType == FormType.login) {
      return [
        Padding(
          padding: const EdgeInsets.only(
              top: 16.0, bottom: 0, left: 15.0, right: 15.0),
          child: Container(
            width: 295.0,
            height: 44.0,
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
              onPressed: _validarEnviar,
              child: Text('Continuar',
                  style: new TextStyle(
                    color: Colors.black,
                    fontFamily: 'HankenGrotesk',
                    fontSize: 14.0,
                    fontWeight: FontWeight.w700,
                  )),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            top: 44.5,
            bottom: 17.5,
            left: 45.0,
          ),
          child: Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 17.5),
                child: Container(
                    child: Text('¿Aún no tienes cuenta?',
                        style: new TextStyle(
                          color: Colors.black,
                          fontFamily: 'HankenGrotesk',
                          fontSize: 14.0,
                          fontWeight: FontWeight.w700,
                        ))),
              ),
              Padding(
                padding:
                const EdgeInsets.only(left: 0, right: 10.0, bottom: 17.5),
                child: Container(
                  child: FlatButton(
                    onPressed: _irRegistro,
                    child: Text('Crea una ahora',
                        style: new TextStyle(
                          color: Color(0xfff5af00),
                          fontFamily: 'HankenGrotesk',
                          fontSize: 14.0,
                          fontWeight: FontWeight.w700,
                        )),
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding:
          const EdgeInsets.only(top: 0, bottom: 0, left: 15.0, right: 15.0),
          child: Container(
              width: 295.0,
              height: 44.0,
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
              child: isLoggedIn
                  ? null
                  : FacebookSignInButton(
                borderRadius: 22.0,
                text: 'Continuar con Facebook',
                onPressed: _logIn,
              )),
        ),
      ];
    } else {
      return [
        Padding(
          padding: const EdgeInsets.only(
              top: 16.0, bottom: 0, left: 15.0, right: 15.0),
          child: Container(
            width: 295.0,
            height: 44,
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
              onPressed: _validarRegistrar,
              child: Text('Crear cuenta',
                  style: new TextStyle(
                    color: Colors.black,
                    fontFamily: 'HankenGrotesk',
                    fontSize: 14.0,
                    fontWeight: FontWeight.w700,
                  )),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            top: 19.5,
            bottom: 37.5,
            left: 32.5,
          ),
          child: Row(
            children: <Widget>[
              Container(
                  child: Text('¿Ya tienes cuenta?',
                      style: new TextStyle(
                        color: Colors.black,
                        fontFamily: 'HankenGrotesk',
                        fontSize: 14.0,
                        fontWeight: FontWeight.w700,
                      ))),
              Padding(
                padding: const EdgeInsets.only(right: 32.5),
                child: Container(
                  child: FlatButton(
                    onPressed: _irLogin,
                    child: Text('Inicia Sesión',
                        style: new TextStyle(
                          color: Color(0xffe1a100),
                          fontFamily: 'HankenGrotesk',
                          fontSize: 14.0,
                          fontWeight: FontWeight.w700,
                        )),
                  ),
                ),
              ),
            ],
          ),
        ),
      ];
    }
  }
}
