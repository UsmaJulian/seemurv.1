import 'dart:collection';

import 'package:flutter/material.dart';

class FiltrosSelecionados extends StatefulWidget {
  @override
  _FiltrosSelecionadosState createState() => _FiltrosSelecionadosState();
}

class _FiltrosSelecionadosState extends State<FiltrosSelecionados> {
  HashMap filtros = new HashMap<String, HashMap<int, String>>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(),
    );
  }
}
