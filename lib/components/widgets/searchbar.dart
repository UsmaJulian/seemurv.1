import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:seemur_v1/screens/filtros.dart';
import 'package:seemur_v1/screens/searchresult.dart';
import 'package:seemur_v1/services/searchservice.dart';

class SearchBar extends StatefulWidget {
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  String inputval = '';
  final TextEditingController controller = new TextEditingController();
  var queryResultSet = [];
  var tempSearchStore = [];

  initiateSearch(val) {
    if (val.length == 0) {
      setState(() {
        queryResultSet = [];
        tempSearchStore = [];
      });
    }

    var capitalizedValue = val.substring(0, 1).toUpperCase() + val.substring(1);

    if (queryResultSet.length == 0 && val.length == 1) {
      SearchService().searchByString(val).then((QuerySnapshot docs) {
        for (int i = 0; i < docs.documents.length; ++i) {
          queryResultSet.add(docs.documents[i].data);
        }
      });
    } else {
      tempSearchStore = [];
      queryResultSet.forEach((element) {
        if (element['taskname'].startsWith(capitalizedValue)) {
          setState(() {
            tempSearchStore.add(element);
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width * 0.87,
          height: MediaQuery.of(context).size.width * 0.12,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: new BorderRadius.circular(23),
              border: Border.all(
                color: Colors.transparent,
              )),
          child: new TextField(
            decoration: new InputDecoration(
              border: InputBorder.none,
              hintText: 'Buscar planes o lugares',
              prefixIcon: Icon(
                Icons.search,
              ),
            ),

            onChanged: (val) {
              initiateSearch(val);
            },

            // onSubmitted: (val) {

            //   SearchResult();

            //   setState(() {

            //     inputval = inputval + val;

            //     controller.text = "";

            //   });

            // },

            controller: controller,
          ),
        ),
        Positioned(
          top: 6,
          right: 6,
          bottom: 6,
          left: 220.0,
          child: Container(
            height: MediaQuery.of(context).size.height * 0.055,
            width: MediaQuery.of(context).size.width * 0.25,
            decoration: BoxDecoration(
              border: Border.all(width: 0, style: BorderStyle.none),
              borderRadius: BorderRadius.horizontal(
                  left: Radius.circular(22), right: Radius.circular(22)),
              gradient: LinearGradient(
                colors: [new Color(0xFFFFE231), new Color(0xFFF5AF00)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: FlatButton(
              child: Text('Filtros',
                  style: new TextStyle(
                    color: Colors.black,
                    fontFamily: 'HankenGrotesk',
                    fontSize: 15.0,
                    fontWeight: FontWeight.w700,
                  )),
              onPressed: () {
                Navigator.push(context,
                    new MaterialPageRoute(builder: (context) => FiltrosPage()));
              },
            ),
          ),
        ),
      ],
    );
  }
}
