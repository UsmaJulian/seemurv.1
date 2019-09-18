import 'package:rect_getter/rect_getter.dart';

class CaracteristicaService {
  static final CaracteristicaService _singleton = new CaracteristicaService._internal();
  factory CaracteristicaService() {
    return _singleton;
  }
  CaracteristicaService._internal();

  List<Caracteristica> allCaracteristica = [
    Caracteristica(21, 'Pet Friendly'),
    Caracteristica(22, 'Acceso silla de ruedas'),
    Caracteristica(23, 'Estacionamiento'),
    Caracteristica(24, 'Wi-fi'),
    Caracteristica(25, 'Televisión'),
    Caracteristica(26, 'Niños'),
    Caracteristica(27, 'Grupos Grandes'),
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