import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:rect_getter/rect_getter.dart';
import 'package:seemur_v1/components/widgets/baresdiscotecasseleccionableboton.dart';
import 'package:seemur_v1/services/filtros/BaresDiscotecasCervecerias_services.dart';

class BarDiscoCervSelectionScreen extends StatefulWidget {
  _BarDiscoCervSelectionScreenState createState() =>
      _BarDiscoCervSelectionScreenState();
}

class _BarDiscoCervSelectionScreenState
    extends State<BarDiscoCervSelectionScreen>
    with SingleTickerProviderStateMixin {
  BarDiscoCervService service = BarDiscoCervService();
  List<BarDiscoCerv> allBarDiscoCerv, selectedBarDiscoCerv;
  AnimationController _controller;
  Animation<Rect> _moveAnimation;
  Animation<Offset> _siMoveAnimation;
  Animation<double> _scaleAnimation,
      _clippedBarDiscoCervScaleAnim,
      _clippedNotificationScaleAnim;
  Animation<Color> _clippedBarDiscoCervColorAnim,
      _selectedBarDiscoCervColorAnim;
  int selectedId, bardiscocervFound = 0;
  Offset bardiscocervStartOffset;

  Timer cleanupTimer;

  bool showCounter = false;
  int noClippedSelectedBarDiscoCerv = 0;

  var firstBarDiscoCervKey = RectGetter.createGlobalKey();

  @override
  void initState() {
    super.initState();
    allBarDiscoCerv = service.allBarDiscoCerv;
    selectedBarDiscoCerv = service.selectedBarDiscoCerv;
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));

    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.5).animate(
        CurvedAnimation(
            parent: _controller,
            curve: Interval(0.5, 0.7, curve: Curves.elasticInOut)));

    _clippedBarDiscoCervScaleAnim = Tween<double>(begin: 1.0, end: 0.3).animate(
        CurvedAnimation(parent: _controller, curve: Interval(0.5, 0.8)));

    _clippedNotificationScaleAnim = Tween<double>(begin: 35.0, end: 45.0)
        .animate(
            CurvedAnimation(parent: _controller, curve: Interval(0.7, 0.8)));

    _clippedBarDiscoCervColorAnim =
        ColorTween(begin: Color(0xfff8c300), end: Colors.black).animate(
            CurvedAnimation(parent: _controller, curve: Interval(0.5, 1.0)));

    _selectedBarDiscoCervColorAnim =
        ColorTween(begin: Color(0xff16202c), end: Color(0xfff8c300)).animate(
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
                  child: _getSelectedBarDiscoCerv(),
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
                        children: _getUnselectedBarDiscoCerv(),
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

  _getSelectedBarDiscoCerv() {
    if (selectedBarDiscoCerv.length == 0) {
      return RectGetter(
        key: firstBarDiscoCervKey,
        child: Center(
            child: Text(
          "Bares y discotecas seleccionados ",
          style: Theme.of(context).textTheme.title,
        )),
      );
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Transform.translate(
          offset: getSelBarDiscoCervMoveOffset(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: selectedBarDiscoCerv.map((bardiscocerv) {
              return Transform(
                transform: Matrix4.diagonal3Values(
                    getSelectedBarDiscoCervScaleOffset(bardiscocerv.id),
                    1.0,
                    1.0),
                child: RectGetter(
                  key: bardiscocerv.key,
                  child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: SelectedBarDiscoCervChip(
                        bardiscocerv: bardiscocerv,
                        color: getSelectableBarDiscoCervColor(bardiscocerv.id),
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
              "+$noClippedSelectedBarDiscoCerv",
              style: whiteTextTheme,
            ),
          ),
        ),
      );
    }
    return Container();
  }

  _getUnselectedBarDiscoCerv() {
    return allBarDiscoCerv.map((bardiscocerv) {
      return RectGetter(
        key: bardiscocerv.key,
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: Transform.translate(
            offset: getOffsetValue(bardiscocerv.id),
            child: Transform.scale(
              scale: getScaleValue(bardiscocerv.id),
              child: SelectableBarDiscotecaChip(
                bardiscocerv: bardiscocerv,
                color: getSelectableBarDiscoCervColor(bardiscocerv.id),
                onPressed: (id) => _chipPressed(id),
              ),
            ),
          ),
        ),
      );
    }).toList();
  }

  _chipPressed(int id) async {
    var bardiscocerv =
        service.allBarDiscoCerv.firstWhere((ing) => ing.id == id);

    var bardiscocervBeginRect = RectGetter.getRectFromKey(bardiscocerv.key);
    var bardiscocervEndRect;
    if (selectedBarDiscoCerv.length > 0) {
      var firstSelectedBarDiscoCerv = selectedBarDiscoCerv[0];
      bardiscocervEndRect =
          RectGetter.getRectFromKey(firstSelectedBarDiscoCerv.key);
    } else {
      bardiscocervEndRect = RectGetter.getRectFromKey(firstBarDiscoCervKey);
    }

    setState(() {
      selectedId = id;
      bardiscocervStartOffset = bardiscocervBeginRect.center;
    });

    setupMovementAnimation(bardiscocervBeginRect, bardiscocervEndRect);

    await _controller.forward();

    BarDiscoCerv selIng = new BarDiscoCerv(bardiscocerv.id, bardiscocerv.name);
    bardiscocerv.width = RectGetter.getRectFromKey(bardiscocerv.key).width;

    if (cleanupTimer != null) {
      cleanupTimer.cancel();
    }

    setState(() {
      selectedId = null;
      bardiscocerv.name = "";
      cleanupTimer = new Timer(new Duration(seconds: 2), () => _timerCleanup());
      selectedBarDiscoCerv.insert(0, selIng);
    });

    cleanupSelectedBarDiscoCerv();
    _controller.reset();
  }

  getOffsetValue(int id) {
    if (selectedId != null && selectedId == id) {
      var offset = _moveAnimation.value.center - bardiscocervStartOffset;
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

  getSelBarDiscoCervMoveOffset() {
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

  void cleanupSelectedBarDiscoCerv() {
    var screenWidth = MediaQuery.of(context).size.width;

    var totalWidth = 0.0;
    selectedBarDiscoCerv.forEach((bardiscocerv) {
      var rect = RectGetter.getRectFromKey(bardiscocerv.key);
      if (rect != null) totalWidth += rect.width;
    });

    if (totalWidth >= screenWidth - 200.0) {
      setState(() {
        noClippedSelectedBarDiscoCerv += 1;
        showCounter = true;
      });
      selectedBarDiscoCerv.removeLast();
    }
  }

  getSelectedBarDiscoCervScaleOffset(int id) {
    if (id == selectedBarDiscoCerv.last.id &&
        noClippedSelectedBarDiscoCerv > 0) {
      return _clippedBarDiscoCervScaleAnim.value;
    }
    return 1.0;
  }

  _getSelectedPlanColor(int id) {
    if (id == selectedBarDiscoCerv.last.id &&
        noClippedSelectedBarDiscoCerv > 0) {
      return _clippedBarDiscoCervColorAnim.value;
    }
    return Color(0xfff8c300);
  }

  void _timerCleanup() {
    var toCleanupCount =
        allBarDiscoCerv.where((ing) => ing.name.isEmpty).toList().length;
    if (toCleanupCount > 0) {
      setState(() {
        allBarDiscoCerv.removeWhere((ing) => ing.name.isEmpty);
        bardiscocervFound = new Random().nextInt(2000);
      });
    }
  }

  getSelectableBarDiscoCervColor(int id) {
    if (selectedId != null && selectedId == id) {
      return _selectedBarDiscoCervColorAnim.value;
    }
    return Colors.white;
  }
}
