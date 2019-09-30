import 'package:flutter/material.dart';

class CheckListBuilder extends StatefulWidget {
  final int num;

  const CheckListBuilder({Key key, this.num}) : super(key: key);

  @override
  CheckListBuilderState createState() {
    return CheckListBuilderState();
  }
}

class CheckListBuilderState extends State<CheckListBuilder> {
  String _currText = '';
  bool _isSelected = false;

  List<String> _group = [
    "Efectivo",
    "T. Crédito",
    "T. Débito",
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxHeight: 30),
      child: Column(
        children: <Widget>[
          Center(
            child: Text(_currText,
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                )),
          ),
          Column(
            children: _group
                .map((
                  text,
                ) =>
                    Card(
                      child: CheckboxListTile(
                        checkColor: Colors.yellowAccent, // color of tick Mark
                        activeColor: Colors.white,
                        title: Text(text),
                        value: _isSelected,
                        onChanged: (
                          bool value,
                        ) {
                          setState(() {
                            if (_group.length > 1) {
                              _group.removeAt(0);
                              _currText = text;
                            }
                            _isSelected = false;
                          });
                        },
                      ),
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }
}
