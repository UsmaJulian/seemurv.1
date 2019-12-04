import 'package:flutter/material.dart';
import 'package:seemur_v1/auth/auth.dart';
import 'package:seemur_v1/login_admin/menu_page.dart';
import 'package:seemur_v1/login_admin/sliders_page.dart';

class RootPage extends StatefulWidget {
  RootPage({this.auth});

  final BaseAuth auth;

  _RootPageState createState() => _RootPageState();
}

enum AuthStatus { notSignIn, signIn }

class _RootPageState extends State<RootPage> {
  AuthStatus _authStatus = AuthStatus.notSignIn;

  @override
  void initState() {
    super.initState();
    widget.auth.currentUser().then((onValue) {
      setState(() {
        print(onValue);
        _authStatus =
            onValue == 'no_login' ? AuthStatus.notSignIn : AuthStatus.signIn;
      });
    });
  }

  void _signIn() {
    setState(() {
      _authStatus = AuthStatus.signIn;
    });
  }

  void _signOut() {
    setState(() {
      _authStatus = AuthStatus.notSignIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget _widget;

    switch (_authStatus) {
      case AuthStatus.notSignIn:
        return IntroScreen(
          auth: widget.auth,
          onSignIn: _signIn,
        );
        break;
      case AuthStatus.signIn:
        return MenuPage(
          auth: widget.auth,
          onSignedOut: _signOut,
        );
        break;
    }

    return _widget;
  }
}
