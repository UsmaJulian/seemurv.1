import 'package:rect_getter/rect_getter.dart';

class AmbienteService {
  static final AmbienteService _singleton = new AmbienteService._internal();
  factory AmbienteService() {
    return _singleton;
  }
  AmbienteService._internal();

  List<Ambiente> allAmbiente = [
	  //Ambiente(6, 'Bohemio'),
    Ambiente(7, 'Tranquilo'),
    Ambiente(8, 'Familiar'),
    Ambiente(9, 'Concurrido'),
    Ambiente(10, 'Acogedor'),
  ];
  List<Ambiente> selectedAmbiente = [];
}

class Ambiente {
  int id;
  String name;
  var key;
  double width;

  Ambiente(this.id, this.name) {
    this.key = RectGetter.createGlobalKey();
    this.width = 0.0;
  }
}
