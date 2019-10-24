import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import 'package:seemur_v1/models/client_model.dart';

Future<String> _loadClientAsset() async {
  return await rootBundle.loadString('assets/jsonfiles/client.json');
}

Future loadClient() async {
  String jsonString = await _loadClientAsset();
  final jsonResponse = json.decode(jsonString);
  Client client = new Client.fromJson(jsonResponse);
  print(client.taskname);
}
