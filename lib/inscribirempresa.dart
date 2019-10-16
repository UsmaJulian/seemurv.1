import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InscribirEmpresaPage extends StatefulWidget {
  InscribirEmpresaPage({Key key}) : super(key: key);

  _InscribirEmpresaPageState createState() => _InscribirEmpresaPageState();
}

class _InscribirEmpresaPageState extends State<InscribirEmpresaPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: new IconButton(
            icon: new Icon(
              CupertinoIcons.back,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
          backgroundColor: Color.fromRGBO(22, 32, 44, 1),
          title: Center(
              child: Padding(
            padding: const EdgeInsets.only(right: 50.0),
            child: Text('Inscribir mi empresa',
                style: TextStyle(
                  fontFamily: 'HankenGrotesk',
                  color: Color(0xffffffff),
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  fontStyle: FontStyle.normal,
                  letterSpacing: -0.5,
                )),
          )),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                height: 239,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(color: Color(0xffF6F7FA)),
                child: Column(
                  children: <Widget>[
                    Text("Making A New Trend ",
                        style: TextStyle(
                          fontFamily: 'HankenGrotesk',
                          color: Color(0xff000000),
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          fontStyle: FontStyle.normal,
                          letterSpacing: -0.1000000014901161,
                        )),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 485,
                decoration: new BoxDecoration(
                    color: Color(0xffffffff),
                    borderRadius: BorderRadius.circular(16)),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 32.0, left: 25.0, right: 25.0),
                      child: Container(
                        width: 326,
                        height: 15,
                        child: Text('Teléfono',
                            style: TextStyle(
                              fontFamily: 'HankenGrotesk',
                              color: Color(0xff3d3d3d),
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              fontStyle: FontStyle.normal,
                              letterSpacing: 0,
                            )),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 12.0,
                        left: 25.0,
                        right: 25.0,
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(width: 1, color: Colors.grey),
                            borderRadius: BorderRadius.horizontal(
                                left: Radius.circular(8),
                                right: Radius.circular(8)),
                            color: Color.fromRGBO(246, 247, 250, 1)),
                        child: Padding(
                          padding:
                              const EdgeInsets.only(left: 25.0, right: 25.0),
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              labelText: '(+57)',
                            ),
                            // validator: (value) =>
                            //     value.isEmpty ? 'El campo Email está vacio' : null,
                            //onSaved: (value) => _email = value.trim(),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 32.0, left: 25.0, right: 25.0),
                      child: Container(
                        width: 326,
                        height: 15,
                        child: Text('Empresa',
                            style: TextStyle(
                              fontFamily: 'HankenGrotesk',
                              color: Color(0xff3d3d3d),
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              fontStyle: FontStyle.normal,
                              letterSpacing: 0,
                            )),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 12.0,
                        left: 25.0,
                        right: 25.0,
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(width: 1, color: Colors.grey),
                            borderRadius: BorderRadius.horizontal(
                                left: Radius.circular(8),
                                right: Radius.circular(8)),
                            color: Color.fromRGBO(246, 247, 250, 1)),
                        child: Padding(
                          padding:
                              const EdgeInsets.only(left: 25.0, right: 25.0),
                          child: TextFormField(
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              labelText: 'Nombre',
                            ),
                            // validator: (value) =>
                            //     value.isEmpty ? 'El campo Email está vacio' : null,
                            //onSaved: (value) => _email = value.trim(),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 32.0, left: 25.0, right: 25.0),
                      child: Container(
                        width: 326,
                        height: 15,
                        child: Text('Mensaje',
                            style: TextStyle(
                              fontFamily: 'HankenGrotesk',
                              color: Color(0xff3d3d3d),
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              fontStyle: FontStyle.normal,
                              letterSpacing: 0,
                            )),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 12.0,
                        left: 25.0,
                        right: 25.0,
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(width: 1, color: Colors.grey),
                            borderRadius: BorderRadius.horizontal(
                                left: Radius.circular(8),
                                right: Radius.circular(8)),
                            color: Color.fromRGBO(246, 247, 250, 1)),
                        child: Padding(
                          padding:
                              const EdgeInsets.only(left: 25.0, right: 25.0),
                          child: Container(
                            width: 327,
                            height: 124,
                            child: TextFormField(
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                labelText: 'Escribe tú mensaje',
                              ),
                              // validator: (value) =>
                              //     value.isEmpty ? 'El campo Email está vacio' : null,
                              //onSaved: (value) => _email = value.trim(),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.only(
                            top: 16.0, bottom: 0, left: 15.0, right: 15.0),
                        child: Container(
                          width: 315.0,
                          height: 44.0,
                          decoration: BoxDecoration(
                            border:
                                Border.all(width: 0, style: BorderStyle.none),
                            borderRadius: BorderRadius.horizontal(
                                left: Radius.circular(22),
                                right: Radius.circular(22)),
                            gradient: LinearGradient(
                              colors: [
                                new Color(0xFFFFE231),
                                new Color(0xFFF5AF00)
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                          ),
                          child: new FlatButton(
                            child: new Text("Enviar",
                                style: new TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'HankenGrotesk',
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w700,
                                )),
                            onPressed: () {
                              // Navigator.push(
                              //   context,
                              //   new MaterialPageRoute(
                              //       builder: (context) => RootPage(
                              //             auth: Auth(),
                              //           )),
                              // );
                            },
                          ),
                        )),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
