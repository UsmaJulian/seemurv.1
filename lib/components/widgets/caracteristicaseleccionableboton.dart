import 'package:flutter/material.dart';
import 'package:seemur_v1/services/filtros/caracteristicas_services.dart';

class SelectableCaracteristicaChip extends StatelessWidget {
  final Caracteristica caracteristica;
  final Function onPressed;
  final Color color;
  SelectableCaracteristicaChip(
      {this.caracteristica, this.onPressed, this.color});

  @override
  Widget build(BuildContext context) {
    TextStyle chipStyle = Theme.of(context)
        .textTheme
        .body2
        .copyWith(color: Colors.black, fontSize: 14.0);

    if (caracteristica.name.isEmpty) {
      return Container(
        width: caracteristica.width - 4.0,
        height: 45.0,
      );
    }

    return GestureDetector(
      onTap: () => this.onPressed(caracteristica.id),
      child: Chip(
        padding: const EdgeInsets.symmetric(horizontal: 2.0, vertical: 0.0),
        backgroundColor: this.color,
        label: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 4.0),
              child: Text(
                caracteristica.name,
                style: chipStyle,
                textAlign: TextAlign.center,
              ),
            ),
            IconButton(
              icon: Icon(
                Icons.add,
                size: 20.0,
              ),
              color: Colors.black,
              onPressed: () {},
            )
          ],
        ),
      ),
    );
  }
}

class SelectedCaracteristicaChip extends StatelessWidget {
  final Caracteristica caracteristica;
  final Function onPressed;
  final Color color;
  SelectedCaracteristicaChip({this.caracteristica, this.onPressed, this.color});

  @override
  Widget build(BuildContext context) {
    TextStyle whiteTextTheme =
        Theme.of(context).textTheme.button.copyWith(color: Colors.black);

    return Chip(
      backgroundColor: this.color,
      label: Row(
        children: <Widget>[
          Text(
            caracteristica.name,
            style: whiteTextTheme,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 4.0),
            child: Icon(
              Icons.check,
              size: 16.0,
              color: Colors.black,
            ),
          )
        ],
      ),
    );
  }
}
