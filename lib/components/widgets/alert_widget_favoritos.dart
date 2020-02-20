import 'package:flutter/material.dart';

Future<void> ShowdialogFavoritos(BuildContext context, cliente) {
  return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          backgroundColor: Colors.white,
          title: Text('${cliente}'),
          content: const Text(
              'Este establecimiento ha sido agregado a tus favoritos.'),
          actions: <Widget>[
            FlatButton(
              child: Text(
                'Acepto',
                style: TextStyle(color: Colors.black),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      });
}
