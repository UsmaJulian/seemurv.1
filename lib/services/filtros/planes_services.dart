import 'package:rect_getter/rect_getter.dart';

class PlanesServices {
  static final PlanesServices _singleton = new PlanesServices._internal();
  factory PlanesServices() {
    return _singleton;
  }
  PlanesServices._internal();

  List<Planes> allPlanes = [
    Planes(1, 'Solo'),
    Planes(2, 'En Pareja'),
    Planes(3, 'En Parche'),
    Planes(4, 'Negocios'),
    Planes(5, 'En Familia'),
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
