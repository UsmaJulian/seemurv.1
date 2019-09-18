import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:seemur_v1/components/widgets/customappbar_terminos.dart';

String url =
    'https://www.seemur.com/terminos-y-condiciones?fbclid=IwAR15w6blzcEEP6UdqmRQVPtZDyAoV4mZl9k81bUAozR8ttR3YD_7OGo3Bwc';

class TerminosCondicionesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      //theme: ThemeData.dark(),
      routes: {
        "/": (_) => WebviewScaffold(
              url: url,
              withJavascript: true,
              withLocalStorage: true,
              withZoom: true,
              clearCookies: true,
              clearCache: true,
              appBar:  AppBar(
                  backgroundColor: Color(0xff16202c),
                  elevation: 0,
                  title: CustomAppBar(),
                ),
              
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
      body: Column(children: <Widget>[
        Container(
          child: TextField(
            controller: controller,
          ),
        ),
      ]),
    );
  }
}
