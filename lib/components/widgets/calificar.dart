import 'package:flutter/material.dart';
import 'package:seemur_v1/screens/admin/show_client.dart';

class CalificarPage extends StatefulWidget {
  final datos;
  CalificarPage({this.datos});

  _CalificarPageState createState() => _CalificarPageState();
}

class _CalificarPageState extends State<CalificarPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Calificar a ' + widget.datos['taskname'].toString(),
          textAlign: TextAlign.center,
        ),
      ),
      body: Container(),
    );
  }
}
