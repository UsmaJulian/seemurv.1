import 'package:flutter/material.dart';
import 'package:seemur_v1/auth/auth.dart';
import 'package:seemur_v1/login_admin/root_page.dart';
import 'package:seemur_v1/screens/notificaciones_page.dart';
import 'package:seemur_v1/screens/splash_screen%20_one_loading.dart';
import 'package:seemur_v1/src/providers/push_notifications_provider.dart';

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

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GlobalKey<NavigatorState> navigatorKey =
  new GlobalKey<NavigatorState>();

  @override
  void initState() {
    super.initState();

    final pushPovider = new PushNotificationProvider();
    pushPovider.initNotificatios();
    pushPovider.mensajes.listen((data) {
      // Navigator.pushNamed(context, routeName);
      navigatorKey.currentState.pushNamed('notificaciones', arguments: data);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      initialRoute: 'splash',
      routes: {
        'splash': (BuildContext context) => SplashScreenOneLoading(),
        '/spalshthird': (BuildContext context) =>
            RootPage(
              auth: Auth(),
            ),
        'notificaciones': (BuildContext context) => NotificacionesPage()
      },
    );
  }
}
