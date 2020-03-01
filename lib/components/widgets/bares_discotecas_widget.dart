import 'package:flutter/material.dart';

class BaresDiscotecasWidget extends StatefulWidget {
  @override
  _BaresDiscotecasWidgetState createState() => _BaresDiscotecasWidgetState();
}

class _BaresDiscotecasWidgetState extends State<BaresDiscotecasWidget> {
  List<BaresDiscotecas> _baresdicotecas;
  List<String> _filters;
  List<String> baresdicotecassel = new List<String>();

  @override
  void initState() {
    super.initState();
    _filters = <String>[];
    _baresdicotecas = <BaresDiscotecas>[
      const BaresDiscotecas('Salsa'),
      const BaresDiscotecas('Electrónica'),
      const BaresDiscotecas('Reggaeton'),
      const BaresDiscotecas('Popular'),
      const BaresDiscotecas('Música en vivo'),
      const BaresDiscotecas('Vallenato'),
      const BaresDiscotecas('80\'s'),
      const BaresDiscotecas('Pop'),
      const BaresDiscotecas('Rock'),
      const BaresDiscotecas('Alternativo'),
    ];
  }

  @override
  Widget build(BuildContext context) {
    baresdicotecassel.addAll(_filters);
    for (var i = 0; i < baresdicotecassel.length; i++) {
      baresdicotecassel[i] = "'${baresdicotecassel[i]}'";
    }
    print("baresdicotecassel");
    print(baresdicotecassel);
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
                "Bares y discotecas",
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
          children: baresdiscotecasWidgets.toList(),
        ),
      ],
    );
  }

  Iterable<Widget> get baresdiscotecasWidgets sync* {
    for (BaresDiscotecas bardicoteca in _baresdicotecas) {
      yield Padding(
        padding: const EdgeInsets.all(6.0),
        child: FilterChip(
          backgroundColor: Colors.white,
          shadowColor: Colors.grey,
          elevation: 0.5,
          label: Text(
            bardicoteca.name,
            style: TextStyle(
              fontFamily: 'HankenGrotesk',
              color: Color(0xff000000),
              fontSize: 12,
              fontWeight: FontWeight.w700,
              fontStyle: FontStyle.normal,
              letterSpacing: -0.1000000014901161,
            ),
          ),
          selected: _filters.contains(bardicoteca.name),
          selectedColor: Color(0xffF8C300),
          onSelected: (bool selected) {
            setState(() {
              if (selected) {
                _filters.add(bardicoteca.name);
              } else {
                _filters.removeWhere((String name) {
                  return name == bardicoteca.name;
                });
              }
            });
          },
        ),
      );
    }
  }
}

class BaresDiscotecas {
  final String name;

  const BaresDiscotecas(this.name);
}
