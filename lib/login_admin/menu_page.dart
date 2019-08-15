import 'package:flutter/material.dart';
//import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:seemur_v1/auth/auth.dart';

import 'package:seemur_v1/components/widgets/leading_page.dart';
import 'package:seemur_v1/login_admin/contentPage.dart';

const PrimaryColor = const Color(0xFF19212B);

class MenuPage extends StatefulWidget {
  MenuPage({this.auth, this.onSignedOut});
  
  final BaseAuth auth;
  final VoidCallback onSignedOut;
  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  String usuario = 'Usuario'; //user
  String usuarioEmail = 'Email'; //userEmail
  String id;

  Content page = ContentPage();

  Widget contentPage = LeadingPage(); //Pagina principal recetas

  void _signOut() async {
    try {
      widget.auth.signOut();
      widget.onSignedOut();
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    widget.auth.infoUser().then((onValue) {
      setState(() {
        usuario = onValue.displayName;
        usuarioEmail = onValue.email;
        id = onValue.uid;
        print('ID $id');
      });
    });
  }

  //from now you can see the code in Github of all this
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // drawer: Drawer(
      //     elevation: 30.0,
      //     child: Container(
      //       color: Color(0xFF19212B),
      //       child: ListView(
      //         children: <Widget>[
      //           UserAccountsDrawerHeader(
      //             currentAccountPicture: CircleAvatar(
      //               maxRadius: 10.0,
      //               backgroundImage: AssetImage('assets/images/cocina.jpg'),
      //               //backgroundImage: NetworkImage('https://abc'),
      //             ),
      //             accountName: Text(
      //               '$usuario',
      //               style: TextStyle(
      //                 color: Colors.white,
      //               ),
      //             ),
      //             accountEmail: Text('$usuarioEmail',
      //                 style: TextStyle(color: Colors.white)),
      //             decoration: BoxDecoration(
      //                 color: Color(0xFF262F3D),
      //                 image: DecorationImage(
      //                   alignment: Alignment(1.0, 0),
      //                   image: AssetImage(
      //                     'assets/images/misanplas.jpg',
      //                   ),
      //                   fit: BoxFit.scaleDown, //BoxFit.fitHeight
      //                 )),
      //           ),

      //           ListTile(
      //             onTap: () {
      //               Navigator.of(context).pop();
      //               page.lista().then((value) {
      //                 print(value);
      //                 setState(() {
      //                   contentPage = value;
      //                 });
      //               });
      //             },
      //             leading: Icon(
      //               Icons.home,
      //               color: Color(0xFF4FC3F7),
      //             ),
      //             title: Text(
      //               'Home',
      //               style: TextStyle(color: Colors.white),
      //             ),
      //           ),
      //           Divider(
      //             height: 2.0,
      //             color: Colors.white,
      //           ),
      //           // ListTile(
      //           //   onTap: () {
      //           //     Navigator.of(context).pop();
      //           //     page.personalclient(id).then((value) {
      //           //       print(value);
      //           //       setState(() {
      //           //         contentPage = value;
      //           //       });
      //           //     });
      //           //   },
      //           //   leading: Icon(
      //           //     FontAwesomeIcons.pizzaSlice,
      //           //     color: Color(0xFF4FC3F7),
      //           //   ),
      //           //   title: Text(
      //           //     'My Recipe',
      //           //     style: TextStyle(color: Color(0xFF4FC3F7)),
      //           //   ),
      //           // ),
      //           ListTile(
      //             onTap: () {
      //               Navigator.of(context).pop();
      //               page.admin().then((value) {
      //                 print(value);
      //                 setState(() {
      //                   contentPage = value;
      //                 });
      //               });
      //             },
      //             leading: Icon(
      //               Icons.contact_mail,
      //               color: Color(0xFF4FC3F7),
      //             ),
      //             title: Text(
      //               'Admin',
      //               style: TextStyle(color: Color(0xFF4FC3F7)),
      //             ),
      //           ),
      //           // ListTile(
      //           //   onTap: () {
      //           //     Navigator.of(context).pop();
      //           //      page.mapa().then((value) {
      //           //       print(value);
      //           //       setState(() {
      //           //         contentPage = value;
      //           //       });
      //           //     });
      //           //   },
      //           //   leading: Icon(FontAwesomeIcons.map, color: Color(0xFF4FC3F7),),
      //           //   title: Text('Mapa Tiendas', style: TextStyle(color: Color(0xFF4FC3F7)),),
      //           // ),
      //           ListTile(
      //             title: Text(
      //               'Salir',
      //               style: TextStyle(color: Color(0xFF4FC3F7)),
      //             ),
      //             leading: Icon(
      //               Icons.exit_to_app,
      //               color: Color(0xFF4FC3F7),
      //             ),
      //             onTap: () {
      //               Navigator.of(context).pop();
      //               _signOut();
      //             },
      //           ),
      //         ],
      //       ),
      //     )),
      // appBar: AppBar(
      //   backgroundColor: PrimaryColor,
      //   title: Text('Clientes'),
      //   actions: <Widget>[
      //     IconButton(
      //       icon: Icon(Icons.grid_on),
      //       tooltip: 'Grid',
      //       onPressed: () {
      //         //   Route route = MaterialPageRoute(builder: (context) => GridPageInicio());
      //         //  Navigator.push(context, route);
      //       },
      //     ),
      //   ],
      // ),
      body: contentPage,
    );
  }
}