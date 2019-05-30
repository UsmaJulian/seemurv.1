import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';


String url =
    'https://www.seemur.com/terminos-y-condiciones?fbclid=IwAR15w6blzcEEP6UdqmRQVPtZDyAoV4mZl9k81bUAozR8ttR3YD_7OGo3Bwc';

class TerminosCondicionesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      theme: ThemeData.dark(),
      routes: {
        "/": (_) => WebviewScaffold(
              url: url,
              appBar: AppBar(
                backgroundColor: Color(0xff16202c),
                elevation: 0,
                leading: IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                  ),
                  tooltip: MaterialLocalizations.of(context).backButtonTooltip,
                  onPressed: () {
                    Navigator.maybePop(context);
                  },
                ),
                title: Padding(
                  padding: const EdgeInsets.only(top:8.0),
                  child: Text('Términos y condiciones'),
                ),
              ),
              withJavascript: true,
              withLocalStorage: true,
              withZoom: true,
            ),
      },
    );
  }
}

class TerminosCondiciones extends StatefulWidget {
  @override
  _TerminosCondicionesState createState() => new _TerminosCondicionesState();
}

class _TerminosCondicionesState extends State<TerminosCondiciones> {
  final webView = FlutterWebviewPlugin();
  TextEditingController controller = TextEditingController(text: url);

  @override
  void initState() {
    super.initState();

    webView.close();
    controller.addListener(() {
      url = controller.text;
    });
  }

  @override
  void dispose() {
    webView.dispose();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Center(
        child: Column(children: <Widget>[
          Container(
            padding: EdgeInsets.all(10.0),
            child: TextField(
              controller: controller,
            ),
          ),
        ]),
      ),
    );
  }
}
