import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:rect_getter/rect_getter.dart';
import 'package:seemur_v1/components/widgets/restaurantesseleccionableboton.dart';
import 'package:seemur_v1/services/filtros/restaurantes_services.dart';

class RestauranteSelectionScreen extends StatefulWidget {
  _RestauranteSelectionScreenState createState() =>
      _RestauranteSelectionScreenState();
}

class _RestauranteSelectionScreenState extends State<RestauranteSelectionScreen>
    with SingleTickerProviderStateMixin {
  RestauranteService service = RestauranteService();
  List<Restaurante> allRestaurante, selectedRestaurante;
  AnimationController _controller;
  Animation<Rect> _moveAnimation;
  Animation<Offset> _siMoveAnimation;
  Animation<double> _scaleAnimation,
      _clippedRestauranteScaleAnim,
      _clippedNotificationScaleAnim;
  Animation<Color> _clippedRestauranteColorAnim, _selectedRestauranteColorAnim;
  int selectedId, restauranteFound = 0;
  Offset restauranteStartOffset;

  Timer cleanupTimer;

  bool showCounter = false;
  int noClippedSelectedRestaurante = 0;

  var firstRestauranteKey = RectGetter.createGlobalKey();

  @override
  List<String> getSelectedRestaurantes() {
    List<String> listRestaurantes = [];
    if (service.selectedRestaurante.length == 0) {
      listRestaurantes = [];
    } else {
      service.selectedRestaurante.forEach((data) {
        listRestaurantes.add(data.name);
      });
    }

    return listRestaurantes;
  }

  @override
  void initState() {
    super.initState();
    allRestaurante = service.allRestaurante;
    selectedRestaurante = service.selectedRestaurante;
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));

    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.5).animate(
        CurvedAnimation(
            parent: _controller,
            curve: Interval(0.5, 0.7, curve: Curves.elasticInOut)));

    _clippedRestauranteScaleAnim = Tween<double>(begin: 1.0, end: 0.3).animate(
        CurvedAnimation(parent: _controller, curve: Interval(0.5, 0.8)));

    _clippedNotificationScaleAnim = Tween<double>(begin: 35.0, end: 45.0)
        .animate(
            CurvedAnimation(parent: _controller, curve: Interval(0.7, 0.8)));

    _clippedRestauranteColorAnim =
        ColorTween(begin: Color(0xfff8c300), end: Colors.black).animate(
            CurvedAnimation(parent: _controller, curve: Interval(0.5, 1.0)));

    _selectedRestauranteColorAnim =
        ColorTween(begin: Color(0xff16202c), end: Color(0xfff8c300)).animate(
            CurvedAnimation(
                parent: _controller,
                curve: Interval(0.0, 0.3, curve: Curves.elasticInOut)));
  }

  @override
  Widget build(BuildContext context) {
    TextStyle whiteTextTheme =
        Theme.of(context).textTheme.button.copyWith(color: Colors.white);
getSelectedRestaurantes();
    return Scaffold(
      body: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Column(
            children: <Widget>[
              Container(
                height: 50.0,
                child: _getSelectedRestaurante(),
              ),
              Expanded(
                child: Container(
                  height: 20,
                  padding: const EdgeInsets.only(bottom: 30.0),
                  color: Color(0xfff6f7fa),
                  child: Center(
                    child: Wrap(
                      alignment: WrapAlignment.center,
                      spacing: 5.0,
                      children: _getUnselectedRestaurante(),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  _getSelectedRestaurante() {
    if (selectedRestaurante.length == 0) {
      return RectGetter(
        key: firstRestauranteKey,
        child: Center(
            child: Text(
          "Restaurantes seleccionados ",
          style: Theme.of(context).textTheme.title,
        )),
      );
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Transform.translate(
          offset: getSelRestauranteMoveOffset(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: selectedRestaurante.map((restaurante) {
              return Transform(
                transform: Matrix4.diagonal3Values(
                    getSelectedRestauranteScaleOffset(restaurante.id),
                    1.0,
                    1.0),
                child: RectGetter(
                  key: restaurante.key,
                  child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: SelectedRestauranteChip(
                        restaurante: restaurante,
                        color: getSelectableRestauranteColor(restaurante.id),
                      )),
                ),
              );
            }).toList(),
          ),
        ),
        getNotificationBubble()
      ],
    );
  }

  Widget getNotificationBubble() {
    TextStyle whiteTextTheme =
        Theme.of(context).textTheme.button.copyWith(color: Colors.white);
    if (showCounter) {
      return ClipOval(
        child: Container(
          width: _clippedNotificationScaleAnim.value,
          height: _clippedNotificationScaleAnim.value,
          color: Colors.black,
          child: Center(
            child: Text(
              "+$noClippedSelectedRestaurante",
              style: whiteTextTheme,
            ),
          ),
        ),
      );
    }
    return Container();
  }

  _getUnselectedRestaurante() {
    return allRestaurante.map((restaurante) {
      return RectGetter(
        key: restaurante.key,
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: Transform.translate(
            offset: getOffsetValue(restaurante.id),
            child: Transform.scale(
              scale: getScaleValue(restaurante.id),
              child: SelectableRestauranteChip(
                restaurante: restaurante,
                color: getSelectableRestauranteColor(restaurante.id),
                onPressed: (id) => _chipPressed(id),
              ),
            ),
          ),
        ),
      );
    }).toList();
  }

  _chipPressed(int id) async {
    var restaurante = service.allRestaurante.firstWhere((ing) => ing.id == id);

    var restauranteBeginRect = RectGetter.getRectFromKey(restaurante.key);
    var restauranteEndRect;
    if (selectedRestaurante.length > 0) {
      var firstSelectedRestaurante = selectedRestaurante[0];
      restauranteEndRect =
          RectGetter.getRectFromKey(firstSelectedRestaurante.key);
    } else {
      restauranteEndRect = RectGetter.getRectFromKey(firstRestauranteKey);
    }

    setState(() {
      selectedId = id;
      restauranteStartOffset = restauranteBeginRect.center;
    });

    setupMovementAnimation(restauranteBeginRect, restauranteEndRect);

    await _controller.forward();

    Restaurante selIng = new Restaurante(restaurante.id, restaurante.name);
    restaurante.width = RectGetter.getRectFromKey(restaurante.key).width;

    if (cleanupTimer != null) {
      cleanupTimer.cancel();
    }

    setState(() {
      selectedId = null;
      restaurante.name = "";
      cleanupTimer = new Timer(new Duration(seconds: 2), () => _timerCleanup());
      selectedRestaurante.insert(0, selIng);
    });

    cleanupSelectedRestaurante();
    _controller.reset();
  }

  getOffsetValue(int id) {
    if (selectedId != null && selectedId == id) {
      var offset = _moveAnimation.value.center - restauranteStartOffset;
      return offset;
    }
    return Offset.zero;
  }

  getScaleValue(int id) {
    if (selectedId != null && selectedId == id) {
      return _scaleAnimation.value;
    }
    return 1.0;
  }

  getSelRestauranteMoveOffset() {
    if (selectedId != null) {
      return _siMoveAnimation.value;
    }
    return Offset.zero;
  }

  setupMovementAnimation(Rect begin, Rect end) {
    _moveAnimation = RectTween(begin: begin, end: end).animate(
        CurvedAnimation(parent: _controller, curve: Interval(0.5, 1.0)));
    _siMoveAnimation =
        Tween<Offset>(begin: Offset.zero, end: Offset(100.0, 0.0)).animate(
            CurvedAnimation(parent: _controller, curve: Interval(0.5, 1.0)));
  }

  void cleanupSelectedRestaurante() {
    var screenWidth = MediaQuery.of(context).size.width;

    var totalWidth = 0.0;
    selectedRestaurante.forEach((restaurante) {
      var rect = RectGetter.getRectFromKey(restaurante.key);
      if (rect != null) totalWidth += rect.width;
    });

    if (totalWidth >= screenWidth - 200.0) {
      setState(() {
        noClippedSelectedRestaurante += 1;
        showCounter = true;
      });
      selectedRestaurante.removeLast();
    }
  }

  getSelectedRestauranteScaleOffset(int id) {
    if (id == selectedRestaurante.last.id && noClippedSelectedRestaurante > 0) {
      return _clippedRestauranteScaleAnim.value;
    }
    return 1.0;
  }

  _getSelectedPlanColor(int id) {
    if (id == selectedRestaurante.last.id && noClippedSelectedRestaurante > 0) {
      return _clippedRestauranteColorAnim.value;
    }
    return Color(0xfff8c300);
  }

  void _timerCleanup() {
    var toCleanupCount =
        allRestaurante.where((ing) => ing.name.isEmpty).toList().length;
    if (toCleanupCount > 0) {
      setState(() {
        allRestaurante.removeWhere((ing) => ing.name.isEmpty);
        restauranteFound = new Random().nextInt(2000);
      });
    }
  }

  getSelectableRestauranteColor(int id) {
    if (selectedId != null && selectedId == id) {
      return _selectedRestauranteColorAnim.value;
    }
    return Colors.white;
  }
}
