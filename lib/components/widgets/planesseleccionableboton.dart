import 'package:flutter/material.dart';
import 'package:seemur_v1/services/filtros/planes_services.dart';

class SelectablePlanesChip extends StatelessWidget {
  final Planes planes;
  final Function onPressed;
  final Color color;
  SelectablePlanesChip({this.planes, this.onPressed, this.color});

  @override
  Widget build(BuildContext context) {
    TextStyle chipStyle = Theme.of(context)
        .textTheme
        .body2
        .copyWith(color: Colors.white, fontSize: 14.0);

    if (planes.name.isEmpty) {
      return Container(
        width: planes.width - 4.0,
        height: 45.0,
      );
    }

    return GestureDetector(
      onTap: () => this.onPressed(planes.id),
      child: Chip(
        padding: const EdgeInsets.symmetric(horizontal: 2.0, vertical: 0.0),
        backgroundColor: this.color,
        label: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              planes.name,
              style: chipStyle,
            ),
            IconButton(
              icon: Icon(
                Icons.add,
                size: 20.0,
              ),
              color: Colors.white,
              onPressed: () {},
            )
          ],
        ),
      ),
    );
  }
}

class SelectedPlanesChip extends StatelessWidget {
  final Planes planes;
  final Function onPressed;
  final Color color;
  SelectedPlanesChip({this.planes, this.onPressed, this.color});

  @override
  Widget build(BuildContext context) {
    TextStyle whiteTextTheme =
        Theme.of(context).textTheme.button.copyWith(color: Colors.white);

    return Chip(
      backgroundColor: this.color,
      label: Row(
        children: <Widget>[
          Text(
            planes.name,
            style: whiteTextTheme,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 4.0),
            child: Icon(
              Icons.check,
              size: 16.0,
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }
}
