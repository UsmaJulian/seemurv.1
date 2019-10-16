import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:seemur_v1/components/widgets/customappbar_terminos.dart';

String url = 'https://www.seemur.com/politica-de-privacidad';

class PoliticaDePrivacidadPage extends StatelessWidget {
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
              appBar: AppBar(
                centerTitle: true,
                backgroundColor: Color(0xff16202c),
                elevation: 0,
                leading: IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                title: Text('Politica de privacidad',
                    style: new TextStyle(
                      color: Colors.white,
                      fontFamily: 'HankenGrotesk',
                      fontSize: 14.0,
                      fontWeight: FontWeight.w700,
                    )),
              ),
            ),
      },
    );
  }
}

class PoliticaDePrivacidad extends StatefulWidget {
  @override
  _PoliticaDePrivacidadState createState() => new _PoliticaDePrivacidadState();
}

class _PoliticaDePrivacidadState extends State<PoliticaDePrivacidad> {
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
