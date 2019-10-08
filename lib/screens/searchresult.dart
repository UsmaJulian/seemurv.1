import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SearchResult extends StatefulWidget {
  SearchResult();

  _SearchResultState createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResult> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Firestore.instance.collection('client').snapshots(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            return Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                elevation: 2.0,
                child: Container(
                    child: Center(
                        child: Text(
                  snapshot.data.documents['tasktags'],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                  ),
                ))));
            ;
          },
        );
      },
    );
  }
}
