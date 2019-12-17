import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RadioListBuilder extends StatefulWidget {
  final int num;


  const RadioListBuilder({Key key, this.num}) : super(key: key);



  @override
  RadioListBuilderState createState() {
    return RadioListBuilderState();
  }
}

class RadioListBuilderState extends State<RadioListBuilder> {
  int _currValue = 0;
  String _currText = '';

  List<GroupModel> _group = [
    GroupModel(
      text: "10 pm",
      index: 1,
    ),
    GroupModel(
      text: "2 am",
      index: 2,
    ),
    GroupModel(
      text: "Amanecer",
      index: 3,
    ),
  ];

  @override
  Future<String> getAbierto() async {
	  SharedPreferences prefs = await SharedPreferences.getInstance();
	  String abierto = await prefs.getString("horario");
	
	
	  return abierto;
  }

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
                .map((t) => Card(
                      child: RadioListTile(
                        activeColor: Color(0xfff8c300),
                        controlAffinity: ListTileControlAffinity.trailing,
                        title: Text("${t.text}"),
                        groupValue: _currValue,
                        value: t.index,
                        onChanged: (index) {
                          setState(() {
                            _currValue = index;
                            _currText = t.text;
                            setHorario(_currText);
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

  void setHorario(String currText) async {
	  SharedPreferences prefs = await SharedPreferences.getInstance();
	  await prefs.setString('horario', currText);
  }
}

class GroupModel {
  String text;
  int index;
  GroupModel({this.text, this.index});
}
