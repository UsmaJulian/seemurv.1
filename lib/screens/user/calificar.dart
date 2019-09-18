import 'package:flutter/material.dart';

class CalificarPage extends StatefulWidget {
  _CalificarPageState createState() => _CalificarPageState();
}

class _CalificarPageState extends State<CalificarPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: 255.0,
        child: Stack(
          children: <Widget>[
            Container(
              color: Colors.red,
            ),
          ],
        ),
      ),
    );
  }
}
