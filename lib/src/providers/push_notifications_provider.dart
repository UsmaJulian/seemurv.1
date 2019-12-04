import 'dart:async';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificationProvider {
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  final _mensajesStreamController = StreamController<String>.broadcast();
  Stream<String> get mensajes => _mensajesStreamController.stream;
  initNotificatios() {
    _firebaseMessaging.requestNotificationPermissions();

    _firebaseMessaging.getToken().then((token) {
      print('=====FCM Token=====');
      print(token);
      //dQcyWluzk6k:APA91bHEhPB9k0EEbCET-HQra3yRsvMzKx3mHMQxd2cUYE0Ci1DvWdivxAjoaHQm9RLKIHwQdLJmowv1NyLAJ-bodShG7VmRxeOtbifiGb-iJIur4yJK2JQ821Vt5Y3MGT3-NRG9Hw2r
    });
    _firebaseMessaging.configure(onMessage: (info) async {
      print('=====on Messagge======');
      print(info);
      String argumento = 'no-data';
      if (Platform.isAndroid) {
        argumento = info['data']['datos'] ?? 'no-data';
      } else {
        argumento = info['datos'] ?? 'no-data';
      }
      _mensajesStreamController.sink.add(argumento);
    }, onLaunch: (info) async {
      print('=====on Launch======');
      print(info);
    }, onResume: (info) async {
      print('=====on Resume======');
      print(info);

      String argumento = 'no-data';
      if (Platform.isAndroid) {
        argumento = info['data']['datos'] ?? 'no-data';
      } else {
        argumento = info['datos'] ?? 'no-data';
      }
      _mensajesStreamController.sink.add(argumento);
    });
  }

  dispose() {
    _mensajesStreamController?.close();
  }
}
