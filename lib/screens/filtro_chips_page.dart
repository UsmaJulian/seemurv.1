import 'package:flutter/material.dart';
import 'package:seemur_v1/components/widgets/ambientes_widget.dart';
import 'package:seemur_v1/components/widgets/bares_discotecas_widget.dart';
import 'package:seemur_v1/components/widgets/boton_filtrar_widget.dart';
import 'package:seemur_v1/components/widgets/comodidades_widget.dart';
import 'package:seemur_v1/components/widgets/restaurantes_widget.dart';
import 'package:seemur_v1/screens/abierto.dart';
import 'package:seemur_v1/screens/formasdepago.dart';
import 'package:seemur_v1/screens/rangoprecios.dart';

class FiltroChipsPage extends StatefulWidget {
  FiltroChipsPage({
    Key key,
  }) : super(key: key);

  @override
  _FiltroChipsPageState createState() => _FiltroChipsPageState();
}

class _FiltroChipsPageState extends State<FiltroChipsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            AmbientesWidget(),
            RestaurantesWidget(),
            BaresDiscotecasWidget(),
            ComodidadesWidget(),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Align(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: <Widget>[
                      SizedBox(
                        width: 20.0,
                      ),
                      Text(
                        "Abierto Hasta",
                        style: TextStyle(
                          fontFamily: 'HankenGrotesk',
                          color: Color(0xff000000),
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          fontStyle: FontStyle.normal,
                          letterSpacing: -0.1000000014901161,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(height: 240, child: AbiertoRadioListBuilder()),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Align(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: <Widget>[
                      SizedBox(
                        width: 20.0,
                      ),
                      Text(
                        "Rango de precios por persona",
                        style: TextStyle(
                          fontFamily: 'HankenGrotesk',
                          color: Color(0xff000000),
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          fontStyle: FontStyle.normal,
                          letterSpacing: -0.1000000014901161,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(height: 70, child: RangoPreciosPage()),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Align(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: <Widget>[
                      SizedBox(
                        width: 20.0,
                      ),
                      Text(
                        "Formas de pago",
                        style: TextStyle(
                          fontFamily: 'HankenGrotesk',
                          color: Color(0xff000000),
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          fontStyle: FontStyle.normal,
                          letterSpacing: -0.1000000014901161,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(height: 200, child: FormasPagoCheckListBuilder()),
              ],
            ),
            BotonFiltrar(),
            SizedBox(
              height: 50.0,
            )
          ],
        ),
      ),
    );
  }
}
