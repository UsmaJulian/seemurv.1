import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:seemur_v1/auth/auth.dart';
import 'package:seemur_v1/login_admin/root_page.dart';
import 'package:seemur_v1/screens/home.dart';
import 'package:seemur_v1/screens/notificaciones_page.dart';
import 'package:seemur_v1/screens/splash_screen%20_one_loading.dart';
import 'package:seemur_v1/src/share_prefs/preferencias%20_usuario.dart';

// var routes = <String, WidgetBuilder>{
//   '/spalshthird': (BuildContext context) => RootPage(
//         auth: Auth(),
//       ),
// };

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Future<void>.delayed(Duration(seconds: 2));

//   runApp(MultiProvider(
//     providers: [],
//     child: MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: SplashScreenOneLoading(),
//       routes: routes,
//     ),
//   ));
// }

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final pref = new PreferenciasUsuario();
  await pref.initPrefs();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GlobalKey<NavigatorState> navigatorKey =
      new GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    final prefsus = new PreferenciasUsuario();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en'),
        // Inglés
        const Locale('es'),
        // Español
      ],
      navigatorKey: navigatorKey,
      initialRoute: 'splash',
      routes: {
        'splash': (BuildContext context) => SplashScreenOneLoading(),
        '/spalshthird': (BuildContext context) => RootPage(
          auth: Auth(),
        ),
        HomePage.routeName: (BuildContext context) => HomePage(auth: Auth(),),
        'notificaciones': (BuildContext context) => NotificacionesPage()
      },
    );
  }
}
