import 'package:flutter/material.dart';

class RestaurantesWidget extends StatefulWidget {
  @override
  _RestaurantesWidgetState createState() => _RestaurantesWidgetState();
}

class _RestaurantesWidgetState extends State<RestaurantesWidget> {
  List<Restaurantes> _restaurantes;
  List<String> _filters;
  List<String> restsel = new List<String>();

  @override
  void initState() {
    super.initState();
    _filters = <String>[];
    _restaurantes = <Restaurantes>[
      const Restaurantes('Desayuno'),
      const Restaurantes('Almuerzos'),
      const Restaurantes('Onces'),
      const Restaurantes('Cena'),
      const Restaurantes('Snacks'),
    ];
  }

  @override
  Widget build(BuildContext context) {
    restsel.addAll(_filters);
    for (var i = 0; i < restsel.length; i++) {
      restsel[i] = "'${restsel[i]}'";
    }
    print("restsel");
    print(restsel);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Align(
          alignment: Alignment.centerLeft,
          child: Row(
            children: <Widget>[
              SizedBox(
                width: 20.0,
              ),
              Text(
                "Restaurantes",
                style: TextStyle(
                  fontFamily: 'HankenGrotesk',
                  color: Color(0xff000000),
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  fontStyle: FontStyle.normal,
                  letterSpacing: -0.1000000014901161,
                ),
              ),
            ],
          ),
        ),
        Wrap(
          children: restaurantesWidgets.toList(),
        ),
      ],
    );
  }

  Iterable<Widget> get restaurantesWidgets sync* {
    for (Restaurantes restaurante in _restaurantes) {
      yield Padding(
        padding: const EdgeInsets.all(6.0),
        child: FilterChip(
          backgroundColor: Colors.white,
          shadowColor: Colors.grey,
          elevation: 0.5,
          label: Text(
            restaurante.name,
            style: TextStyle(
              fontFamily: 'HankenGrotesk',
              color: Color(0xff000000),
              fontSize: 12,
              fontWeight: FontWeight.w700,
              fontStyle: FontStyle.normal,
              letterSpacing: -0.1000000014901161,
            ),
          ),
          selected: _filters.contains(restaurante.name),
          selectedColor: Color(0xffF8C300),
          onSelected: (bool selected) {
            setState(() {
              if (selected) {
                _filters.add(restaurante.name);
              } else {
                _filters.removeWhere((String name) {
                  return name == restaurante.name;
                });
              }
            });
          },
        ),
      );
    }
  }
}

class Restaurantes {
  final String name;

  const Restaurantes(this.name);
}
