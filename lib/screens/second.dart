import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';

class LoginFacebookPage extends StatefulWidget {
  @override
  _LoginFacebookPageState createState() => new _LoginFacebookPageState();
 }
class _LoginFacebookPageState extends State<LoginFacebookPage> {
  FirebaseAuth _auth= FirebaseAuth.instance;
  bool isLogged =false;

  FirebaseUser myUser;

  Future<FirebaseUser> _loginWithFacebook () async {
    String token ='<sample token>';
    final AuthCredential credential= FacebookAuthProvider.getCredential(
      accessToken:token);
        var facebookLogin =new FacebookLogin();
    var result =await facebookLogin.logInWithReadPermissions(['email','public_profile']);

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
     body: Center(
       child: isLogged ? null : FacebookSignInButton(
         onPressed:_logIn,
       ),
     ),
  
   );
  }
}