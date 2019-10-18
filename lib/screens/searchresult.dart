import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SearchResult extends StatefulWidget {
  SearchResult({this.data});
  final data;

  _SearchResultState createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResult> {
  Future getTaskList() async {
    QuerySnapshot tasklist =
        await Firestore.instance.collection('client').getDocuments();

    return tasklist;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getTaskList(),
      builder: (BuildContext context, snapshot) {
        return ListView.builder(
          itemCount: snapshot.data.documents.length,
          itemBuilder: (BuildContext context, int index) {
            DocumentSnapshot lista = snapshot.data.documents[index];
            return Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                elevation: 2.0,
                child: Container(
                    child: Center(
                        child: Text(
                  lista['taskname'][index].toString(),
                  // snapshot.data.documents[index]['tasktags'][index].toString(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ))));
          },
        );
      },
    );
  }
}
