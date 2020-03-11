import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:seemur_v1/auth/auth.dart';
import 'package:seemur_v1/components/widgets/navigatorbar.dart';
import 'package:seemur_v1/components/widgets/searchbar.dart';
import 'package:seemur_v1/screens/bares_discos_recomendados.dart';
import 'package:seemur_v1/screens/comer.dart';
import 'package:seemur_v1/screens/descansar.dart';
import 'package:seemur_v1/screens/eventos.dart';
import 'package:seemur_v1/screens/festejar.dart';
import 'package:seemur_v1/screens/restaurantes_recomendados.dart';
import 'package:seemur_v1/screens/tardear.dart';
import 'package:seemur_v1/src/share_prefs/preferencias%20_usuario.dart';
import 'package:shared_preferences/shared_preferences.dart';

//import 'package:seemur_v1/components/widgets/searchbar.dart';

//final LocalStorage storage = new LocalStorage('userdata');
class HomePage extends StatefulWidget {
	static final String routeName = 'home';
	
	HomePage({this.auth});
	
	final BaseAuth auth;
	
	@override
	_HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
	final databaseReference = Firestore.instance;
	String usuario = 'Usuario'; //user
	String usuarioEmail = 'Email'; //userEmail
	String id;
	final formKey = GlobalKey<FormState>();
	String _itemCiudad;
	List<DropdownMenuItem<String>> _ciudadItems;
	var ciudaditemsel;
	
	@override
	void initState() {
		super.initState();
		cargarCiudadSeleccionada();
		widget.auth.infoUser().then((onValue) {
			setState(() {
				usuario = onValue.displayName;
				usuarioEmail = onValue.email;
				id = onValue.uid;
				print('ID $id');
			});
		});
	}
	
	cargarCiudadSeleccionada() async {
		SharedPreferences prefs = await SharedPreferences.getInstance();
		
		ciudaditemsel = prefs.getString('ciudad');
		setState(() {});
	}
	
	_setCiudadSeleccionada(ciudadSeleccionada) async {
		SharedPreferences prefs = await SharedPreferences.getInstance();
		prefs.setString('ciudad', ciudadSeleccionada);
		setState(() {
			ciudaditemsel = ciudadSeleccionada;
		});
	}
	
	final prefs = new PreferenciasUsuario();
	
	@override
	Widget build(BuildContext context,) {
		return Scaffold(
			body: GestureDetector(
				onTap: () {
					FocusScope.of(context).requestFocus(new FocusNode());
				},
				child: Stack(
					children: <Widget>[
						SingleChildScrollView(
							child: Stack(
								children: <Widget>[
									Container(
										child: Column(
											children: <Widget>[
												Container(
													width: MediaQuery
															.of(context)
															.size
															.width,
													height: 1180.0,
													decoration:
													new BoxDecoration(color: Color(0xff16202c)),
													child: Column(
														children: <Widget>[
															Padding(
																padding:
																const EdgeInsets.only(left: 0, top: 16.0),
																child: SingleChildScrollView(
																	scrollDirection: Axis.horizontal,
																	child: Row(
																		mainAxisAlignment:
																		MainAxisAlignment.spaceAround,
																		children: <Widget>[
																			Text(
																				"¿Cuál es tu plan?",
																				style: TextStyle(
																					fontFamily: 'HankenGrotesk',
																					color: Color(0xffffffff),
																					fontSize: 22,
																					fontWeight: FontWeight.w700,
																					fontStyle: FontStyle.normal,
																					letterSpacing: -0.4000000059604645,
																				),
																			),
																			SizedBox(
																				width: 20,
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
																										radius: 30.0,
																										backgroundColor:
																										Colors.black,
																										backgroundImage: snapshot
																												.data['imagen']
																												.isEmpty
																												? AssetImage(
																												'assets/images/Contenedordeimagenes.jpg')
																												: CachedNetworkImageProvider(
																												snapshot.data[
																												'imagen']));
																							}
																					}
																					return Container(
																					
																					);
																				},
																			),
																		],
																	),
																),
															),
//AGREGAR DROPDOWN
															
															StreamBuilder<QuerySnapshot>(
																	stream: Firestore.instance
																			.collection("ciudades")
																			.snapshots(),
																	builder: (context, snapshot) {
																		if (!snapshot.hasData)
																			const Text("Loading.....");
																		else {
																			List<DropdownMenuItem> ciudadItems = [];
																			for (int i = 0;
																			i < snapshot.data.documents.length;
																			i++) {
																				DocumentSnapshot snap =
																				snapshot.data.documents[i];
																				ciudadItems.add(
																					DropdownMenuItem(
																						child: Text(
																							snap.documentID,
																							style: TextStyle(
																									color: Colors.white),
																						),
																						value: "${snap.documentID}",
																					),
																				);
																			}
																			return Row(
																				mainAxisAlignment:
																				MainAxisAlignment.start,
																				children: <Widget>[
																					SizedBox(
																						width: 25.0,
																					),
																					SizedBox(
																							child: Theme(
																								data: Theme.of(context)
																										.copyWith(
																									canvasColor: Color(
																											0xff16202c),
																								),
																								child: DropdownButton(
																									items: ciudadItems,
																									onChanged: _setCiudadSeleccionada,
																									value: ciudaditemsel,
																									isExpanded: false,
																									hint: new Text(
																										"Selecciona una ciudad",
																										style: TextStyle(
																												color: Colors.white),
																									),
																								),
																							)),
																				],
																			);
																		}
																		return Text('cargando');
																	}),
															Padding(
																padding: const EdgeInsets.only(top: 20.0),
																child: Column(
																	children: <Widget>[
																		SearchBar(),
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
										top: 233,
										left: 0,
										right: 0,
										child: Column(
											children: <Widget>[
												Container(
													width: MediaQuery
															.of(context)
															.size
															.width,
													// height: 1872,
													decoration: new BoxDecoration(
														color: Color(0xfff6f7fa),
														borderRadius: BorderRadius.circular(10),
													),
													child: Column(
														mainAxisAlignment: MainAxisAlignment.start,
														children: <Widget>[
															Padding(
																padding: const EdgeInsets.only(
																	left: 24.0, top: 47.0,),
																child: Align(
																	alignment: AlignmentDirectional.centerStart
																	,
																	child: AutoSizeText("Explorar",
																			style: TextStyle(
																				fontFamily: 'HankenGrotesk',
																				color: Color(0xff000000),
																				fontSize: 20,
																				fontWeight: FontWeight.w700,
																				fontStyle: FontStyle.normal,
																				letterSpacing: -0.1000000014901161,
																			)),
																),
															),
															Padding(
																padding: const EdgeInsets.only(left: 1),
																child: Column(
																	mainAxisAlignment:
																	MainAxisAlignment.spaceEvenly,
																	children: <Widget>[
																		Container(
																			decoration: BoxDecoration(
																					borderRadius:
																					BorderRadius.circular(26)),
																			margin:
																			EdgeInsets.symmetric(vertical: 30.0),
																			height: 130,
																			child: ListView(
																				scrollDirection: Axis.horizontal,
																				children: <Widget>[
																					SizedBox(
																						width: 24.0,
																					),
																					Container(
																						child: Column(
																							mainAxisAlignment:
																							MainAxisAlignment.start,
																							children: <Widget>[
																								Container(
																									width: 105,
																									height: 92,
																									child: Container(
																										decoration: BoxDecoration(
																											borderRadius:
																											new BorderRadius
																													.circular(6),
																											color: Color(0xff16202c),
																										),
																										child: Center(
																											child: Wrap(
																												children: <Widget>[
																													FlatButton(
																														child: Image.asset(
																															'assets/images/eatOutIcon@3x.png',
																															width: 38,
																															height: 38,
																														),
																														onPressed: () {
																															Navigator.of(
																																	context)
																																	.push(
																																	MaterialPageRoute(
																																			builder:
																																					(
																																					context) =>
																																					ComerPage()));
																														},
																													),
																												],
																											),
																										),
																									),
																								),
																								Text('Comer',
																										style: TextStyle(
																											fontFamily:
																											'HankenGrotesk',
																											color: Color(0xff000000),
																											fontSize: 15,
																											fontWeight:
																											FontWeight.w700,
																											fontStyle:
																											FontStyle.normal,
																											letterSpacing: -0.5,
																										)),
																								Text('',
																										style: TextStyle(
																											fontFamily: 'OpenSans',
																											color: Color(0xff3d3d3d),
																											fontSize: 11,
																											fontWeight:
																											FontWeight.w400,
																											fontStyle:
																											FontStyle.normal,
																											letterSpacing:
																											0.2000000029802322,
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
																											new BorderRadius
																													.circular(6),
																											color: Color(0xff16202c),
																										),
																										child: Center(
																											child: Wrap(
																												children: <Widget>[
																													SizedBox(
																														height: 92,
																														width: 105,
																														child: FlatButton(
																																child:
																																Image.asset(
																																	'assets/images/partiyingIcon@3x.png',
																																	width: 38,
																																	height: 38,
																																),
																																onPressed: () {
																																	Navigator.of(
																																			context)
																																			.push(
																																			MaterialPageRoute(
																																					builder: (
																																							context) =>
																																							FestejarPage()));
																																}),
																													)
																												],
																											),
																										),
																									),
																								),
																								Text('Festejar',
																										style: TextStyle(
																											fontFamily:
																											'HankenGrotesk',
																											color: Color(0xff000000),
																											fontSize: 15,
																											fontWeight:
																											FontWeight.w700,
																											fontStyle:
																											FontStyle.normal,
																											letterSpacing: -0.5,
																										)),
																								Text('',
																										style: TextStyle(
																											fontFamily: 'OpenSans',
																											color: Color(0xff3d3d3d),
																											fontSize: 11,
																											fontWeight:
																											FontWeight.w400,
																											fontStyle:
																											FontStyle.normal,
																											letterSpacing:
																											0.2000000029802322,
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
																											new BorderRadius
																													.circular(6),
																											color: Color(0xff16202c),
																										),
																										child: Center(
																											child: Wrap(
																												children: <Widget>[
																													SizedBox(
																														height: 92,
																														width: 105,
																														child: FlatButton(
																																child:
																																Image.asset(
																																	'assets/images/afternoonIcon@3x.png',
																																	width: 38,
																																	height: 38,
																																),
																																onPressed: () {
																																	Navigator.of(
																																			context)
																																			.push(
																																			MaterialPageRoute(
																																					builder: (
																																							context) =>
																																							TardearPage()));
																																}),
																													)
																												],
																											),
																										),
																									),
																								),
																								Text('Tardear',
																										style: TextStyle(
																											fontFamily:
																											'HankenGrotesk',
																											color: Color(0xff000000),
																											fontSize: 15,
																											fontWeight:
																											FontWeight.w700,
																											fontStyle:
																											FontStyle.normal,
																											letterSpacing: -0.5,
																										)),
																								Text('',
																										style: TextStyle(
																											fontFamily: 'OpenSans',
																											color: Color(0xff3d3d3d),
																											fontSize: 11,
																											fontWeight:
																											FontWeight.w400,
																											fontStyle:
																											FontStyle.normal,
																											letterSpacing:
																											0.2000000029802322,
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
																											new BorderRadius
																													.circular(6),
																											color: Color(0xff16202c),
																										),
																										child: Center(
																											child: Wrap(
																												children: <Widget>[
																													SizedBox(
																														height: 92,
																														width: 105,
																														child: FlatButton(
																																child:
																																Image.asset(
																																	'assets/images/restingIcon@3x.png',
																																	width: 38,
																																	height: 38,
																																),
																																onPressed: () {
																																	Navigator.of(
																																			context)
																																			.push(
																																			MaterialPageRoute(
																																					builder: (
																																							context) =>
																																							DescansarPage()));
																																}),
																													)
																												],
																											),
																										),
																									),
																								),
																								Text('Descansar',
																										style: TextStyle(
																											fontFamily:
																											'HankenGrotesk',
																											color: Color(0xff000000),
																											fontSize: 15,
																											fontWeight:
																											FontWeight.w700,
																											fontStyle:
																											FontStyle.normal,
																											letterSpacing: -0.5,
																										)),
																								Text('',
																										style: TextStyle(
																											fontFamily: 'OpenSans',
																											color: Color(0xff3d3d3d),
																											fontSize: 11,
																											fontWeight:
																											FontWeight.w400,
																											fontStyle:
																											FontStyle.normal,
																											letterSpacing:
																											0.2000000029802322,
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
															ProximosEventosPage(),
															Padding(
																padding: const EdgeInsets.only(
																		left: 0, top: 47.0, right: 0),
																child: RestaurantesParaTi(),
															),
															Padding(
																	padding: const EdgeInsets.only(
																			left: 0,
																			top: 47.0,
																			right: 0.0,
																			bottom: 50.0),
																	child: BaresyDiscosParaTi()),
														],
													),
												),
											],
										),
									), //Poner searchbar
								],
							),
						),
						Positioned(
							bottom: 0,
							left: 0,
							right: 0,
							child: Container(
								width: MediaQuery
										.of(context)
										.size
										.width,
								height: 70,
								child:
								NavigatorBar(navCallback: (i) => print("Navigating to $i")),
							),
						),
					],
				),
			),
		);
	}
}
