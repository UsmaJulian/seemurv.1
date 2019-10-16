import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SearchResult extends StatefulWidget {
  SearchResult();

  _SearchResultState createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResult> {
  List<DocumentSnapshot> documents;
  Future getTaskList() async {
    QuerySnapshot tasklist =
        await Firestore.instance.collection('client').getDocuments();

    documents = tasklist.documents;

    return tasklist;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getTaskList(),
      builder: (BuildContext context, snapshot) {
        var itemcount = documents?.length;
        int end = itemcount;
        return ListView.builder(
          itemCount: snapshot.data.documents.length - 1,
          itemBuilder: (BuildContext context, int index) {
            DocumentSnapshot lista = snapshot.data.documents[index];
            return Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                elevation: 2.0,
                child: Container(
                    child: Center(
                        child: Text(
                  lista['tasktags'][index],
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
