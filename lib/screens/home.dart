import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:seemur_v1/auth/auth.dart';
import 'package:seemur_v1/components/widgets/navigatorbar.dart';
//import 'package:seemur_v1/components/widgets/searchbar.dart';

class HomePage extends StatefulWidget {
HomePage({this.auth});
final BaseAuth auth;  
@override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String usuario = 'Usuario'; //user
  String usuarioEmail = 'Email'; //userEmail
  String id;
  final formKey = GlobalKey<FormState>();
  String _itemCiudad;
  List<DropdownMenuItem<String>> _ciudadItems;
  
    @override
  void initState() {
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
          child: Text(obj['nombre']),
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

  Container Explorar(String imageVal, String planname, String cantporplan) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Container(
            width: 105,
            height: 92,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: new BorderRadius.circular(16),
                color: Color(0xff16202c),
              ),
              child: Center(
                child: Wrap(
                  children: <Widget>[
                    Image.asset(imageVal),
                  ],
                ),
              ),
            ),
          ),
          Text(planname,
              style: TextStyle(
                fontFamily: 'HankenGrotesk',
                color: Color(0xff000000),
                fontSize: 15,
                fontWeight: FontWeight.w700,
                fontStyle: FontStyle.normal,
                letterSpacing: -0.5,
              )),
          Text(cantporplan,
              style: TextStyle(
                fontFamily: 'OpenSans',
                color: Color(0xff3d3d3d),
                fontSize: 12,
                fontWeight: FontWeight.w400,
                fontStyle: FontStyle.normal,
                letterSpacing: 0.2000000029802322,
              ))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(children: <Widget>[
          Container(
            child: Column(
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 1472,
                  decoration: new BoxDecoration(color: Color(0xff16202c)),
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 66.0),
                        child: Row(
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
                            //agregar la imagen del usuario
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 240),
                        child: SizedBox(
                          width: 100,
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
                            }, //seleccionarCiudadItem,
                            onSaved: (value) => _itemCiudad = value,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.only(top:88.0),
          //   child: Container(child: SearchBar()),
          // ),
          Positioned(
            top: 233,
            left: 0,
            right: 0,
            child: Column(
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 1872,
                  decoration: new BoxDecoration(
                    color: Color(0xfff6f7fa),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 47.0, right: 275.0),
                        child: Text("Explorar",
                            style: TextStyle(
                              fontFamily: 'HankenGrotesk',
                              color: Color(0xff000000),
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              fontStyle: FontStyle.normal,
                              letterSpacing: -0.1000000014901161,
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 24.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(26)),
                              margin: EdgeInsets.symmetric(vertical: 30.0),
                              height: 125,
                              child: ListView(
                                scrollDirection: Axis.horizontal,
                                children: <Widget>[
                                  Explorar("assets/images/eatOutIcon.png",
                                      "Comer", "25 Lugares"),
                                  SizedBox(
                                    width: 12.0,
                                  ),
                                  Explorar("assets/images/partiyingIcon.png",
                                      "Festejar", "18 Lugares"),
                                  SizedBox(
                                    width: 12.0,
                                  ),
                                  Explorar("assets/images/afternoonIcon.png",
                                      "Tardear", "9 Lugares"),
                                  SizedBox(
                                    width: 12.0,
                                  ),
                                  Explorar("assets/images/restingIcon.png",
                                      "Descansar", "16 Lugares"),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 47.0, right: 180.0),
                        child: Text("Próximos eventos",
                            style: TextStyle(
                              fontFamily: 'HankenGrotesk',
                              color: Color(0xff000000),
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              fontStyle: FontStyle.normal,
                              letterSpacing: -0.1000000014901161,
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 24.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(26)),
                              margin: EdgeInsets.symmetric(vertical: 30.0),
                              height: 125,
                              child: ListView(
                                scrollDirection: Axis.horizontal,
                                children: <Widget>[
                                  Explorar("assets/images/eatOutIcon.png",
                                      "Comer", "25 Lugares"),
                                  SizedBox(
                                    width: 12.0,
                                  ),
                                  Explorar("assets/images/partiyingIcon.png",
                                      "Festejar", "18 Lugares"),
                                  SizedBox(
                                    width: 12.0,
                                  ),
                                  Explorar("assets/images/afternoonIcon.png",
                                      "Tardear", "9 Lugares"),
                                  SizedBox(
                                    width: 12.0,
                                  ),
                                  Explorar("assets/images/restingIcon.png",
                                      "Descansar", "16 Lugares"),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 47.0, right: 175.0),
                        child: Text("Restaurantes para ti",
                            style: TextStyle(
                              fontFamily: 'HankenGrotesk',
                              color: Color(0xff000000),
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              fontStyle: FontStyle.normal,
                              letterSpacing: -0.1000000014901161,
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 24.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(26)),
                              margin: EdgeInsets.symmetric(vertical: 30.0),
                              height: 125,
                              child: ListView(
                                scrollDirection: Axis.horizontal,
                                children: <Widget>[
                                  Explorar("assets/images/eatOutIcon.png",
                                      "Comer", "25 Lugares"),
                                  SizedBox(
                                    width: 12.0,
                                  ),
                                  Explorar("assets/images/partiyingIcon.png",
                                      "Festejar", "18 Lugares"),
                                  SizedBox(
                                    width: 12.0,
                                  ),
                                  Explorar("assets/images/afternoonIcon.png",
                                      "Tardear", "9 Lugares"),
                                  SizedBox(
                                    width: 12.0,
                                  ),
                                  Explorar("assets/images/restingIcon.png",
                                      "Descansar", "16 Lugares"),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 47.0, right: 104.0),
                        child: Text("Bares y discotecas para ti",
                            style: TextStyle(
                              fontFamily: 'HankenGrotesk',
                              color: Color(0xff000000),
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              fontStyle: FontStyle.normal,
                              letterSpacing: -0.1000000014901161,
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 24.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(26)),
                              margin: EdgeInsets.symmetric(vertical: 30.0),
                              height: 125,
                              child: ListView(
                                scrollDirection: Axis.horizontal,
                                children: <Widget>[
                                  Explorar("assets/images/eatOutIcon.png",
                                      "Comer", "25 Lugares"),
                                  SizedBox(
                                    width: 12.0,
                                  ),
                                  Explorar("assets/images/partiyingIcon.png",
                                      "Festejar", "18 Lugares"),
                                  SizedBox(
                                    width: 12.0,
                                  ),
                                  Explorar("assets/images/afternoonIcon.png",
                                      "Tardear", "9 Lugares"),
                                  SizedBox(
                                    width: 12.0,
                                  ),
                                  Explorar("assets/images/restingIcon.png",
                                      "Descansar", "16 Lugares"),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ), //Poner searchbar

          Positioned(
            top: 1395,
            left: 0,
            right: 0,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 90,
              child: NavigatorBar(),
            ),
          )
        ]),
      ),
    );
  }
}
