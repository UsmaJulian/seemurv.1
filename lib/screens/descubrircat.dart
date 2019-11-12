import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:seemur_v1/components/widgets/clients_body.dart';

class DescubrircatPage extends StatefulWidget {
  final idcliente;
  DescubrircatPage({this.idcliente});
  _DescubrircatPageState createState() => _DescubrircatPageState();
}

class _DescubrircatPageState extends State<DescubrircatPage> {
  Widget build(BuildContext context) {
    var catnombre = widget.idcliente;
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
              widget.idcliente,
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
      body: DescCatBody(
        idcliente: catnombre,
      ),
    );
  }
}

class DescCatBody extends StatefulWidget {
  final idcliente;
  DescCatBody({this.idcliente});

  _DescCatBodyState createState() => _DescCatBodyState();
}

class _DescCatBodyState extends State<DescCatBody> {
  Future getClient() async {
    print('hola');
    var firestore = Firestore.instance;

    QuerySnapshot qn = await firestore
        .collection('client')
        .where('tasktags', arrayContains: widget.idcliente)
        .getDocuments();
    return qn.documents;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: getClient(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Text('Cargando Datos...'),
            );
          } else {
            return ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, index) {
                final datasnp = snapshot.data[index].data;
                return Container(
                  child: Card(
                    color: Color.fromRGBO(246, 247, 250, 5),
                    elevation: 1,
                    child: InkWell(
                      onTap: () {
                        //print('${snapshot.data[index].data['taskname']}');
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ClientBody(
                                    datos: datasnp,
                                  )),
                        );
                      },
                      child: Row(
                        children: <Widget>[
                          SizedBox(width: 30.0, height: 47.0),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: FadeInImage.assetNetwork(
                                width: 47,
                                height: 47,
                                fit: BoxFit.fill,
                                placeholder:
                                    ('assets/images/Contenedor de imagenes (375 x249).jpg'),
                                image: (snapshot.data[index].data['logos'])),
                          ),
                          SizedBox(
                            width: 21.0,
                            height: 47.0,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.6,
                            height: 72.0,
                            child: ListTile(
                              title: Container(
                                child: Text(
                                  snapshot.data[index].data['taskname'],
                                  style: TextStyle(
                                    fontFamily: 'HankenGrotesk',
                                    color: Color(0xff000000),
                                    fontSize: 15,
                                    fontWeight: FontWeight.w700,
                                    fontStyle: FontStyle.normal,
                                    letterSpacing: -0.5,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
