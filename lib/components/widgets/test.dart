import 'package:flutter/material.dart';

class FichaPage extends StatefulWidget {
  FichaPage({
    this.datos,
  });
  final datos;
  @override
  _FichaPageState createState() => _FichaPageState();
}

class _FichaPageState extends State<FichaPage> {
  @override
  Widget build(BuildContext context) {
    dynamic datos;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  color: Colors.blue,
                  height: 140,
                ),
                getMainCard(),

                SizedBox(height: 40),

                // otro widget
                getFotosDestacadas(),

                SizedBox(height: 40),

                getPanelInformacion(),
                SizedBox(height: 40),
                getPlatosRecomendados(),
                SizedBox(height: 40),
                getReviews(),
                // como llegar.
              ],
            )),
      ),
    );
  }

  getMainCard() {
    return Container(
//      margin: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
                color: Colors.black26, blurRadius: 4, offset: Offset(0, 1))
          ]),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Jardin sichuan\nresturante japones",
            style: TextStyle(
              fontSize: 26,
            ),
          ),
          SizedBox(height: 20),
          Text(
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean porta feugiat tincidunt. Nullam maximus ornare sodales.",
            style: TextStyle(
              fontSize: 18,
            ),
          ),
          SizedBox(height: 20),
          getStarRating(4),
          SizedBox(height: 10),
          getHoursDistance(),
          SizedBox(height: 30),
          getCardButtons(),
        ],
      ),
    );
  }

  getStarRating(int num) {
    String str = List.generate(5, (idx) => idx < num ? "★" : "☆").join('') +
        "  ${num.toStringAsFixed(1)}";
    return Text(str);
  }

  getHoursDistance() {
    var style1 = TextStyle(fontSize: 14);
    var style2 = TextStyle(fontSize: 18, fontWeight: FontWeight.bold);
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("Horarios:", style: style1),
            Text("9am - 8.30pm", style: style2)
          ],
        ),
        Spacer(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("Distance:", style: style1),
            Text("1.2 km", style: style2)
          ],
        ),
        SizedBox(width: 20),
      ],
    );
  }

  getCardButtons() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        getFav(Icons.favorite_border, Colors.red),
        getFav(Icons.star_border, Colors.yellow),
        getFav(Icons.share, Colors.green),
        Spacer(),
        MaterialButton(
          onPressed: () {},
          color: Colors.black,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(
                Icons.phone,
                color: Colors.white,
              ),
              Text(
                "Llamar",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              )
            ],
          ),
        )
      ],
    );
  }

  getFav(IconData iconData, Color color) {
    return FloatingActionButton(
      onPressed: () {},
      backgroundColor: Colors.black,
      mini: true,
      child: Icon(
        iconData,
        color: color,
      ),
    );
  }

  getFotosDestacadas() {
    return Flexible(
      child: Column(
//        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Fotos destacadas",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          SizedBox(
            height: 110,
            child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (ctx, idx) {
                  return Container(
                    width: 150,
                    decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 4,
                            offset: Offset(0, 1),
                          )
                        ]),
                  );
                },
                separatorBuilder: (ctx, idx) {
                  return SizedBox(width: 15);
                },
                padding: EdgeInsets.zero,
                itemCount: 10),
          )
        ],
      ),
    );
  }

  getPanelInformacion() {
    Widget buildInfoItem(String title, String desc, IconData icon) {
      return Container(
        height: 80,
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(
                    color: Colors.black.withOpacity(.24), width: 1))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 10),
            Text(
              title,
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2),
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Icon(icon, color: Colors.black),
                SizedBox(width: 20),
                Text(
                  desc,
                  style: TextStyle(fontSize: 16),
                ),
                Spacer(),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.navigate_next),
                ),
              ],
            )
          ],
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "Informacion",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 20),
        buildInfoItem("Como llegar", "Calle 57, C2", Icons.map),
        buildInfoItem("Precio Mínimo", "80.000 por persona", Icons.shop_two),
        buildInfoItem("Tipo de Vestuario", "Formal", Icons.accessibility_new),
        buildInfoItem("Domicilio", "Si", Icons.directions_car),
      ],
    );
  }

  getPlatosRecomendados() {
    Widget buildRow(String title, int likes) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          children: <Widget>[
            Text(
              title,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Spacer(),
            Icon(Icons.thumb_up, color: Colors.teal),
            SizedBox(width: 10),
            SizedBox(
                width: 50,
                child: Text(
                  "$likes",
                  style: TextStyle(fontSize: 14, color: Colors.teal),
                )),
          ],
        ),
      );
    }

    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        "Platos recomendados",
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
      SizedBox(height: 10),
      Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 4,
                  offset: Offset(0, 2),
                )
              ]),
          child: Column(
            children: [
              buildRow("Salmon Sichuan", 1022),
              buildRow("Fillet Mignon", 340),
              buildRow("Tempura", 126),
            ],
          )),
    ]);
  }

  final String loremipsum =
      "Vivamus sit amet justo dapibus, ultrices metus vel, viverra mi. Morbi malesuada mauris quam, ut consequat turpis posuere vel. Morbi dictum erat a arcu bibendum condimentum. Integer volutpat eleifend eros, ut porttitor lacus imperdie . Integer volutpat eleifend eros, ut porttitor lacus imperdie ";

  getReviews() {
    Widget buildReviewItem(
        String name, int stars, int mins, int votes, String text) {
      return Container(
        height: 250,
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // logo
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.limeAccent,
                      border: Border.all(color: Colors.grey.withOpacity(.4))),
                ),
                SizedBox(width: 20),
                // contenido.
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        name,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        "$votes votos",
                        style: TextStyle(
                          fontWeight: FontWeight.w300,
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        "$text",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(height: 20),
                      FlatButton(
                        onPressed: () {},
                        child: Text(
                          "Ver mas",
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 20),
                Text("$mins mins"),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 60.0),
              child: Divider(color: Colors.grey),
            ),
          ],
        ),
      );
    }

    List buildReviewList() {
      return [
        buildReviewItem(
            "Mike Hernandez", 4, 22, 23, loremipsum.substring(0, 220)),
        buildReviewItem(
            "Mike Nichols", 3, 20, 23, loremipsum.substring(0, 150)),
        buildReviewItem(
            "Claudia Hopkins", 5, 12, 23, loremipsum.substring(20, 120)),
      ];
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "Reseñas destacadas",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.star, color: Colors.orange),
            SizedBox(width: 5),
            Text(
              "4.0",
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.w800),
            ),
            SizedBox(width: 20),
            Text(
              "+2K opiniones",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w200),
            ),
          ],
        ),
        SizedBox(height: 4),
        Divider(height: 1, color: Colors.grey),
        SizedBox(height: 20),
        ...buildReviewList(),
      ],
    );
  }
}
