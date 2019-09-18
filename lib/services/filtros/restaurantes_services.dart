import 'package:rect_getter/rect_getter.dart';

class RestaurantesService {
  static final RestaurantesService _singleton = new RestaurantesService._internal();
  factory RestaurantesService() {
    return _singleton;
  }
  RestaurantesService._internal();

  List<Restaurantes> allRestaurantes = [
    Restaurantes(10, 'Desayuno'),
    Restaurantes(11, 'Brunch'),
    Restaurantes(12, 'Almuerzos'),
    Restaurantes(13, 'Vegetariano'),
    Restaurantes(14, 'Sirve Alcohol'),
  ];
  List<Restaurantes> selectedRestaurantes = [];
}
class Restaurantes {
  int id;
  String name;
  var key;
  double width;

  Restaurantes(this.id, this.name) {
    this.key = RectGetter.createGlobalKey();
    this.width = 0.0;
  } 
}