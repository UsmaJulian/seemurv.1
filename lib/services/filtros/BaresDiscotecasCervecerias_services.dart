import 'package:rect_getter/rect_getter.dart';

class BarDiscoCervService {
  static final BarDiscoCervService _singleton =
      new BarDiscoCervService._internal();
  factory BarDiscoCervService() {
    return _singleton;
  }
  BarDiscoCervService._internal();

  List<BarDiscoCerv> allBarDiscoCerv = [
    BarDiscoCerv(17, 'Salsa'),
    BarDiscoCerv(18, 'Electrónica'),
    BarDiscoCerv(19, 'Reggaeton'),
    BarDiscoCerv(20, 'Popular'),
    BarDiscoCerv(21, 'Música en vivo'),
    BarDiscoCerv(22, 'Vallenato'),
    BarDiscoCerv(23, '80\'s'),
    BarDiscoCerv(24, 'Pop'),
    BarDiscoCerv(25, 'Rock'),
    BarDiscoCerv(24, 'Alternativo'),
  ];
  List<BarDiscoCerv> selectedBarDiscoCerv = [];
}

class BarDiscoCerv {
  int id;
  String name;
  var key;
  double width;

  BarDiscoCerv(this.id, this.name) {
    this.key = RectGetter.createGlobalKey();
    this.width = 0.0;
  }
}
