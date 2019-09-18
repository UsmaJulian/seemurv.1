import 'package:flutter/material.dart';
import 'package:seemur_v1/services/filtros/ambiente_services.dart';


class SelectableAmbienteChip extends StatelessWidget {
  final Ambiente ambiente;
  final Function onPressed;
  final Color color;
  SelectableAmbienteChip({this.ambiente, this.onPressed, this.color});

  @override
  Widget build(BuildContext context) {
    TextStyle chipStyle = Theme.of(context)
        .textTheme
        .body2
        .copyWith(color: Colors.white, fontSize: 14.0);

    if (ambiente.name.isEmpty) {
      return Container(
        width: ambiente.width - 4.0,
        height: 45.0,
      );
    }

    return GestureDetector(
      onTap: () => this.onPressed(ambiente.id),
      child: Chip(
        padding: const EdgeInsets.symmetric(horizontal: 2.0, vertical: 0.0),
        backgroundColor: this.color,
        label: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              ambiente.name,
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

class SelectedAmbienteChip extends StatelessWidget {
  final Ambiente ambiente;
  final Function onPressed;
  final Color color;
  SelectedAmbienteChip({this.ambiente, this.onPressed, this.color});

  @override
  Widget build(BuildContext context) {
    TextStyle whiteTextTheme =
        Theme.of(context).textTheme.button.copyWith(color: Colors.white);

    return Chip(
      backgroundColor: this.color,
      label: Row(
        children: <Widget>[
          Text(
            ambiente.name,
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
