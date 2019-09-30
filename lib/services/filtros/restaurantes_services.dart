import 'package:rect_getter/rect_getter.dart';

class RestauranteService {
  static final RestauranteService _singleton =
      new RestauranteService._internal();
  factory RestauranteService() {
    return _singleton;
  }
  RestauranteService._internal();

  List<Restaurante> allRestaurante = [
    Restaurante(11, 'Desayuno'),
    Restaurante(12, 'Brunch'),
    Restaurante(13, 'Almuerzos'),
    Restaurante(14, 'Onces'),
    Restaurante(15, 'Cena'),
    Restaurante(16, 'Snacks'),
  ];
  List<Restaurante> selectedRestaurante = [];
}

class Restaurante {
  int id;
  String name;
  var key;
  double width;

  Restaurante(this.id, this.name) {
    this.key = RectGetter.createGlobalKey();
    this.width = 0.0;
  }
}
