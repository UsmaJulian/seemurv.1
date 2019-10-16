import 'package:flutter/material.dart';
import 'package:seemur_v1/auth/auth.dart';
import 'package:seemur_v1/login_admin/root_page.dart';

import 'package:seemur_v1/screens/splash_screen%20_one_loading.dart';

var routes = <String, WidgetBuilder>{
  '/spalshthird': (BuildContext context) => RootPage(
        auth: Auth(),
      ),
};

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Future<void>.delayed(Duration(seconds: 2));

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: SplashScreenOneLoading(),
    routes: routes,
  ));
}
