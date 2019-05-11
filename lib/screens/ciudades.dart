import 'package:flutter/material.dart';
import 'package:seemur_v1/screens/onboard.dart';


class Ciudades extends StatefulWidget {
  Ciudades({Key key,}):super(key: key);
  @override
  _CiudadesState createState() => new _CiudadesState();
 }
class _CiudadesState extends State<Ciudades> {
  int _radioValue1=-1;
  void _handleRadioValueChange1(int e){
    setState(() {
      if (e==1){
     _radioValue1= 1;
      } else if (e==2){
       _radioValue1=2; 
      }else if (e==3){
        _radioValue1=3;
      }
    });
  }
    @override
  Widget build(BuildContext context) {
   return new Scaffold(
     //appBar: AppBar(),
     body: new Container(
       padding: EdgeInsets.all(8.0),
       child:  new Column(
         mainAxisAlignment: MainAxisAlignment.center,
         children: <Widget>[
           new Text(''),
           new Padding(
             padding: new EdgeInsets.all(8.0),
           ),
          new Padding(
             padding: new EdgeInsets.all(8.0),
           ),
             new Text('¿En que ciudad estas?', style:new TextStyle(
               fontSize: 18.0,fontWeight: FontWeight.bold,
             ),
           ),
           new Padding(
             padding: new EdgeInsets.all(8.0),
           ),
             new Text('Selecciona tu ubicación para descubrir los mejores planes y eventos cerca de ti', style:new TextStyle(
               fontSize: 18.0,fontWeight: FontWeight.bold,
             ),
             ),
             new Divider(height: 5.0,color: Colors.black,),
             new Padding(
               padding: EdgeInsets.all(8.0),
             ),
             new Row(
               mainAxisAlignment: MainAxisAlignment.center,
               children: <Widget>[
                 new Text('Manizales',style: new TextStyle(
               fontSize: 18.0, fontWeight: FontWeight.bold,
             ),
             ),
                 new Radio(
                   value: 1,
                   groupValue: _radioValue1,
                   onChanged:(int e)=> _handleRadioValueChange1 (e),
                 ),
              ],
             ),
             new Divider(height: 5.0,color: Colors.black,),
             new Padding(
               padding: EdgeInsets.all(8.0),
             ),
             new Row(
               mainAxisAlignment: MainAxisAlignment.center,
               children: <Widget>[
                 new Text('Bogotá',style: new TextStyle(
               fontSize: 18.0, fontWeight: FontWeight.bold,
             ),
             ),
                 new Radio(
                   value: 2,
                   groupValue: _radioValue1,
                   onChanged:(int e)=> _handleRadioValueChange1 (e),
                 ),
               ],
             ),
             new Divider(height: 5.0,color: Colors.black,),
             new Padding(
               padding: EdgeInsets.all(8.0),
             ),
             new Row(
               mainAxisAlignment: MainAxisAlignment.center,
               children: <Widget>[
                 new Text('Medellín',style: new TextStyle(
               fontSize: 18.0, fontWeight: FontWeight.bold,
             ),
             ),
                 new Radio(
                   value: 3,
                   groupValue: _radioValue1,
                   onChanged:(int e)=> _handleRadioValueChange1 (e),
                 ),
               ],
             ),
             new Divider(height: 5.0,color: Colors.black,),
             new Padding(
               padding: EdgeInsets.all(8.0),
             ),
             new Text('Podrás cambiar la ubicación cuando desees en los ajustes de perfil', style:new TextStyle(
               fontSize: 18.0,fontWeight: FontWeight.bold,
             ),
             ),
              new Divider(height: 5.0,color: Colors.white,),
             new Padding(
               padding: EdgeInsets.all(8.0),
             ),
             new RaisedButton(
        child: new Text("Continuar"),
         onPressed: () {
           Navigator.push(context, 
           new MaterialPageRoute(builder: (context) =>new LoginFacebookPage())
           );
         },
      ),
         ],
       ),
     ),
  
   );
  }
}