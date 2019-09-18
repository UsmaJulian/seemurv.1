import 'package:rect_getter/rect_getter.dart';

class AmbienteService {
  static final AmbienteService _singleton = new AmbienteService._internal();
  factory AmbienteService() {
    return _singleton;
  }
  AmbienteService._internal();

  List<Planes> allPlanes = [
    Planes(1, 'Solo'),
    Planes(2, 'En Pareja'),
    Planes(3, 'Parche'),
    Planes(4, 'Negocios'),
  ];
  List<Planes> selectedPlan = [];
}
class Planes {
  int id;
  String name;
  var key;
  double width;

  Planes(this.id, this.name) {
    this.key = RectGetter.createGlobalKey();
    this.width = 0.0;
  } 
}