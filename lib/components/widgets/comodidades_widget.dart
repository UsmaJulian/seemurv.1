import 'package:flutter/material.dart';

class ComodidadesWidget extends StatefulWidget {
  @override
  _ComodidadesWidgetState createState() => _ComodidadesWidgetState();
}

class _ComodidadesWidgetState extends State<ComodidadesWidget> {
  List<Comodidades> _comodidades;
  List<String> _filters;
  List<String> comodsel = new List<String>();

  @override
  void initState() {
    super.initState();
    _filters = <String>[];
    _comodidades = <Comodidades>[
      const Comodidades('Aceptan Mascotas'),
      const Comodidades('Acceso silla de ruedas'),
      const Comodidades('Estacionamiento'),
      const Comodidades('Wi-fi'),
      const Comodidades('Televisión'),
      const Comodidades('Niños'),
      const Comodidades('Grupos grandes'),
    ];
  }

  @override
  Widget build(BuildContext context) {
    comodsel.addAll(_filters);
    for (var i = 0; i < comodsel.length; i++) {
      comodsel[i] = "'${comodsel[i]}'";
    }
    print("comodsel");
    print(comodsel);
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
                "Comodidades",
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
          children: comodidadesWidgets.toList(),
        ),
      ],
    );
  }

  Iterable<Widget> get comodidadesWidgets sync* {
    for (Comodidades comodidad in _comodidades) {
      yield Padding(
        padding: const EdgeInsets.all(6.0),
        child: FilterChip(
          backgroundColor: Colors.white,
          shadowColor: Colors.grey,
          elevation: 0.5,
          label: Text(
            comodidad.name,
            style: TextStyle(
              fontFamily: 'HankenGrotesk',
              color: Color(0xff000000),
              fontSize: 12,
              fontWeight: FontWeight.w700,
              fontStyle: FontStyle.normal,
              letterSpacing: -0.1000000014901161,
            ),
          ),
          selected: _filters.contains(comodidad.name),
          selectedColor: Color(0xffF8C300),
          onSelected: (bool selected) {
            setState(() {
              if (selected) {
                _filters.add(comodidad.name);
              } else {
                _filters.removeWhere((String name) {
                  return name == comodidad.name;
                });
              }
            });
          },
        ),
      );
    }
  }
}

class Comodidades {
  final String name;

  const Comodidades(this.name);
}
