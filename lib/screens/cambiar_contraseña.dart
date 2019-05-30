import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:seemur_v1/screens/ingresar.dart';

class RenewContrasena extends StatefulWidget {
  @override
  _RenewContrasenaState createState() => new _RenewContrasenaState();
}

class _RenewContrasenaState extends State<RenewContrasena> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _email;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 10, right: 10),
            child: IconButton(
              icon: Icon(
                Icons.close,
                color: Colors.black,
              ),
              tooltip: MaterialLocalizations.of(context).backButtonTooltip,
              onPressed: () {
                Navigator.maybePop(context);
              },
            ),
          ),
        ],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Center(
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(top: 0, right: 0, left: 0),
                child: Column(
                  children: <Widget>[
                    Container(
                      width: 294,
                      height: 30,
                      child: Text('Cambia tu contraseña',
                          style: new TextStyle(
                            color: Colors.black,
                            fontFamily: 'HankenGrotesk',
                            fontSize: 24.0,
                            fontWeight: FontWeight.w700,
                          )),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 30, left: 40, right: 40),
                      child: Container(
                        width: 294,
                        height: 50,
                        child: Text(
                            'Te enviaré un enlace temporal a tu correo electrónico',
                            style: new TextStyle(
                              color: Colors.black,
                              fontFamily: 'HankenGrotesk',
                              fontSize: 14.0,
                              fontWeight: FontWeight.w700,
                            )),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 32.0, left: 40, right: 40),
                      child: Container(
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
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 12,
                        left: 0,
                      ),
                      child: Container(
                        width: 295,
                        height: 48,
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
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 48.0,
                        left: 40,
                        right: 40,
                        bottom: 100,
                      ),
                      child: Container(
                        width: 315,
                        height: 44,
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
                        child: FlatButton(
                          child: Text('Cambiar contraseña',
                              style: new TextStyle(
                                color: Colors.black,
                                fontFamily: 'HankenGrotesk',
                                fontSize: 14.0,
                                fontWeight: FontWeight.w700,
                              )),
                          onPressed: resetPassword,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void resetPassword() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      try {
        await FirebaseAuth.instance.sendPasswordResetEmail(
          email: _email,
        );
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => LoginPage()));
      } catch (e) {
        print(e.message);
      }
    }
  }
}
