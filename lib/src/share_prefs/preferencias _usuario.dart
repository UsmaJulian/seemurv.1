import 'package:shared_preferences/shared_preferences.dart';

class PreferenciasUsuario {
  static final PreferenciasUsuario _instancia =
      new PreferenciasUsuario._internal();

  factory PreferenciasUsuario() {
    return _instancia;
  }

  PreferenciasUsuario._internal();

  SharedPreferences _prefs;

  initPrefs() async {
    this._prefs = await SharedPreferences.getInstance();
  }

  get ciudad {
    return _prefs.getString('ciudad') ?? '';
  }

  set ciudad(ciudadSeleccionada) {
    _prefs.setString('ciudad', ciudadSeleccionada);
  }

  get filtros {
	  return _prefs.getStringList('filtro') ?? '';
  }

  set filtros(filtroSeleccionado) {
	  _prefs.setStringList('filtro', filtroSeleccionado);
  }

  get ubicacion {
    return _prefs.getBool('ubicacion') ?? true;
  }

  set ubicacion(filtroSeleccionado) {
    _prefs.setBool('ubicacion', filtroSeleccionado);
  }

  get notificaciones {
    return _prefs.getBool('notificaciones') ?? true;
  }

  set notificaciones(filtroSeleccionado) {
    _prefs.setBool('notificaciones', filtroSeleccionado);
  }

  get galeria {
    return _prefs.getBool('galeria') ?? true;
  }

  set galeria(filtroSeleccionado) {
    _prefs.setBool('galeria', filtroSeleccionado);
  }
}
