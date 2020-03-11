import 'package:flutter/material.dart';

class AmbientesWidget extends StatefulWidget {
  @override
  _AmbientesWidgetState createState() => _AmbientesWidgetState();
}

class _AmbientesWidgetState extends State<AmbientesWidget> {
  List<Ambientes> _ambientes;
  List<String> _filters;


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
