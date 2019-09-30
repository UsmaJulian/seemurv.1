import 'package:rect_getter/rect_getter.dart';

class CaracteristicaService {
  static final CaracteristicaService _singleton =
      new CaracteristicaService._internal();
  factory CaracteristicaService() {
    return _singleton;
  }
  CaracteristicaService._internal();

  List<Caracteristica> allCaracteristica = [
    Caracteristica(25, 'Pet Friendly'),
    Caracteristica(26, 'Acceso silla de ruedas'),
    Caracteristica(27, 'Estacionamiento'),
    Caracteristica(28, 'Wi-fi'),
    Caracteristica(29, 'Televisión'),
    Caracteristica(30, 'Niños'),
    Caracteristica(31, 'Grupos Grandes'),
  ];
  List<Caracteristica> selectedCaracteristica = [];
}

class Caracteristica {
  int id;
  String name;
  var key;
  double width;

  Caracteristica(this.id, this.name) {
    this.key = RectGetter.createGlobalKey();
    this.width = 0.0;
  }
}
