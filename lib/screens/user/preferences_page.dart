import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:seemur_v1/auth/auth.dart';
import 'package:seemur_v1/components/widgets/navigatorbar.dart';
import 'package:seemur_v1/screens/Informaciondestacada.dart';
import 'package:seemur_v1/screens/ayuda.dart';
import 'package:seemur_v1/screens/cuenta.dart';
import 'package:seemur_v1/screens/empresas.dart';
import 'package:seemur_v1/screens/splash_screen%20_one_loading.dart';
import 'package:share/share.dart';

class PreferencesPage extends StatefulWidget {
	PreferencesPage({this.auth, this.onSignOut});
	
	final BaseAuth auth;
	final VoidCallback onSignOut;
	
	@override
	_PreferencesPageState createState() => _PreferencesPageState();
}

class _PreferencesPageState extends State<PreferencesPage> {
	String usuario = 'Usuario'; //user
	String usuarioEmail = 'Email'; //userEmail
	String id;
	
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
	
	@override
	Widget build(BuildContext context) {
		void _signOut() async {
			try {
				await widget.auth.signOut();
				//onSignOut();
				Navigator.of(context).push(
						MaterialPageRoute(builder: (context) => SplashScreenOneLoading()));
			} catch (e) {
				print(e);
			}
		}
		
		return Scaffold(
			appBar: AppBar(
				automaticallyImplyLeading: false,
				leading: IconButton(icon: Icon(CupertinoIcons.back), onPressed: () {
					Navigator.pop(context);
				}),
				backgroundColor: Color.fromRGBO(22, 32, 44, 1),
				title: Center(
						child: Text('Ajustes', textAlign: TextAlign.center,
								style: TextStyle(
									fontFamily: 'HankenGrotesk',
									color: Color(0xffffffff),
									fontSize: 15,
									fontWeight: FontWeight.w700,
									fontStyle: FontStyle.normal,
									letterSpacing: -0.5,
								
								))),
			),
			
			body:
			// Column(
			//   children: <Widget>[
			//     Stack(
			//       children: <Widget>[
			SingleChildScrollView(
				child: ConstrainedBox(
					constraints:
					BoxConstraints(minHeight: MediaQuery
							.of(context)
							.size
							.height),
					child: IntrinsicHeight(
						child: Stack(
							children: <Widget>[
								Column(
									children: <Widget>[
										Expanded(
											child: Card(
												child: Container(
													height: 60.0,
													width: MediaQuery
															.of(context)
															.size
															.width,
													child: Row(
														children: <Widget>[
															SizedBox(
																width: 14.0,
																height: 60.0,
															),
															StreamBuilder(
																stream: Firestore.instance
																		.collection('usuarios')
																		.document(id)
																		.snapshots(),
																builder: (BuildContext context,
																		AsyncSnapshot snapshot) {
																	switch (snapshot.connectionState) {
																		case ConnectionState.none:
																		
																		case ConnectionState.waiting:
																			return new Text('loading...');
																		
																		default:
																			if (snapshot.hasError)
																				return new Text(
																						'Error: ${snapshot.error}');
																			else if (snapshot.hasData) {
																				return CircleAvatar(
																						radius: 20.0,
																						backgroundColor: Colors.black,
																						backgroundImage: snapshot
																								.data['imagen'].isEmpty
																								? AssetImage(
																								'assets/images/Contenedordeimagenes.jpg')
																								: CachedNetworkImageProvider(
																								snapshot.data['imagen']));
																			}
																	}
																	
																	return null;
																},
															),
															SizedBox(
																width: 24.0,
																height: 60.0,
															),
															Text('$usuario',
																	style: TextStyle(
																		fontFamily: 'HankenGrotesk',
																		color: Color(0xff000000),
																		fontSize: 14,
																		fontWeight: FontWeight.w700,
																		fontStyle: FontStyle.normal,
																		letterSpacing: -0.1000000014901161,
																	)),
														],
													),
												),
											),
										),
										Expanded(
											child: Card(
												child: Container(
													height: 60.0,
													width: MediaQuery
															.of(context)
															.size
															.width,
													child: new FlatButton(
															onPressed: () {
																Navigator.push(
																	context,
																	MaterialPageRoute(
																			builder: (context) =>
																					CuentaPage(
																						auth: Auth(),
																					)),
																);
															},
															child: Row(
																children: <Widget>[
																	Icon(
																		IconData(59558,
																				fontFamily: 'MaterialIcons'),
																		size: 15.0,
																		color: Color.fromRGBO(245, 175, 0, 1),
																	),
																	SizedBox(
																		width: 12.0,
																	),
																	Padding(
																		padding: const EdgeInsets.only(right: 190),
																		child: new Text('Cuenta',
																				style: new TextStyle(
																						fontSize: 14.0,
																						color: Colors.black)),
																	),
																	Icon(
																		CupertinoIcons.forward,
																		size: 16,
																		color: Colors.black,
																	),
																],
															)),
												),
											),
										),
										Expanded(
											child: Card(
												child: Container(
													height: 60.0,
													width: MediaQuery
															.of(context)
															.size
															.width,
													child: new FlatButton(
															onPressed: () {
																Navigator.push(
																	context,
																	MaterialPageRoute(
																			builder: (context) =>
																					InfoDestacadaPage(
																						auth: Auth(),
																					)),
																);
															},
															child: Row(
																children: <Widget>[
																	Icon(
																		Icons.star_border,
																		size: 20.0,
																		color: Color.fromRGBO(245, 175, 0, 1),
																	),
																	SizedBox(
																		width: 12.0,
																	),
																	Padding(
																		padding: const EdgeInsets.only(right: 87),
																		child: new Text('Información destacada',
																				style: new TextStyle(
																						fontSize: 14.0,
																						color: Colors.black)),
																	),
																	Icon(
																		CupertinoIcons.forward,
																		size: 16,
																		color: Colors.black,
																	),
																],
															)),
												),
											),
										),
										Expanded(
											child: Card(
												child: Container(
													height: 60.0,
													width: MediaQuery
															.of(context)
															.size
															.width,
													child: new FlatButton(
															onPressed: () {},
															// share(
															//     context,
															//     Text('texto a enviar en la invitacion'),
															//     Text('url')),
															child: Row(
																children: <Widget>[
																	Icon(
																		CupertinoIcons.heart,
																		size: 20.0,
																		color: Color.fromRGBO(245, 175, 0, 1),
																	),
																	SizedBox(
																		width: 12.0,
																	),
																	Padding(
																		padding: const EdgeInsets.only(right: 116),
																		child: new Text('Invitar a un amigo ',
																				style: new TextStyle(
																						fontSize: 14.0,
																						color: Colors.black)),
																	),
																	Icon(
																		CupertinoIcons.forward,
																		size: 16,
																		color: Colors.black,
																	),
																],
															)),
												),
											),
										),
										Expanded(
											child: Card(
												child: Container(
													height: 60.0,
													width: MediaQuery
															.of(context)
															.size
															.width,
													child: new FlatButton(
															onPressed: () {
																Navigator.push(
																	context,
																	MaterialPageRoute(
																			builder: (context) =>
																					EmpresasPage(
																						auth: Auth(),
																					)),
																);
															},
															child: Row(
																children: <Widget>[
																	Icon(
																		FontAwesomeIcons.building,
																		size: 20.0,
																		color: Color.fromRGBO(245, 175, 0, 1),
																	),
																	SizedBox(
																		width: 12.0,
																	),
																	Padding(
																		padding: const EdgeInsets.only(right: 169),
																		child: new Text('Empresas',
																				style: new TextStyle(
																						fontSize: 14.0,
																						color: Colors.black)),
																	),
																	Icon(
																		CupertinoIcons.forward,
																		size: 16,
																		color: Colors.black,
																	),
																],
															)),
												),
											),
										),
										Expanded(
											child: Card(
												child: Container(
													height: 60.0,
													width: MediaQuery
															.of(context)
															.size
															.width,
													child: new FlatButton(
															onPressed: () {
																Navigator.push(
																	context,
																	MaterialPageRoute(
																			builder: (context) =>
																					AyudaPage(
																						auth: Auth(),
																					)),
																);
															},
															child: Row(
																children: <Widget>[
																	Icon(
																		Icons.help_outline,
																		size: 20.0,
																		color: Color.fromRGBO(245, 175, 0, 1),
																	),
																	SizedBox(
																		width: 10.0,
																	),
																	Padding(
																		padding: const EdgeInsets.only(right: 196),
																		child: new Text('ayuda',
																				style: new TextStyle(
																						fontSize: 14.0,
																						color: Colors.black)),
																	),
																	Icon(
																		CupertinoIcons.forward,
																		size: 16,
																		color: Colors.black,
																	),
																],
															)),
												),
											),
										),
										Expanded(
											child: Card(
												child: Container(
													height: 60.0,
													width: MediaQuery
															.of(context)
															.size
															.width,
													child: new FlatButton(
															onPressed: _signOut,
															child: Row(
																children: <Widget>[
																	Icon(
																		Icons.exit_to_app,
																		size: 20.0,
																		color: Color.fromRGBO(245, 175, 0, 1),
																	),
																	SizedBox(
																		width: 12.0,
																	),
																	new Text('Cerrar Sesión',
																			style: new TextStyle(
																					fontSize: 14.0, color: Colors.black)),
																],
															)),
												),
											),
										),
										SizedBox(height: 70,)
									],
								),
								// Expanded(
								Positioned(
									bottom: 0,
									child: Container(
										width: MediaQuery
												.of(context)
												.size
												.width,
										height: 60,
										child: NavigatorBar(
												navCallback: (i) => print("Navigating to $i")),
									),
								),
							],
						),
					),
				),
			),
			// ],
			//),
			// Expanded(
			//   child: Container(
			//     width: MediaQuery.of(context).size.width,
			//     height: 60,
			//     child:
			//         NavigatorBar(navCallback: (i) => print("Navigating to $i")),
			// ),
			//  ),
			//  ],
			// ),
		);
	}
	
	share(BuildContext context, texto, enlace) {
		String text = texto;
		final RenderBox box = context.findRenderObject();
		Share.share(text,
				subject: enlace,
				sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
	}
}
