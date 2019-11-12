import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:seemur_v1/components/widgets/navigatorbar.dart';
import 'package:seemur_v1/screens/descubrircat.dart';

class Descubrir extends StatefulWidget {
  @override
  _DescubrirState createState() => _DescubrirState();
}

class _DescubrirState extends State<Descubrir> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 24) / 6;
    final double itemWidth = size.width / 2;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(90.0),
        child: AppBar(
          backgroundColor: Color(0xff16202C),
          automaticallyImplyLeading: false,
          title: Padding(
            padding: const EdgeInsets.only(top: 18.0),
            child: Text('Descubrir'),
          ),
          centerTitle: true,
        ),
      ),
      backgroundColor:
          Color(0xffF6F7FA), //se reemplaza # por 0xff para convertir en HEX
      body: Container(
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: DescubirCard(itemWidth: itemWidth, itemHeight: itemHeight),
            ),
            Positioned(
              bottom: -3,
              left: 0,
              right: 0,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 70,
                child: NavigatorBar(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// class LoadCards extends StatefulWidget {
//   LoadCards({
//     this.items,
//   });
//   String items;
//   @override
//   _LoadCardsState createState() => _LoadCardsState();
// }

// class _LoadCardsState extends State<LoadCards> {
//   final databaseReference = Firestore.instance;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 295.0,
//       height: 44.0,
//       decoration: BoxDecoration(
//         border: new Border.all(width: 0, color: Colors.transparent),
//         borderRadius: BorderRadius.horizontal(
//             left: Radius.circular(22), right: Radius.circular(22)),
//         gradient: LinearGradient(
//           colors: [new Color(0xFFFFE231), new Color(0xFFF5AF00)],
//           begin: Alignment.topCenter,
//           end: Alignment.bottomCenter,
//         ),
//       ),
//       child: FlatButton(
//         onPressed: () {},
//         child: Text('Ver más categorías',
//             style: new TextStyle(
//               color: Colors.black,
//               fontFamily: 'HankenGrotesk',
//               fontSize: 14.0,
//               fontWeight: FontWeight.w700,
//             )),
//       ),
//     );
//   }
// }

class DescubirCard extends StatelessWidget {
  DescubirCard({
    Key key,
    @required this.itemWidth,
    @required this.itemHeight,
  }) : super(key: key);

  final double itemWidth;
  final double itemHeight;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(bottom: 80.0),
        child: Container(
          child: StreamBuilder(
              stream: Firestore.instance.collection("descubrir").snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Text("loading....");
                } else {
                  if (snapshot.data.documents.length == 0) {
                  } else {
                    return Column(
                      children: <Widget>[
                        Flexible(
                          flex: 3,
                          child: GridView.count(
                            crossAxisSpacing: 13.0,
                            mainAxisSpacing: 16.0,
                            childAspectRatio: (itemWidth / itemHeight),
                            crossAxisCount: 2,
                            children: List.generate(
                                snapshot.data.documents.length, (items) {
                              return Container(
                                width:
                                    MediaQuery.of(context).size.width * 0.4187,
                                height:
                                    MediaQuery.of(context).size.height * 0.862,
                                child: Card(
                                  elevation: 4,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  color: Colors.white,
                                  child: InkWell(
                                    highlightColor: Color(0xffF8C300),
                                    child: Center(
                                      child: Text(
                                          (snapshot.data.documents[items]
                                              .documentID),
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontFamily: 'HankenGrotesk',
                                            color: Color(0xff000000),
                                            fontSize: 15,
                                            fontWeight: FontWeight.w700,
                                            fontStyle: FontStyle.normal,
                                            letterSpacing: -0.5,
                                          )),
                                    ),
                                    onTap: () {
                                      final documentocliente = (snapshot
                                          .data.documents[items].documentID);
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  DescubrircatPage(
                                                      idcliente:
                                                          documentocliente)));
                                    },
                                  ),
                                ),
                              );
                            }),
                          ),
                        ),
                        // Flexible(
                        //   fit: FlexFit.loose,
                        //   child: Container(
                        //     child: Padding(
                        //         padding:
                        //             const EdgeInsets.only(top: 16.0, bottom: 2.0),
                        //         child: LoadCards()),
                        //   ),
                        // ),
                      ],
                    );
                  }
                  return Text("loading....");
                }
              }),
        ),
      ),
    );
  }
}
