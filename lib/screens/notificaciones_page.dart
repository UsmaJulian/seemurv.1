import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NotificacionesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final argumentonotifi = ModalRoute.of(context).settings.arguments;
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
              'Notificaciones',
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
      body: ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            leading: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset('assets/icon/icon.png')),
            // title: Text(argumentonotifi) ?? 'Sin notificaciones',
          );
        },
      ),
    );
  }
}
