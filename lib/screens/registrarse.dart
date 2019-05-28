import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:seemur_v1/screens/ingresar.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({
    Key key,
  }) : super(key: key);
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _email, _password;
  bool _isChecked = false;
  void onChanged(value) {
    setState(() {
      _isChecked = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
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
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 80, right: 90, left: 0),
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
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 12,
                        left: 40,
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                            border:
                                Border.all(width: 0, style: BorderStyle.solid),
                            borderRadius: BorderRadius.horizontal(
                                left: Radius.circular(8),
                                right: Radius.circular(8)),
                            color: Color.fromRGBO(246, 247, 250, 100)),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 17),
                          child: TextFormField(
                            validator: (input) {
                              if (input.isEmpty) {
                                return 'Provide an email';
                              }
                            },
                            decoration: InputDecoration(
                                border: InputBorder.none, labelText: 'Email'),
                            onSaved: (input) => _email = input,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 24, left: 0, right: 40),
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
                    left: 40,
                    right: 40,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(width: 0, style: BorderStyle.solid),
                        borderRadius: BorderRadius.horizontal(
                            left: Radius.circular(8),
                            right: Radius.circular(8)),
                        color: Color.fromRGBO(246, 247, 250, 100)),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 17),
                      child: TextFormField(
                        validator: (input) {
                          if (input.length < 6) {
                            return 'Longer password please';
                          }
                        },
                        decoration: InputDecoration(
                            border: InputBorder.none, labelText: 'Password'),
                        onSaved: (input) => _password = input,
                        obscureText: true,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0, left: 30),
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
                          children: <Widget>[
                            Text('Acepto ',
                                textAlign: TextAlign.left,
                                style: new TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'HankenGrotesk',
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w700,
                                )),
                                Text('términos y condiciones',textAlign: TextAlign.left,
                                style: new TextStyle(
                                  color: Color.fromRGBO(225, 161, 0, 100),
                                  fontFamily: 'HankenGrotesk',
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w700,
                                )),
                          ],
                        ),
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
              ),
              new Padding(
                padding:
                    EdgeInsets.only(top: 32, bottom: 0, left: 30, right: 30),
              ),
              Container(
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
                  onPressed: signUp,
                  child: Text('Crear cuenta',
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
                  top: 209,
                  bottom: 75,
                  left: 50,
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
                      padding: const EdgeInsets.only(left: 8.0, right: 54),
                      child: Container(
                        child: FlatButton(
                          onPressed: () {},
                          child: Text('Inicia Sesión',
                              style: new TextStyle(
                                color: Color.fromRGBO(225, 161, 0, 100),
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
            ],
          ),
        ),
      ),
    );
  }

  void signUp() async {
    if 
    (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      try {
        await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: _email, password: _password);
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => LoginPage()));
      } catch (e) {
        print(e.message);
      }
    }
  }
}
