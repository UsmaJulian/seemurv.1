import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CheckListBuilder extends StatefulWidget {
  final int num;

  const CheckListBuilder({Key key, this.num});

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

  @override
  Future<String> getPagos() async {
	  SharedPreferences prefs = await SharedPreferences.getInstance();
	
	  String pagos = await prefs.getString('hola');
	
	  return pagos;
  }

  List<String> _group = [];

  String myselection() {
    return _group.toString().replaceAll("[", "").replaceAll("]", "");
  }

  @override
  Widget build(BuildContext context) {
	  print(myselection());
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
							  onChanged: (bool value,) {
								  setState(() {
									  _currText = "Efectivo";
									  setPagos(_currText);
									  _isSelectedCash = value;
									  if (_isSelectedCash) {
										  _group.add(_currText);
									  } else {
										  _group.remove(_currText);
									  }
								  });
							  },
						  ),
						  CheckboxListTile(
							  checkColor: Colors.yellowAccent,
							  // color of tick Mark
							  activeColor: Colors.white,
							  title: Text("Tarjetas"),
							  value: _isSelectedCardCredit,
							  onChanged: (bool value,) {
								  setState(() {
									  _currText = "Tarjetas";
									  setPagos(_currText);
									  _isSelectedCardCredit = value;
									  if (_isSelectedCardCredit) {
										  _group.add(_currText);
									  } else {
										  _group.remove(_currText);
									  }
								  });
							  },
						  ),
						  CheckboxListTile(
							  checkColor: Colors.yellowAccent,
							  // color of tick Mark
							  activeColor: Colors.white,
							  title: Text("Bitcoins"),
							  value: _isSelectedCardDebit,
							  onChanged: (bool value,) {
								  setState(() {
									  _currText = "Bitcoins";
									  setPagos(_currText);
									  _isSelectedCardDebit = value;
									  if (_isSelectedCardDebit) {
										  _group.add(_currText);
									  } else {
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

  void setPagos(String _currText) async {
	  SharedPreferences prefs = await SharedPreferences.getInstance();
	  await prefs.setString('formas de pagos', _currText);
  }
}
