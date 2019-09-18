import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HostalesPage extends StatefulWidget {
  _HostalesPageState createState() => _HostalesPageState();
}

class _HostalesPageState extends State<HostalesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(107.0),
        child: AppBar(
          centerTitle: true,
          automaticallyImplyLeading: false,
          backgroundColor: Color.fromRGBO(22, 32, 44, 1),
          title: Padding(
            padding: const EdgeInsets.only(top: 30.0),
            child: Text(
              'Hostales',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          leading: Padding(
            padding: const EdgeInsets.only(top: 22.0),
            child: new IconButton(
              icon: new Icon(
                CupertinoIcons.back,
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
        ),
      ),
      body: ListHostales(),
    );
  }
}

class ListHostales extends StatefulWidget {
  // ListBaresPage({Key key}) : super(key: key);

  _ListHostalesState createState() => _ListHostalesState();
}

class _ListHostalesState extends State<ListHostales> {
  Future getClient() async {
    print('hola');
    var firestore = Firestore.instance;

    QuerySnapshot qn = await firestore
        .collection('client')
        .where('tasktags', arrayContains: 'Hostales')
        .getDocuments();
    return qn.documents;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
        future: getClient(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Text('Cargando Datos...'),
            );
          } else {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, index) {
                return ListTile(
                    title: Text(
                  snapshot.data[index].data['taskname'],
                ));
              },
            );
          }
        },
      ),
    );
  }
}
