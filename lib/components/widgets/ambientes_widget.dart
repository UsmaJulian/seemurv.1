import 'dart:collection';

import 'package:flutter/material.dart';

class AmbientesWidget extends StatefulWidget {
  @override
  _AmbientesWidgetState createState() => _AmbientesWidgetState();
}

class _AmbientesWidgetState extends State<AmbientesWidget> {
  List<Ambientes> _ambientes;
  List<String> _filters;
  List<String> ambientessel = new List<String>();

//  HashMap filtrosPadre = new HashMap<String,  HashMap<int, String>>();
//  HashMap filtrosHijo = new HashMap<int, String>();
  HashMap ambientesfiltro = new HashMap<int, String>();

  @override
  void initState() {
    super.initState();
    _filters = <String>[];
    _ambientes = <Ambientes>[
      const Ambientes('Tranquilo'),
      const Ambientes('Familiar'),
      const Ambientes('Concurrido'),
      const Ambientes('Acogedor'),
    ];
  }

  @override
  Widget build(BuildContext context) {
    ambientessel.addAll(_filters);
    for (var i = 0; i < ambientessel.length; i++) {
      ambientessel[i] = "'${ambientessel[i]}'";
    }
    print("ambientessel");
    print(ambientessel);
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
                "Ambientes",
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
          children: ambientesWidgets.toList(),
        ),
      ],
    );
  }

  Iterable<Widget> get ambientesWidgets sync* {
    for (Ambientes ambiente in _ambientes) {
      yield Padding(
        padding: const EdgeInsets.all(6.0),
        child: FilterChip(
          backgroundColor: Colors.white,
          shadowColor: Colors.grey,
          elevation: 0.5,
          label: Text(
            ambiente.name,
            style: TextStyle(
              fontFamily: 'HankenGrotesk',
              color: Color(0xff000000),
              fontSize: 12,
              fontWeight: FontWeight.w700,
              fontStyle: FontStyle.normal,
              letterSpacing: -0.1000000014901161,
            ),
          ),
          selected: _filters.contains(ambiente.name),
          selectedColor: Color(0xffF8C300),
          onSelected: (bool selected) {
            setState(() {
              if (selected) {
                _filters.add(ambiente.name);
//                Map ambientmap={0:"Tranquilo",1: "Familiar",2: "Concurrido",3:"Acogedor"};
//                filtrosPadre.putIfAbsent("Ambientes", filtrosHijo.putIfAbsent(0, 'Familiar' as dynamic) );
                ambientesfiltro.update(0, (a) => ambiente.name);
                print("ambfil______");
                print(ambientesfiltro);
              } else {
                _filters.removeWhere((String name) {
                  return name == ambiente.name;
                });
              }
            });
          },
        ),
      );
    }
  }
}

class Ambientes {
  final String name;

  const Ambientes(this.name);
}
