import 'package:rect_getter/rect_getter.dart';

class AmbienteService {
  static final AmbienteService _singleton = new AmbienteService._internal();
  factory AmbienteService() {
    return _singleton;
  }
  AmbienteService._internal();

  List<Ambiente> allAmbiente = [
    Ambiente(5, 'Bohemio'),
    Ambiente(6, 'Tranquilo'),
    Ambiente(7, 'Familiar'),
    Ambiente(8, 'Concurrido'),
    Ambiente(9, 'Acogedor'),
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