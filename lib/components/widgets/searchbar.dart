import 'package:flutter/material.dart';

class SearchBar extends StatefulWidget {
  SearchBar({Key key}) : super(key: key);

  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  String inputvalue = '';
  final TextEditingController controller = new TextEditingController();
  void onChanged(String value) {}
  void onSubmitted(String value) {
    setState(() {
      inputvalue = inputvalue + value;
      controller.text = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 357,
      height: 46,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(23.0),color: Colors.white ),
      child: Row(
        children: <Widget>[
          new Expanded(
            child: new TextField(
              decoration: new InputDecoration(
                
                hintText: 'Buscar planes o lugares',
                prefixIcon: Icon(
                  Icons.search,
                ),
              ),
              onSubmitted: (String value) {
                onChanged(value);
              },
              controller: controller,
            ),
          ),
        ],
      ),
    );
  }
}
