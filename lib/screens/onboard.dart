import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:seemur_v1/screens/ingresar.dart';
import 'package:seemur_v1/screens/registrarse.dart';

class ImagesCarousel extends StatelessWidget {
 @override
 Widget build(BuildContext context) {
   double screenHeight = MediaQuery.of(context).size.height;

  return new Center(
      child: Container(
        padding: EdgeInsets.all(20.0),
        height:screenHeight / 2,
        child:new ClipRRect(
          borderRadius: BorderRadius.circular(30.0),
        
        child: Carousel(
          boxFit: BoxFit.cover,
          images: [
            AssetImage('assets/images/1.jpg'),
            AssetImage('assets/images/2.jpg'),
            AssetImage('assets/images/3.jpg'),
            AssetImage('assets/images/4.jpeg'),
          ],
        animationCurve: Curves.fastOutSlowIn,
        animationDuration: Duration(microseconds: 2000),
 ),
        ),
      ),
      
    
  );
}
}

class LoginFacebookPage extends StatefulWidget {
  @override
  _LoginFacebookPageState createState() => new _LoginFacebookPageState();
 }
class _LoginFacebookPageState extends State<LoginFacebookPage> {
  FirebaseAuth _auth= FirebaseAuth.instance;
  bool isLogged =false;

  FirebaseUser myUser;

  Future<FirebaseUser> _loginWithFacebook () async {
    var facebookLogin =new FacebookLogin();
    var result =await facebookLogin.logInWithReadPermissions(['email','public_profile']);
   FacebookAccessToken myToken= result.accessToken;
    final AuthCredential credential= FacebookAuthProvider.getCredential(
      accessToken:myToken.token);

    debugPrint(result.status.toString());

   if (result.status == FacebookLoginStatus.loggedIn){
    FirebaseUser user=await _auth.signInWithCredential(credential).then((onValue){
      isLogged =true;
    });
    return user;
  }
  return null;
  }
  void _logIn(){
    _loginWithFacebook().then((response){
      if (response !=null){
        myUser =response;
        isLogged=true;
        setState(() {
          
        });
      }
    });
  }


  @override
  Widget build(BuildContext context) {
   return new Scaffold(
     //appBar: AppBar(),
     body: Column(
       children: <Widget>[

         Padding(
           padding: const EdgeInsets.all(10.0),           
           child: ImagesCarousel(),
         ),
         Center(
           child: isLogged  ? null  : FacebookSignInButton(
             onPressed:_logIn,
           ),
         ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
             children: <Widget>[
                 Padding(
                   padding: const EdgeInsets.only(left:40.0),
                   child: RaisedButton(
             onPressed: navigateToSignUp,
             child: Text('Crear cuenta'),
                   ),
                 ),
                 Padding(
                   padding: const EdgeInsets.only(left:80.0),
                   child: RaisedButton(
                     onPressed: navigateToSignIn,
                     child: Text('Ingresar'),
                     ),
                 ),
                ],
           ),
              ),
       ],
     ),
     );
  }
  void navigateToSignIn(){
    Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage(), fullscreenDialog: true));
  }

  void navigateToSignUp(){
    Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpPage(), fullscreenDialog: true));
  }
}