import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:rect_getter/rect_getter.dart';
import 'package:seemur_v1/components/widgets/ambienteseleccionableboton.dart';
import 'package:seemur_v1/services/filtros/ambiente_services.dart';

class AmbienteSelectionScreen extends StatefulWidget {
  _AmbienteSelectionScreenState createState() => _AmbienteSelectionScreenState();
}

class _AmbienteSelectionScreenState extends State<AmbienteSelectionScreen>
    with SingleTickerProviderStateMixin {
  AmbienteService service = AmbienteService();
  List<Ambiente> allAmbientes, selectedAmbiente;
  AnimationController _controller;
  Animation<Rect> _moveAnimation;
  Animation<Offset> _siMoveAnimation;
  Animation<double> _scaleAnimation,
      _clippedAmbienteScaleAnim,
      _clippedNotificationScaleAnim;
  Animation<Color> _clippedAmbienteColorAnim, _selectedAmbienteColorAnim;
  int selectedId, ambienteFound = 0;
  Offset ambienteStartOffset;

  Timer cleanupTimer;

  bool showCounter = false;
  int noClippedSelectedAmbiente = 0;

  var firstAmbienteKey = RectGetter.createGlobalKey();

  @override
  List<String> getSelectedAmbientes() {

    List<String> listAmbientes = [];
    if(service.selectedAmbiente.length==0){
      listAmbientes=[];
    }else{

      service.selectedAmbiente.forEach((data){
        listAmbientes.add(data.name);
      });

    }

    return listAmbientes;
  }

  @override
  void initState() {
    super.initState();
    allAmbientes = service.allAmbiente;
    selectedAmbiente = service.selectedAmbiente;
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));

    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.5).animate(
        CurvedAnimation(
            parent: _controller,
            curve: Interval(0.5, 0.7, curve: Curves.elasticInOut)));

    _clippedAmbienteScaleAnim = Tween<double>(begin: 1.0, end: 0.3).animate(
        CurvedAnimation(parent: _controller, curve: Interval(0.5, 0.8)));

    _clippedNotificationScaleAnim = Tween<double>(begin: 35.0, end: 45.0)
        .animate(
            CurvedAnimation(parent: _controller, curve: Interval(0.7, 0.8)));

    _clippedAmbienteColorAnim =
        ColorTween(begin: Color(0xfff8c300), end: Colors.black).animate(
            CurvedAnimation(parent: _controller, curve: Interval(0.5, 1.0)));

    _selectedAmbienteColorAnim =
        ColorTween(begin: Color(0xff16202c), end: Color(0xfff8c300)).animate(
            CurvedAnimation(
                parent: _controller,
                curve: Interval(0.0, 0.3, curve: Curves.elasticInOut)));
  }

  @override
  Widget build(BuildContext context) {

    getSelectedAmbientes();

    TextStyle whiteTextTheme =
        Theme.of(context).textTheme.button.copyWith(color: Colors.white);

    return Scaffold(
      body: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Column(
            children: <Widget>[
              Container(
                height: 50.0,
                child: _getSelectedAmbiente(),
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
                      children: _getUnselectedAmbiente(),
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

  _getSelectedAmbiente() {
    if (selectedAmbiente.length == 0) {
      return RectGetter(
        key: firstAmbienteKey,
        child: Center(
            child: Text(
          "Ambientes seleccionados ",
          style: Theme.of(context).textTheme.title,
        )),
      );
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Transform.translate(
          offset: getSelAmbienteMoveOffset(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: selectedAmbiente.map((ambiente) {
              return Transform(
                transform: Matrix4.diagonal3Values(
                    getSelectedAmbienteScaleOffset(ambiente.id), 1.0, 1.0),
                child: RectGetter(
                  key: ambiente.key,
                  child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: SelectedAmbienteChip(
                        ambiente: ambiente,
                        color: _getSelectedAmbienteColor(ambiente.id),
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
              "+$noClippedSelectedAmbiente",
              style: whiteTextTheme,
            ),
          ),
        ),
      );
    }
    return Container();
  }

  _getUnselectedAmbiente() {
    return allAmbientes.map((ambiente) {
      return RectGetter(
        key: ambiente.key,
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: Transform.translate(
            offset: getOffsetValue(ambiente.id),
            child: Transform.scale(
              scale: getScaleValue(ambiente.id),
              child: SelectableAmbienteChip(
                ambiente: ambiente,
                color: getSelectableAmbienteColor(ambiente.id),
                onPressed: (id) => _chipPressed(id),
              ),
            ),
          ),
        ),
      );
    }).toList();
  }

  _chipPressed(int id) async {
    var ambiente = service.allAmbiente.firstWhere((ing) => ing.id == id);

    var ambienteBeginRect = RectGetter.getRectFromKey(ambiente.key);
    var ambienteEndRect;
    if (selectedAmbiente.length > 0) {
      var firstSelectedAmbiente = selectedAmbiente[0];
      ambienteEndRect = RectGetter.getRectFromKey(firstSelectedAmbiente.key);
    } else {
      ambienteEndRect = RectGetter.getRectFromKey(firstAmbienteKey);
    }

    setState(() {
      selectedId = id;
      ambienteStartOffset = ambienteBeginRect.center;
    });

    setupMovementAnimation(ambienteBeginRect, ambienteEndRect);

    await _controller.forward();

    Ambiente selIng = new Ambiente(ambiente.id, ambiente.name);
    ambiente.width = RectGetter.getRectFromKey(ambiente.key).width;

    if (cleanupTimer != null) {
      cleanupTimer.cancel();
    }

    setState(() {
      selectedId = null;
      ambiente.name = "";
      cleanupTimer = new Timer(new Duration(seconds: 2), () => _timerCleanup());
      selectedAmbiente.insert(0, selIng);
    });

    cleanupSelectedAmbiente();
    _controller.reset();
  }

  getOffsetValue(int id) {
    if (selectedId != null && selectedId == id) {
      var offset = _moveAnimation.value.center - ambienteStartOffset;
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

  getSelAmbienteMoveOffset() {
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

  void cleanupSelectedAmbiente() {
    var screenWidth = MediaQuery.of(context).size.width;

    var totalWidth = 0.0;
    selectedAmbiente.forEach((ambiente) {
      var rect = RectGetter.getRectFromKey(ambiente.key);
      if (rect != null) totalWidth += rect.width;
    });

    if (totalWidth >= screenWidth - 200.0) {
      setState(() {
        noClippedSelectedAmbiente += 1;
        showCounter = true;
      });
      selectedAmbiente.removeLast();
    }
  }

  getSelectedAmbienteScaleOffset(int id) {
    if (id == selectedAmbiente.last.id && noClippedSelectedAmbiente > 0) {
      return _clippedAmbienteScaleAnim.value;
    }
    return 1.0;
  }

  _getSelectedAmbienteColor(int id) {
    if (id == selectedAmbiente.last.id && noClippedSelectedAmbiente > 0) {
      return _clippedAmbienteColorAnim.value;
    }
    return Color(0xfff8c300);
  }

  void _timerCleanup() {
    var toCleanupCount =
        allAmbientes.where((ing) => ing.name.isEmpty).toList().length;
    if (toCleanupCount > 0) {
      setState(() {
        allAmbientes.removeWhere((ing) => ing.name.isEmpty);
        ambienteFound = new Random().nextInt(2000);
      });
    }
  }

  getSelectableAmbienteColor(int id) {
    if (selectedId != null && selectedId == id) {
      return _selectedAmbienteColorAnim.value;
    }
    return Colors.white;
  }
}
