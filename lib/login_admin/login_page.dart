import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:seemur_v1/auth/auth.dart';
import 'package:seemur_v1/login_admin/menu_page.dart';
import 'package:seemur_v1/models/user_model.dart';
import 'package:seemur_v1/screens/cambiar_contrase%C3%B1a.dart';
import 'package:seemur_v1/screens/terminos_condiciones.dart';

class CommonThings {
  static Size size;
}

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
  final formKey = GlobalKey<FormState>();
  //Declaramos las variables
  String _email;
  String _password;
  String _nombre;
  String _telefono;
  String _itemCiudad;
  String _direccion;
  String _urlFoto = '';
  String usuario;

  bool _obscureText = true;
  FormType _formType = FormType.login;
  List<DropdownMenuItem<String>> _ciudadItems; //list city from Firestore
  bool _isChecked = false;
  void onChanged(value) {
    setState(() {
      _isChecked = value;
    });
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      _ciudadItems = getCiudadItems();
      _itemCiudad = _ciudadItems[0].value;
    });
  }

  getData() async {
    return await Firestore.instance.collection('ciudades').getDocuments();
  }

  //Dropdownlist from firestore
  List<DropdownMenuItem<String>> getCiudadItems() {
    List<DropdownMenuItem<String>> items = List();
    QuerySnapshot dataCiudades;
    getData().then((data) {
      dataCiudades = data;
      dataCiudades.documents.forEach((obj) {
        print('${obj.documentID} ${obj['nombre']}');
        items.add(DropdownMenuItem(
          value: obj.documentID,
          child: Text(obj['nombre']),
        ));
      });
    }).catchError((error) => print('hay un error.....' + error));

    items.add(DropdownMenuItem(
      value: '0',
      child: Text('- Seleccione -'),
    ));

    return items;
  }

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
        MenuPage(auth: widget.auth); //return menu_page.dart
        Navigator.of(context).pop();
      } catch (e) {
        print('Error .... $e');
        AlertDialog alerta = new AlertDialog(
          content: Text('Error en la Autenticación'),
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
            //model/user_model.dart instance usuario
            nombre: _nombre,
            ciudad: _itemCiudad,
            direccion: _direccion,
            email: _email,
            password: _password,
            telefono: _telefono,
            foto: _urlFoto);
        String userId = await widget.auth.signUpEmailPassword(usuario);
        print('Usuario logueado : $userId'); //ok
        widget.onSignIn();
        MenuPage(auth: widget.auth); //menu_page.dart
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
    CommonThings.size = MediaQuery.of(context).size;
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
          child: Container(
              padding: EdgeInsets.all(16.0),
              child: Center(
                  child: Form(
                key: formKey,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment
                        .stretch, //ajusta los widgets a lso extremos
                    children:
                        // [
                        //       Padding(padding: EdgeInsets.only(top: 15.0)),
                        //       Text(
                        //         'Recetas Mundiales \n Mis recetas',
                        //         textAlign: TextAlign.center,
                        //         style: TextStyle(
                        //           fontSize: 17.0,
                        //         ),
                        //       ),
                        //       Padding(padding: EdgeInsets.only(bottom: 15.0)),
                        //     ] +
                        buildInputs() + buildSubmitButtons()),
              )))),
    );
  }

  List<Widget> buildInputs() {
    if (_formType == FormType.login) {
      return [
        //list or array
        Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 50, right: 105, left: 0),
              child: Container(
                  width: 245,
                  height: 28,
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
          padding: const EdgeInsets.only(top: 22, right: 55),
          child: Column(
            children: <Widget>[
              Container(
                width: 294,
                height: 14,
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
            top: 12,
            left: 15,
            right: 15,
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
          padding: const EdgeInsets.only(top: 24, left: 15, right: 30),
          child: Container(
            width: 294,
            height: 14,
            child: Text('Contraseña (Mínimo 6 caractéres)',
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
            top: 12,
            left: 15,
            right: 15,
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
                        padding: const EdgeInsets.only(right: 20),
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
          padding: const EdgeInsets.only(top: 16.0, left: 160, right: 0),
          child: Container(
            width: 295,
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
                padding: const EdgeInsets.only(top: 0, right: 95, left: 0),
                child: Container(
                    width: 245,
                    height: 28,
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
          padding: const EdgeInsets.only(top: 32, right: 50),
          child: Column(
            children: <Widget>[
              Container(
                width: 294,
                height: 14,
                child: Text('Nombre',
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
          padding: const EdgeInsets.only(top: 12, left: 15, right: 15),
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
                  labelText: 'Nombre',
                ),
                validator: (value) =>
                    value.isEmpty ? 'El campo Nombre esta vacio' : null,
                onSaved: (value) => _nombre = value.trim(),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 32, right: 50),
          child: Column(
            children: <Widget>[
              Container(
                width: 294,
                height: 14,
                child: Text('Celular',
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
            top: 12,
            left: 15,
            right: 15,
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
                  labelText: 'Celular',
                ),
                validator: (value) =>
                    value.isEmpty ? 'El campo Telefono esta vacio' : null,
                onSaved: (value) => _telefono = value.trim(),
              ),
            ),
          ),
        ),

        DropdownButtonFormField(
          validator: (value) =>
              value == '0' ? 'Debe seleccionar una ciudad' : null,
          decoration: InputDecoration(
              labelText: 'Ciudad', icon: Icon(FontAwesomeIcons.city)),
          value: _itemCiudad,
          items: _ciudadItems,
          onChanged: (value) {
            setState(() {
              _itemCiudad = value;
            });
          }, //seleccionarCiudadItem,
          onSaved: (value) => _itemCiudad = value,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 32, right: 50),
          child: Column(
            children: <Widget>[
              Container(
                width: 294,
                height: 14,
                child: Text('Dirección',
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
          padding: const EdgeInsets.only(top: 32, right: 40),
          child: Column(
            children: <Widget>[
              Container(
                width: 294,
                height: 14,
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
          padding: const EdgeInsets.only(top: 12, left: 15, right: 15),
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(width: 0, style: BorderStyle.solid),
                borderRadius: BorderRadius.horizontal(
                    left: Radius.circular(8), right: Radius.circular(8)),
                color: Color.fromRGBO(246, 247, 250, 100)),
            child: Padding(
              padding: const EdgeInsets.only(left: 17),
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
          padding: const EdgeInsets.only(top: 24, left: 15, right: 40),
          child: Container(
            width: 294,
            height: 14,
            child: Text('Contraseña (Mínimo 6 caractéres)',
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
              top: 12,
              left: 15,
              right: 15,
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
            top: 16.0,
            left: 10,
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
                width: 295,
                height: 20,
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
                    // Navigator.push(
                    //     context,
                    //     new MaterialPageRoute(
                    //         builder: (context) =>
                    //             new TerminosCondicionesPage())
                    //             );
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
          padding:
              const EdgeInsets.only(top: 32, bottom: 0, left: 30, right: 30),
          child: Container(
            width: 315,
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
            top: 209,
            bottom: 75,
            left: 50,
          ),
          child: Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 75.0),
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
                padding: const EdgeInsets.only(left: 0, right: 20, bottom: 75),
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
      ];
    } else {
      return [
        Padding(
          padding:
              const EdgeInsets.only(top: 32, bottom: 0, left: 30, right: 30),
          child: Container(
            width: 315,
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
            top: 39,
            bottom: 75,
            left: 65,
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
                padding: const EdgeInsets.only(right: 65),
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
