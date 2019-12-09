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
  bool _isSelectedCash = false;
  bool _isSelectedCardCredit = false;
  bool _isSelectedCardDebit = false;

  List<String> _group = [];

  String myselection(){
    return _group.toString().replaceAll("[", "").replaceAll("]", "");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxHeight: 30),
      child: Column(
        children: <Widget>[
          Center(
            child: Text(myselection(),
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                )),
          ),
          Column(
          children: <Widget>[

                       CheckboxListTile(
                      checkColor: Colors.yellowAccent,
                      // color of tick Mark
                      activeColor: Colors.white,
                      title: Text("Efectivo"),
                      value: _isSelectedCash,
                      onChanged: (
                        bool value,
                      ) {
                        setState(() {
                            _currText = "Efectivo";


                            _isSelectedCash = value;
                            if(_isSelectedCash){
                              _group.add(_currText);
                            }else{
                              _group.remove(_currText);
                            }

                        });
                      },
                    ),
            CheckboxListTile(
              checkColor: Colors.yellowAccent,
              // color of tick Mark
              activeColor: Colors.white,
              title: Text("T.Crédito"),
              value: _isSelectedCardCredit,
              onChanged: (
                  bool value,
                  ) {
                setState(() {
                  _currText = "T.Crédito";

                      _isSelectedCardCredit = value;
                  if(_isSelectedCardCredit){
                    _group.add(_currText);
                  }else{
                    _group.remove(_currText);
                  }
                });
              },
            ),

            CheckboxListTile(
              checkColor: Colors.yellowAccent,
              // color of tick Mark
              activeColor: Colors.white,
              title: Text("T.Débito"),
              value: _isSelectedCardDebit,
              onChanged: (
                  bool value,
                  ) {
                setState(() {

                    _currText = "T.Débito";


                    _isSelectedCardDebit = value;
                    if(_isSelectedCardDebit){
                      _group.add(_currText);
                    }else{
                      _group.remove(_currText);
                    }
                });
              },
            ),


          ],
          ),
        ],
      ),
    );
  }
}
