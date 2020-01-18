import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:seemur_v1/auth/auth.dart';
import 'package:seemur_v1/components/widgets/searchbar.dart';
import 'package:seemur_v1/models/user_model.dart';
import 'package:seemur_v1/utilidades/constantes.dart';

class Filtrosresult extends StatefulWidget {
  final BaseAuth auth;
  final miplans;
  final misAmbients;
  final misrestaurantes;
  final misBares;
  final misCaracteristicas;
  final mishoras;
  final misRangoPrecios;

  Filtrosresult({this.auth,
	  this.miplans,
	  this.misAmbients,
	  this.misrestaurantes,
	  this.misBares,
	  this.misCaracteristicas,
	  this.mishoras,
	  this.misRangoPrecios});

  @override
  _FiltrosresultState createState() => _FiltrosresultState();
}

class _FiltrosresultState extends State<Filtrosresult>
    with WidgetsBindingObserver {
  final databaseReference = Firestore.instance;
  String usuario = 'Usuario'; //user
  String usuarioEmail = 'Email'; //userEmail
  String id;
  final formKey = GlobalKey<FormState>();
  String _itemCiudad;
  List<DropdownMenuItem<String>> _ciudadItems;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
    widget.auth.infoUser().then((onValue) {
      setState(() {
        usuario = onValue.displayName;
        usuarioEmail = onValue.email;
        id = onValue.uid;
        print('ID $id');

        _ciudadItems = getCiudadItems();
        _itemCiudad = _ciudadItems[0].value;
      });
    });
  }

  getData() async {
    return await Firestore.instance.collection('ciudades').getDocuments();
  }

  //Dropdownlist from firestore
  List<DropdownMenuItem<String>> getCiudadItems() {
    List<DropdownMenuItem<String>> items = List();
    QuerySnapshot dataCiudades;
    getData().then((data) {
      dataCiudades = data;
      dataCiudades.documents.forEach((obj) {
        print('${obj.documentID} ${obj['nombre']}');
        items.add(DropdownMenuItem(
          value: obj.documentID,
          child: Text(obj['nombre'],
              style: TextStyle(
                fontFamily: 'OpenSans',
                color: Color(0xffffffff),
                fontSize: 14,
                fontWeight: FontWeight.w400,
                fontStyle: FontStyle.normal,
                letterSpacing: 0,
              )),
        ));
      });
    }).catchError((error) => print('hay un error.....' + error));

    items.add(DropdownMenuItem(
      value: '0',
      child: Text('Ciudad ',
          style: TextStyle(
            fontFamily: 'OpenSans',
            color: Color(0xffffffff),
            fontSize: 14,
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.normal,
            letterSpacing: 0,
          )),
    ));

    return items;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: new BoxDecoration(color: Color(0xff16202c)),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 0, top: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Text(
                          "¿Cuál es tu plan?",
                          style: TextStyle(
                            fontFamily: 'HankenGrotesk',
                            color: Color(0xffffffff),
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                            fontStyle: FontStyle.normal,
                            letterSpacing: -0.4000000059604645,
                          ),
                        ),
                        FutureBuilder(
                          future: usersRef.document(id).get(),
                          builder:
                              (BuildContext context, AsyncSnapshot snapshot) {
                            if (!snapshot.hasData) {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            }

                            Usuario usuario = Usuario.fromDoc(snapshot.data);

                            return CircleAvatar(
                                radius: 40.0,
                                backgroundColor: Colors.grey,
		                            backgroundImage: usuario.profileImageUrl.isEmpty
                                    ? AssetImage(
                                        'assets/images/Contenedordeimagenes.jpg')
				                            : CachedNetworkImageProvider(
				                            usuario.profileImageUrl));
                          },
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 0, left: 0.0, right: 201.0),
                    child: SizedBox(
                      width: 100,
                      child: Theme(
                        data: Theme.of(context).copyWith(
                          canvasColor: Color(0xff16202c),
                        ),
                        child: DropdownButtonFormField(
                          decoration: InputDecoration(
                              border: InputBorder.none, isDense: true),

                          validator: (value) => value == '0'
                              ? 'Debe seleccionar una ciudad'
                              : null,

                          value: _itemCiudad,

                          items: _ciudadItems,

                          onChanged: (value) {
                            setState(() {
                              _itemCiudad = value;
                            });
                          },

                          //seleccionarCiudadItem,

                          onSaved: (value) => _itemCiudad = value,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Column(
                      children: <Widget>[
                        SearchBar(),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 12.0,
                  ),
                ],
              ),
            ),
            StreamBuilder(
                stream: Firestore.instance
                    .collection('client')
                //.where('taskenvironments',
                //  arrayContainsAny: widget.misAmbients)
//                    .where('taskservices',
//                        isGreaterThanOrEqualTo: widget.misrestaurantes)
                //.where('tasktags', isEqualTo: widget.misBares)
//                  .where('taskfeatures',
//                        isLessThan: widget.misCaracteristicas)
//                    .where('tasktime', isEqualTo: widget.mishoras)
                //.where('taskprice', isEqualTo: widget.misRangoPrecios)
//                 .where('taskpayment', isGreaterThanOrEqualTo:[(widget.newList.toString().replaceAll("[", "").replaceAll("]", ""))])
                    .snapshots(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data != null) {
                      return Flexible(
                        child: ListView.builder(
                          itemCount: snapshot.data.documents.length,
                          itemBuilder: (BuildContext context, index) {
                            return Column(
                              children: <Widget>[
                                Text(snapshot.data.documents[index]['taskname']
                                    .toString()),
	                              Text(snapshot.data.documents[index]['taskplans']
			                              .toString()),
	                              Text(snapshot
			                              .data.documents[index]['taskenvironments']
			                              .toString()),
	                              Text(snapshot
			                              .data.documents[index]['taskservices']
			                              .toString()),
	                              Divider()
                              ],
                            );
                          },
                        ),
                      );
                    } else {
                      return Padding(
                        padding: const EdgeInsets.only(top: 28),
                        child: Center(child: new CircularProgressIndicator()),
                      );
                    }
                  }
                  return Text('');
                }),
          ],
        ),
      ),
    );
  }
}
