import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ConfigurarPage extends StatelessWidget {
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
          child: Text('Permitir acceso a',
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
      body: Column(
        children: <Widget>[
          Card(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 66.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 32.0),
                    child: Text('Ubicación',
                        style: TextStyle(
                          fontFamily: 'OpenSans',
                          color: Color(0xff3d3d3d),
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.normal,
                        )),
                  ),
                  Transform.scale(
                    scale: 1.5,
                    child: Switch(
                      activeColor: Color(0xfff5af00),
                      value: false,
                      onChanged: (value) {},
                    ),
                  )
                ],
              ),
            ),
          ),
          Card(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 66.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 32.0),
                    child: Text('Notificaciones',
                        style: TextStyle(
                          fontFamily: 'OpenSans',
                          color: Color(0xff3d3d3d),
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.normal,
                        )),
                  ),
                  Transform.scale(
                    scale: 1.5,
                    child: Switch(
                      activeColor: Color(0xfff5af00),
                      value: false,
	                    onChanged: (value) {
		
	                    },
                    ),
                  )
                ],
              ),
            ),
          ),
          Card(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 66.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 32.0),
                    child: Text('Galería de fotos',
                        style: TextStyle(
                          fontFamily: 'OpenSans',
                          color: Color(0xff3d3d3d),
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.normal,
                        )),
                  ),
                  Transform.scale(
                    scale: 1.5,
                    child: Switch(
                      activeColor: Color(0xfff5af00),
                      value: false,
                      onChanged: (value) {},
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
