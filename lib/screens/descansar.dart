import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:seemur_v1/components/widgets/navigatorbar.dart';
import 'package:seemur_v1/screens/subcatscreens/chalets.dart';
import 'package:seemur_v1/screens/subcatscreens/hospedajes.dart';
import 'package:seemur_v1/screens/subcatscreens/hostales.dart';
import 'package:seemur_v1/screens/subcatscreens/hoteles.dart';

class CommonThings {
  static Size size; //size screen
}

class DescansarPage extends StatefulWidget {
  //ComerPage({Key key}) : super(key: key);

  _DescansarPageState createState() => _DescansarPageState();
}

class _DescansarPageState extends State<DescansarPage> {
  @override
  Widget build(BuildContext context) {
    CommonThings.size = MediaQuery.of(context).size;
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
              'Descansar',
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
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            Positioned(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 48.0, left: 24, right: 195.0),
                    child: Text('Sugerencias para ti',
                        style: TextStyle(
                          fontFamily: 'HankenGrotesk',
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.normal,
                          letterSpacing: -0.1,
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
                              Container(
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    Container(
                                      width: 105,
                                      height: 92,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              new BorderRadius.circular(6),
                                          color: Color(0xff16202c),
                                        ),
                                        child: Center(
                                          child: Wrap(
                                            children: <Widget>[
                                              FlatButton(
                                                child: Image.asset(
                                                  'assets/images/hotelIcon@3x.png',
                                                  width: 38,
                                                  height: 38,
                                                ),
                                                onPressed: () {
                                                  Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              HotelesPage()));
                                                },
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Text('Hoteles',
                                        style: TextStyle(
                                          fontFamily: 'HankenGrotesk',
                                          color: Color(0xff000000),
                                          fontSize: 15,
                                          fontWeight: FontWeight.w700,
                                          fontStyle: FontStyle.normal,
                                          letterSpacing: -0.5,
                                        )),
                                    Text('7 lugares',
                                        style: TextStyle(
                                          fontFamily: 'OpenSans',
                                          color: Color(0xff3d3d3d),
                                          fontSize: 11,
                                          fontWeight: FontWeight.w400,
                                          fontStyle: FontStyle.normal,
                                          letterSpacing: 0.2000000029802322,
                                        ))
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 12.0,
                              ),
                              Container(
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    Container(
                                      width: 105,
                                      height: 92,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              new BorderRadius.circular(6),
                                          color: Color(0xff16202c),
                                        ),
                                        child: Center(
                                          child: Wrap(
                                            children: <Widget>[
                                              SizedBox(
                                                height: 92,
                                                width: 105,
                                                child: FlatButton(
                                                  child: Image.asset(
                                                    'assets/images/hostelIcon@3x.png',
                                                    width: 38,
                                                    height: 38,
                                                  ),
                                                  onPressed: () {
                                                    Navigator.of(context).push(
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                HostalesPage()));
                                                  },
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Text('Hostales',
                                        style: TextStyle(
                                          fontFamily: 'HankenGrotesk',
                                          color: Color(0xff000000),
                                          fontSize: 15,
                                          fontWeight: FontWeight.w700,
                                          fontStyle: FontStyle.normal,
                                          letterSpacing: -0.5,
                                        )),
                                    Text('5 lugares',
                                        style: TextStyle(
                                          fontFamily: 'OpenSans',
                                          color: Color(0xff3d3d3d),
                                          fontSize: 11,
                                          fontWeight: FontWeight.w400,
                                          fontStyle: FontStyle.normal,
                                          letterSpacing: 0.2000000029802322,
                                        ))
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 12.0,
                              ),
                              Container(
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    Container(
                                      width: 105,
                                      height: 92,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              new BorderRadius.circular(6),
                                          color: Color(0xff16202c),
                                        ),
                                        child: Center(
                                          child: Wrap(
                                            children: <Widget>[
                                              SizedBox(
                                                height: 92,
                                                width: 105,
                                                child: FlatButton(
                                                  child: Image.asset(
                                                    'assets/images/innIcon@3x.png',
                                                    width: 38,
                                                    height: 38,
                                                  ),
                                                  onPressed: () {
                                                    Navigator.of(context).push(
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                HospedajesPage()));
                                                  },
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Text('Hospedajes',
                                        style: TextStyle(
                                          fontFamily: 'HankenGrotesk',
                                          color: Color(0xff000000),
                                          fontSize: 15,
                                          fontWeight: FontWeight.w700,
                                          fontStyle: FontStyle.normal,
                                          letterSpacing: -0.5,
                                        )),
                                    Text('3 lugares',
                                        style: TextStyle(
                                          fontFamily: 'OpenSans',
                                          color: Color(0xff3d3d3d),
                                          fontSize: 11,
                                          fontWeight: FontWeight.w400,
                                          fontStyle: FontStyle.normal,
                                          letterSpacing: 0.2000000029802322,
                                        ))
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 12.0,
                              ),
                              Container(
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    Container(
                                      width: 105,
                                      height: 92,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              new BorderRadius.circular(6),
                                          color: Color(0xff16202c),
                                        ),
                                        child: Center(
                                          child: Wrap(
                                            children: <Widget>[
                                              SizedBox(
                                                height: 92,
                                                width: 105,
                                                child: FlatButton(
                                                  child: Image.asset(
                                                    'assets/images/chaletIcon@3x.png',
                                                    width: 38,
                                                    height: 38,
                                                  ),
                                                  onPressed: () {
                                                    Navigator.of(context).push(
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                ChaletsPage()));
                                                  },
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Text('Chalets',
                                        style: TextStyle(
                                          fontFamily: 'HankenGrotesk',
                                          color: Color(0xff000000),
                                          fontSize: 15,
                                          fontWeight: FontWeight.w700,
                                          fontStyle: FontStyle.normal,
                                          letterSpacing: -0.5,
                                        )),
                                    Text('2 lugares',
                                        style: TextStyle(
                                          fontFamily: 'OpenSans',
                                          color: Color(0xff3d3d3d),
                                          fontSize: 11,
                                          fontWeight: FontWeight.w400,
                                          fontStyle: FontStyle.normal,
                                          letterSpacing: 0.2000000029802322,
                                        ))
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
            ),
            Positioned(
              child: Padding(
                padding: EdgeInsets.only(
                  top: 288.0,
                ),
                child: Column(
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 50.0,
                      decoration: new BoxDecoration(
                        color: Colors.white,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 15.0, left: 24),
                        child: Text('Lugares',
                            style: TextStyle(
                              fontFamily: 'HankenGrotesk',
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.normal,
                              letterSpacing: -0.5,
                            )),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              child: Padding(
                padding: EdgeInsets.only(
                  top: 352.0,
                ),
                child: Column(
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 50.0,
                      decoration: new BoxDecoration(
                        color: Colors.white,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 15.0, left: 24),
                        child: Text('Lugares Cerrados',
                            style: TextStyle(
                              fontFamily: 'HankenGrotesk',
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.normal,
                              letterSpacing: -0.5,
                            )),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              child: Padding(
                padding: const EdgeInsets.only(top: 608.0),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 90,
                  child: NavigatorBar(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
