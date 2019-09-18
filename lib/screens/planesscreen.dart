import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:rect_getter/rect_getter.dart';
import 'package:seemur_v1/components/widgets/planesseleccionableboton.dart';
import 'package:seemur_v1/services/filtros/planes_services.dart';

class PlanesSelectionScreen extends StatefulWidget {
  _PlanesSelectionScreenState createState() => _PlanesSelectionScreenState();
}

class _PlanesSelectionScreenState extends State<PlanesSelectionScreen>
    with SingleTickerProviderStateMixin {
  AmbienteService service = AmbienteService();
  List<Planes> allPlanes, selectedPlan;
  AnimationController _controller;
  Animation<Rect> _moveAnimation;
  Animation<Offset> _siMoveAnimation;
  Animation<double> _scaleAnimation,
      _clippedPlanesScaleAnim,
      _clippedNotificationScaleAnim;
  Animation<Color> _clippedPlanesColorAnim, _selectedPlanColorAnim;
  int selectedId, planesFound = 0;
  Offset planesStartOffset;

  Timer cleanupTimer;

  bool showCounter = false;
  int noClippedSelectedPlan = 0;

  var firstPlanKey = RectGetter.createGlobalKey();
  @override
  @override
  void initState() {
    super.initState();
    allPlanes = service.allPlanes;
    selectedPlan = service.selectedPlan;
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));

    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.5).animate(
        CurvedAnimation(
            parent: _controller,
            curve: Interval(0.5, 0.7, curve: Curves.elasticInOut)));

    _clippedPlanesScaleAnim = Tween<double>(begin: 1.0, end: 0.3).animate(
        CurvedAnimation(parent: _controller, curve: Interval(0.5, 0.8)));

    _clippedNotificationScaleAnim = Tween<double>(begin: 35.0, end: 45.0)
        .animate(
            CurvedAnimation(parent: _controller, curve: Interval(0.7, 0.8)));

    _clippedPlanesColorAnim =
        ColorTween(begin: Colors.pink[300], end: Colors.black).animate(
            CurvedAnimation(parent: _controller, curve: Interval(0.5, 1.0)));

    _selectedPlanColorAnim =
        ColorTween(begin: Colors.blue[800], end: Colors.pink[300]).animate(
            CurvedAnimation(
                parent: _controller,
                curve: Interval(0.0, 0.3, curve: Curves.elasticInOut)));
  }

  @override
  Widget build(BuildContext context) {
    TextStyle whiteTextTheme =
        Theme.of(context).textTheme.button.copyWith(color: Colors.white);

    return Scaffold(
      body: SafeArea(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Column(
              children: <Widget>[
                Container(
                  height: 50.0,
                  child: _getSelectedPlan(),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.only(bottom: 30.0),
                    color: Colors.black12,
                    child: Center(
                      child: Wrap(
                        alignment: WrapAlignment.center,
                        spacing: 5.0,
                        children: _getUnselectedPlan(),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  _getSelectedPlan() {
    if (selectedPlan.length == 0) {
      return RectGetter(
        key: firstPlanKey,
        child: Center(
            child: Text(
          "Planes seleccionados ",
          style: Theme.of(context).textTheme.title,
        )),
      );
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Transform.translate(
          offset: getSelPlanesMoveOffset(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: selectedPlan.map((planes) {
              return Transform(
                transform: Matrix4.diagonal3Values(
                    getSelectedPlanScaleOffset(planes.id), 1.0, 1.0),
                child: RectGetter(
                  key: planes.key,
                  child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: SelectedPlanesChip(
                        planes: planes,
                        color: _getSelectedPlanColor(planes.id),
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
              "+$noClippedSelectedPlan",
              style: whiteTextTheme,
            ),
          ),
        ),
      );
    }
    return Container();
}
  _getUnselectedPlan() {
    return allPlanes.map((planes) {
      return RectGetter(
        key: planes.key,
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: Transform.translate(
            offset: getOffsetValue(planes.id),
            child: Transform.scale(
              scale: getScaleValue(planes.id),
              child: SelectablePlanesChip(
                planes: planes,
                color: getSelectablePlanColor(planes.id),
                onPressed: (id) => _chipPressed(id),
              ),
            ),
          ),
        ),
      );
    }).toList();
  }
    _chipPressed(int id) async {
    var planes = service.allPlanes.firstWhere((ing) => ing.id == id);

    var planesBeginRect = RectGetter.getRectFromKey(planes.key);
    var planesEndRect;
    if (selectedPlan.length > 0) {
      var firstSelectedPlan = selectedPlan[0];
      planesEndRect =
          RectGetter.getRectFromKey(firstSelectedPlan.key);
    } else {
      planesEndRect = RectGetter.getRectFromKey(firstPlanKey);
    }

    setState(() {
      selectedId = id;
      planesStartOffset = planesBeginRect.center;
    });

    setupMovementAnimation(planesBeginRect, planesEndRect);

    await _controller.forward();

    Planes selIng = new Planes(planes.id, planes.name);
    planes.width = RectGetter.getRectFromKey(planes.key).width;

    if (cleanupTimer != null) {
      cleanupTimer.cancel();
    }

    setState(() {
      selectedId = null;
      planes.name = "";
      cleanupTimer = new Timer(new Duration(seconds: 2), () => _timerCleanup());
      selectedPlan.insert(0, selIng);
    });

    cleanupSelectedPlan();
    _controller.reset();
  }
    getOffsetValue(int id) {
    if (selectedId != null && selectedId == id) {
      var offset = _moveAnimation.value.center - planesStartOffset;
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
  getSelPlanesMoveOffset() {
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
  void cleanupSelectedPlan() {
    var screenWidth = MediaQuery.of(context).size.width;

    var totalWidth = 0.0;
    selectedPlan.forEach((planes) {
      var rect = RectGetter.getRectFromKey(planes.key);
      if (rect != null) totalWidth += rect.width;
    });

    if (totalWidth >= screenWidth - 200.0) {
      setState(() {
        noClippedSelectedPlan+= 1;
        showCounter = true;
      });
      selectedPlan.removeLast();
    }
  }
  getSelectedPlanScaleOffset(int id) {
    if (id == selectedPlan.last.id && noClippedSelectedPlan > 0) {
      return _clippedPlanesScaleAnim.value;
    }
    return 1.0;
  }
  _getSelectedPlanColor(int id) {
    if (id == selectedPlan.last.id && noClippedSelectedPlan > 0) {
      return _clippedPlanesColorAnim.value;
    }
    return Colors.pink[300];
  }
  void _timerCleanup() {
    var toCleanupCount =
        allPlanes.where((ing) => ing.name.isEmpty).toList().length;
    if (toCleanupCount > 0) {
      setState(() {
        allPlanes.removeWhere((ing) => ing.name.isEmpty);
        planesFound = new Random().nextInt(2000);
      });
    }
  }
  getSelectablePlanColor(int id) {
    if (selectedId != null && selectedId == id) {
      return _selectedPlanColorAnim.value;
    }
    return Colors.blue[800];
  }

    }