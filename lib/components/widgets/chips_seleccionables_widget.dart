import 'package:flutter/material.dart';
import 'package:seemur_v1/src/share_prefs/preferencias%20_usuario.dart';

class ChipsSeleccionablesWidget extends StatefulWidget {
  @override
  _ChipsSeleccionablesWidgetState createState() =>
      _ChipsSeleccionablesWidgetState();
}

class _ChipsSeleccionablesWidgetState extends State<ChipsSeleccionablesWidget> {
  final prefs = new PreferenciasUsuario();
  List<String> filters;
  List<Ambientes> _ambientes;
  List<Restaurantes> _restaurantes;
  List<BaresDiscotecas> _baresdicotecas;
  List<Comodidades> _comodidades;

  @override
  void initState() {
    super.initState();
    filters = <String>[];
    print("filtro___");
    print(filters);
    prefs.filtros = filters;
    _ambientes = <Ambientes>[
      const Ambientes('Tranquilo'),
      const Ambientes('Familiar'),
      const Ambientes('Concurrido'),
      const Ambientes('Acogedor'),
    ];
    _restaurantes = <Restaurantes>[
      const Restaurantes('Desayuno'),
      const Restaurantes('Almuerzos'),
      const Restaurantes('Onces'),
      const Restaurantes('Cena'),
      const Restaurantes('Snacks'),
    ];
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
    _comodidades = <Comodidades>[
      const Comodidades('Aceptan Mascotas'),
      const Comodidades('Acceso silla de ruedas'),
      const Comodidades('Estacionamiento'),
      const Comodidades('Wi-fi'),
      const Comodidades('Televisión'),
      const Comodidades('Niños'),
      const Comodidades('Grupos grandes'),
    ];
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    print(filters);
    prefs.filtros = filters;
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
          selected: filters.contains(ambiente.name),
          selectedColor: Color(0xffF8C300),
          onSelected: (bool selected) {
            setState(() {
              if (selected) {
                filters.add(ambiente.name);
              } else {
                filters.removeWhere((String name) {
                  return name == ambiente.name;
                });
              }
            });
          },
        ),
      );
    }
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
          selected: filters.contains(restaurante.name),
          selectedColor: Color(0xffF8C300),
          onSelected: (bool selected) {
            setState(() {
              if (selected) {
                filters.add(restaurante.name);
              } else {
                filters.removeWhere((String name) {
                  return name == restaurante.name;
                });
              }
            });
          },
        ),
      );
    }
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
          selected: filters.contains(bardicoteca.name),
          selectedColor: Color(0xffF8C300),
          onSelected: (bool selected) {
            setState(() {
              if (selected) {
                filters.add(bardicoteca.name);
              } else {
                filters.removeWhere((String name) {
                  return name == bardicoteca.name;
                });
              }
            });
          },
        ),
      );
    }
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
          selected: filters.contains(comodidad.name),
          selectedColor: Color(0xffF8C300),
          onSelected: (bool selected) {
            setState(() {
              if (selected) {
                filters.add(comodidad.name);
              } else {
                filters.removeWhere((String name) {
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

class Ambientes {
  final String name;

  const Ambientes(this.name);
}

class Restaurantes {
  final String name;

  const Restaurantes(this.name);
}

class BaresDiscotecas {
  final String name;

  const BaresDiscotecas(this.name);
}

class Comodidades {
  final String name;

  const Comodidades(this.name);
}
