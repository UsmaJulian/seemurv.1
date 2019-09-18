import 'package:rect_getter/rect_getter.dart';

class BarDiscoCervService {
  static final BarDiscoCervService _singleton = new BarDiscoCervService._internal();
  factory BarDiscoCervService() {
    return _singleton;
  }
  BarDiscoCervService._internal();

  List<BarDiscoCerv> allBarDiscoCerv = [
    BarDiscoCerv(15, 'Tropical'),
    BarDiscoCerv(16, 'Crossover'),
    BarDiscoCerv(17, 'LGBTI'),
    BarDiscoCerv(18, 'Solo Mujeres'),
    BarDiscoCerv(19, 'De Remate'),
    BarDiscoCerv(20, 'Rave'),
  ];
  List<BarDiscoCerv> selectedBarDiscoCerv  = [];
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