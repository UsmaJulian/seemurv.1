import 'package:flutter/material.dart';
import 'package:seemur_v1/screens/abierto.dart';
import 'package:seemur_v1/screens/ambientescreen.dart';
import 'package:seemur_v1/screens/bardiscocervscreen.dart';
import 'package:seemur_v1/screens/caracteristicasscreen.dart';
import 'package:seemur_v1/screens/filterbuttons.dart';
import 'package:seemur_v1/screens/formasdepago.dart';
import 'package:seemur_v1/screens/rangoprecios.dart';
import 'package:seemur_v1/screens/restaurantesscreen.dart';

class FiltrosPage extends StatefulWidget {
	
	@override
	_FiltrosPageState createState() => _FiltrosPageState();
}

class _FiltrosPageState extends State<FiltrosPage> {
	@override
	void initState() {
		setState(() {
		
		});
		super.initState();
	}
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text('Filtros',
            style: TextStyle(
              fontFamily: 'HankenGrotesk',
              color: Color(0xffffffff),
              fontSize: 15,
              fontWeight: FontWeight.w700,
              fontStyle: FontStyle.normal,
              letterSpacing: -0.5,
            )),
        backgroundColor: Color(0xff16202c),
        actions: <Widget>[
          FlatButton(
            child: Text('Cerrar',
                style: TextStyle(
                  fontFamily: 'HankenGrotesk',
                  color: Color(0xffffffff),
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  fontStyle: FontStyle.normal,
                  letterSpacing: 0,
                )),
            onPressed: () {
              Navigator.of(context).pop();
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
	          // Padding(
	          //   padding: const EdgeInsets.only(top: 32.0, right: 250.0),
	          //   child: Text(
	          //     'Planes',
	          //     style: TextStyle(
	          //       fontFamily: 'HankenGrotesk',
	          //       color: Color(0xff000000),
	          //       fontSize: 20,
	          //       fontWeight: FontWeight.w700,
	          //       fontStyle: FontStyle.normal,
	          //       letterSpacing: -0.1000000014901161,
	          //     ),
	          //   ),
	          // ),
	          //Container(height: 250, child: PlanesSelectionScreen()),
            Padding(
              padding: const EdgeInsets.only(right: 210.0),
              child: Text(
                'Ambientes',
                style: TextStyle(
                  fontFamily: 'HankenGrotesk',
                  color: Color(0xff000000),
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  fontStyle: FontStyle.normal,
                  letterSpacing: -0.1000000014901161,
                ),
              ),
            ),
            Container(height: 250, child: AmbienteSelectionScreen()),
            Padding(
              padding: const EdgeInsets.only(right: 180.0),
              child: Text(
                'Restaurantes',
                style: TextStyle(
                  fontFamily: 'HankenGrotesk',
                  color: Color(0xff000000),
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  fontStyle: FontStyle.normal,
                  letterSpacing: -0.1000000014901161,
                ),
              ),
            ),
            Container(height: 240, child: RestauranteSelectionScreen()),
            Padding(
              padding: const EdgeInsets.only(right: 120.0),
              child: Text(
                'Bares y discotecas',
                style: TextStyle(
                  fontFamily: 'HankenGrotesk',
                  color: Color(0xff000000),
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  fontStyle: FontStyle.normal,
                  letterSpacing: -0.1000000014901161,
                ),
              ),
            ),
            Container(height: 320, child: BarDiscoCervSelectionScreen()),
            Padding(
              padding: const EdgeInsets.only(top: 28, right: 160.0),
              child: Text(
                'Comodidades',
                style: TextStyle(
                  fontFamily: 'HankenGrotesk',
                  color: Color(0xff000000),
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  fontStyle: FontStyle.normal,
                  letterSpacing: -0.1000000014901161,
                ),
              ),
            ),
            Container(height: 340, child: CaracteristicaSelectionScreen()),
            Padding(
              padding:
                  const EdgeInsets.only(top: 28, right: 160.0, bottom: 24.0),
              child: Text(
                'Abierto hasta',
                style: TextStyle(
                  fontFamily: 'HankenGrotesk',
                  color: Color(0xff000000),
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  fontStyle: FontStyle.normal,
                  letterSpacing: -0.1000000014901161,
                ),
              ),
            ),
            Container(height: 240, child: RadioListBuilder()),
            Padding(
              padding: const EdgeInsets.only(top: 0, right: 40.0, bottom: 24.0),
              child: Text(
                'Rango de precios por persona',
                style: TextStyle(
                  fontFamily: 'HankenGrotesk',
                  color: Color(0xff000000),
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  fontStyle: FontStyle.normal,
                  letterSpacing: -0.1000000014901161,
                ),
              ),
            ),
            Container(height: 80, child: RangoPreciosPage()),
            Padding(
              padding: const EdgeInsets.only(top: 0, right: 40.0, bottom: 24.0),
              child: Text(
                'Formas de pago en el sitio',
                style: TextStyle(
                  fontFamily: 'HankenGrotesk',
                  color: Color(0xff000000),
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  fontStyle: FontStyle.normal,
                  letterSpacing: -0.1000000014901161,
                ),
              ),
            ),
            Container(height: 215, child: CheckListBuilder()),
            Padding(
              padding: const EdgeInsets.only(bottom: 24.0),
            ),
            Container(
                child: FiltrosBotones(
	                //PlanesSelectionScreen(),
                    AmbienteSelectionScreen(),
                    RestauranteSelectionScreen(),
                    BarDiscoCervSelectionScreen(),
		                CaracteristicaSelectionScreen(),
		                RadioListBuilder(),
		                RangoPreciosPage(),
		                CheckListBuilder())),
            SizedBox(
              width: 300,
              height: 50,
            )
          ],
        ),
      ),
    );
  }
}
