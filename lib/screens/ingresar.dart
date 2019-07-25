import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:seemur_v1/ingreso.dart';
import 'package:seemur_v1/screens/cambiar_contrase%C3%B1a.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _email, _password;
  bool _obscureText = true;
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
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
      body: Container(
        height: MediaQuery.of(context).size.height,
        width:MediaQuery.of(context).size.width ,
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 80, right: 90, left: 0),
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
                                }else return null;
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
                            }else return null;
                          },
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            labelText: 'Contraseña',
                            suffixIcon: FlatButton(
                              child: Icon(
                                _obscureText
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: Color(0xffada9a9),
                              ),
                              onPressed: _toggle,
                            ),
                          ),
                          onSaved: (input) => _password = input,
                          obscureText: _obscureText,
                        ),
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
                        Navigator.push(context,new MaterialPageRoute(builder: (context)=>RenewContrasena()));
                      },
                    ),
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
                    onPressed: signIn,
                    child: Text('Continuar',
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
                      Padding(
                        padding: const EdgeInsets.only(bottom:75.0),
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
                        padding: const EdgeInsets.only(left: 0, right: 54,bottom: 75),
                        child: Container(
                          child: FlatButton(
                            onPressed: () {},
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
              ],
            ),
          ),
        ),
      ),
    );
  }

  void signIn() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      try {
        FirebaseUser user = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: _email, password: _password);
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => Ingreso(user: user)));
      } catch (e) {
        print(e.message);
      }
    }
  }
}
