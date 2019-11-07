import 'package:flutter/material.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/slide_object.dart';
import 'package:seemur_v1/auth/auth.dart';
import 'package:seemur_v1/login_admin/login_page.dart';

class IntroScreen extends StatefulWidget {
  IntroScreen({this.auth, this.onSignIn});
  final BaseAuth auth;
  final VoidCallback onSignIn;

  @override
  _IntroScreenState createState() => _IntroScreenState();
}

enum AuthStatus { notSignIn, signIn }

class _IntroScreenState extends State<IntroScreen> {
  AuthStatus _authStatus = AuthStatus.notSignIn;

  List<Slide> slides = new List();

  @override
  void initState() {
    super.initState();
    widget.auth.currentUser().then((onValue) {
      setState(() {
        print(onValue);
        _authStatus =
            onValue == 'no_login' ? AuthStatus.notSignIn : AuthStatus.signIn;
      });
    });

    //pages slide
    slides.add(
      new Slide(
        backgroundImage: 'assets/images/seemur app.gif',
        backgroundOpacity: 0,
        onCenterItemPress: () {},
      ),
    );
    //two
    slides.add(
      new Slide(
        backgroundOpacity: 0,
        backgroundImage: "assets/images/seemur app 2.gif",
      ),
    );
    //three page
    slides.add(
      new Slide(
        backgroundOpacity: 0,
        backgroundImage: "assets/images/seemur app 3.gif",
      ),
    );
  }

  void onDonePress() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => LoginPage(
                auth: widget.auth,
                onSignIn: widget.onSignIn,
              )),
    );
  }

  Widget renderNextBtn() {
    return Icon(
      Icons.navigate_next,
      color: Colors.white,
      size: 35.0,
    );
  }

  Widget renderDoneBtn() {
    return Icon(
      Icons.done,
      color: Colors.white,
    );
  }

  Widget renderSkipBtn() {
    return Icon(
      Icons.skip_next,
      color: Colors.white,
    );
  }

  @override
  Widget build(BuildContext context) {
    return new IntroSlider(
      // List slides
      slides: this.slides,

      // Skip button
      renderSkipBtn: this.renderSkipBtn(),
      colorSkipBtn: Color(0xffF5AF00),
      highlightColorSkipBtn: Color(0xffFFE231),

      // Next button
      renderNextBtn: this.renderNextBtn(),

      // Done button
      renderDoneBtn: this.renderDoneBtn(),
      onDonePress: this.onDonePress,
      colorDoneBtn: Color(0xff16202C),
      highlightColorDoneBtn: Color(0xfF69303),

      // Dot indicator
      colorDot: Colors.white,
      colorActiveDot: Color(0xffF5AF00),
      sizeDot: 13.0,

      // Show or hide status bar
      shouldHideStatusBar: true,
      backgroundColorAllSlides: Colors.grey,
    );
  }
}
