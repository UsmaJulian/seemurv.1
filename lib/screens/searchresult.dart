import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SearchResult extends StatefulWidget {
  final element;
  SearchResult({this.element});
  _SearchResultState createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResult> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firestore.instance
          .collection('client')
          //.where('tasktags', arrayContains: widget.data)
          .getDocuments(),
      builder: (BuildContext context, snapshot) {
        return ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            return Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                elevation: 2.0,
                child: Container(
                    child: Center(
                        child: Text(
                  snapshot.data.documents[index]['taskname'],
                  // snapshot.data.documents[index]['tasktags'][index].toString(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ))));
          },
          itemCount: snapshot.data.documents.length,
        );
      },
    );
  }
}
