import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:rect_getter/rect_getter.dart';
import 'package:seemur_v1/components/widgets/caracteristicaseleccionableboton.dart';
import 'package:seemur_v1/services/filtros/caracteristicas_services.dart';

class CaracteristicaSelectionScreen extends StatefulWidget {
  _CaracteristicaSelectionScreenState createState() =>
      _CaracteristicaSelectionScreenState();
}

class _CaracteristicaSelectionScreenState
    extends State<CaracteristicaSelectionScreen>
    with SingleTickerProviderStateMixin {
  CaracteristicaService service = CaracteristicaService();
  List<Caracteristica> allCaracteristica, selectedCaracteristica;
  AnimationController _controller;
  Animation<Rect> _moveAnimation;
  Animation<Offset> _siMoveAnimation;
  Animation<double> _scaleAnimation,
      _clippedCaracteristicaScaleAnim,
      _clippedNotificationScaleAnim;
  Animation<Color> _clippedCaracteristicaColorAnim,
      _selectedCaracteristicaColorAnim;
  int selectedId, caracteristicaFound = 0;
  Offset caracteristicaStartOffset;

  Timer cleanupTimer;

  bool showCounter = false;
  int noClippedSelectedCaracteristica = 0;

  var _firstCaracteristicaKey = RectGetter.createGlobalKey();

  @override
  List<String> getSelectedCaracteristica() {
    List<String> listCaracteristica = [];
    if (service.selectedCaracteristica.length == 0) {
      listCaracteristica = [];
    } else {
      service.selectedCaracteristica.forEach((data) {
        listCaracteristica.add(data.name);
      });
    }

    return listCaracteristica;
  }

  @override
  void initState() {
    super.initState();
    allCaracteristica = service.allCaracteristica;
    selectedCaracteristica = service.selectedCaracteristica;
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));

    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.5).animate(
        CurvedAnimation(
            parent: _controller,
            curve: Interval(0.5, 0.7, curve: Curves.elasticInOut)));

    _clippedCaracteristicaScaleAnim = Tween<double>(begin: 1.0, end: 0.3)
        .animate(
            CurvedAnimation(parent: _controller, curve: Interval(0.5, 0.8)));

    _clippedNotificationScaleAnim = Tween<double>(begin: 35.0, end: 45.0)
        .animate(
            CurvedAnimation(parent: _controller, curve: Interval(0.7, 0.8)));

    _clippedCaracteristicaColorAnim =
        ColorTween(begin: Color(0xfff8c300), end: Colors.black).animate(
            CurvedAnimation(parent: _controller, curve: Interval(0.5, 1.0)));

    _selectedCaracteristicaColorAnim =
        ColorTween(begin: Color(0xff16202c), end: Color(0xfff8c300)).animate(
            CurvedAnimation(
                parent: _controller,
                curve: Interval(0.0, 0.3, curve: Curves.elasticInOut)));
  }

  @override
  Widget build(BuildContext context) {
    TextStyle whiteTextTheme =
        Theme.of(context).textTheme.button.copyWith(color: Colors.white);
    getSelectedCaracteristica();
    return Scaffold(
      body: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Column(
            children: <Widget>[
              Container(
                height: 50.0,
                child: _getSelectedCaracteristica(),
              ),
              Expanded(
                child: Container(
                  height: 80,
                  padding: const EdgeInsets.only(bottom: 0.0),
                  color: Color(0xfff6f7fa),
                  child: Center(
                    child: Wrap(
                      alignment: WrapAlignment.center,
                      spacing: 5.0,
                      children: _getUnselectedCaracteristica(),
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

  _getSelectedCaracteristica() {
    if (selectedCaracteristica.length == 0) {
      return RectGetter(
	      key: _firstCaracteristicaKey,
        child: Center(
            child: Text(
          "Comodidades seleccionadas ",
          style: Theme.of(context).textTheme.title,
        )),
      );
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Transform.translate(
          offset: getSelCaracteristicaMoveOffset(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: selectedCaracteristica.map((caracteristica) {
              return Transform(
                transform: Matrix4.diagonal3Values(
                    getSelectedCaracteristicaScaleOffset(caracteristica.id),
                    1.0,
                    1.0),
                child: RectGetter(
                  key: caracteristica.key,
                  child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: SelectedCaracteristicaChip(
                        caracteristica: caracteristica,
                        color:
                            _getSelectedCaracteristicaColor(caracteristica.id),
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
              "+$noClippedSelectedCaracteristica",
              style: whiteTextTheme,
            ),
          ),
        ),
      );
    }
    return Container();
  }

  _getUnselectedCaracteristica() {
    return allCaracteristica.map((caracteristica) {
      return RectGetter(
        key: caracteristica.key,
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: Transform.translate(
            offset: getOffsetValue(caracteristica.id),
            child: Transform.scale(
              scale: getScaleValue(caracteristica.id),
              child: SelectableCaracteristicaChip(
                caracteristica: caracteristica,
                color: getSelectableCaracteristicaColor(caracteristica.id),
                onPressed: (id) => _chipPressed(id),
              ),
            ),
          ),
        ),
      );
    }).toList();
  }

  _chipPressed(int id) async {
    var caracteristica =
        service.allCaracteristica.firstWhere((ing) => ing.id == id);

    var caracteristicaBeginRect = RectGetter.getRectFromKey(caracteristica.key);
    var caracteristicaEndRect;
    if (selectedCaracteristica.length > 0) {
      var firstSelectedCaracteristica = selectedCaracteristica[0];
      caracteristicaEndRect =
          RectGetter.getRectFromKey(firstSelectedCaracteristica.key);
    } else {
	    caracteristicaEndRect =
			    RectGetter.getRectFromKey(_firstCaracteristicaKey);
    }

    setState(() {
      selectedId = id;
      caracteristicaStartOffset = caracteristicaBeginRect.center;
    });

    setupMovementAnimation(caracteristicaBeginRect, caracteristicaEndRect);

    await _controller.forward();

    Caracteristica selIng =
        new Caracteristica(caracteristica.id, caracteristica.name);
    caracteristica.width = RectGetter.getRectFromKey(caracteristica.key).width;

    if (cleanupTimer != null) {
      cleanupTimer.cancel();
    }

    setState(() {
      selectedId = null;
      caracteristica.name = "";
      cleanupTimer = new Timer(new Duration(seconds: 2), () => _timerCleanup());
      selectedCaracteristica.insert(0, selIng);
    });

    cleanupSelectedCaracteristica();
    _controller.reset();
  }

  getOffsetValue(int id) {
    if (selectedId != null && selectedId == id) {
      var offset = _moveAnimation.value.center - caracteristicaStartOffset;
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

  getSelCaracteristicaMoveOffset() {
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

  void cleanupSelectedCaracteristica() {
    var screenWidth = MediaQuery.of(context).size.width;

    var totalWidth = 0.0;
    selectedCaracteristica.forEach((caracteristica) {
      var rect = RectGetter.getRectFromKey(caracteristica.key);
      if (rect != null) totalWidth += rect.width;
    });

    if (totalWidth >= screenWidth - 200.0) {
      setState(() {
        noClippedSelectedCaracteristica += 1;
        showCounter = true;
      });
      selectedCaracteristica.removeLast();
    }
  }

  getSelectedCaracteristicaScaleOffset(int id) {
    if (id == selectedCaracteristica.last.id &&
        noClippedSelectedCaracteristica > 0) {
      return _clippedCaracteristicaScaleAnim.value;
    }
    return 1.0;
  }

  _getSelectedCaracteristicaColor(int id) {
    if (id == selectedCaracteristica.last.id &&
        noClippedSelectedCaracteristica > 0) {
      return _clippedCaracteristicaColorAnim.value;
    }
    return Color(0xfff8c300);
  }

  void _timerCleanup() {
    var toCleanupCount =
        allCaracteristica.where((ing) => ing.name.isEmpty).toList().length;
    if (toCleanupCount > 0) {
      setState(() {
        allCaracteristica.removeWhere((ing) => ing.name.isEmpty);
        caracteristicaFound = new Random().nextInt(2000);
      });
    }
  }

  getSelectableCaracteristicaColor(int id) {
    if (selectedId != null && selectedId == id) {
      return _selectedCaracteristicaColorAnim.value;
    }
    return Colors.white;
  }
}
