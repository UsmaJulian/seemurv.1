import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HotelesPage extends StatefulWidget {
  _HotelesPageState createState() => _HotelesPageState();
}

class _HotelesPageState extends State<HotelesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(107.0),
        child: AppBar(
          centerTitle: true,
          automaticallyImplyLeading: false,
          backgroundColor: Color.fromRGBO(22, 32, 44, 1),
          title: Padding(
            padding: const EdgeInsets.only(top: 30.0),
            child: Text(
              'Hoteles',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          leading: Padding(
            padding: const EdgeInsets.only(top: 22.0),
            child: new IconButton(
              icon: new Icon(
                CupertinoIcons.back,
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
        ),
      ),
    );
  }
}
