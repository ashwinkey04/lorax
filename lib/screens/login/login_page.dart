import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lorax/screens/login/sign_in.dart';
import 'package:lorax/widgets/theme.dart';
import 'package:lorax/screens/profile/profile_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String textValue = 'Hello World !';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: new BoxDecoration(
          gradient: new LinearGradient(
              colors: [
                Colors.white,
                Colors.white,
              ],
              begin: const FractionalOffset(0.0, 0.0),
              end: const FractionalOffset(1.0, 1.0),
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image(image: AssetImage("assets/images/dash.png")),
              SizedBox(height: 30),
              Text(
                'Lorax',
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'OpenSans',
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 60),
              _googleSignInButton(),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  Widget _googleSignInButton() {
    return DecoratedBox(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(40)),
      child: OutlineButton(
        splashColor: Colors.grey,
        color: Colors.white,
        onPressed: () {
          signInWithGoogle().whenComplete(() async {
            if (await FirebaseAuth.instance.currentUser() != null) {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return ProfilePage();
                  },
                ),
              );
            }
          });
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
        highlightElevation: 55,
        borderSide: BorderSide(color: Colors.grey),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image(
                  image: AssetImage("assets/images/google_logo.png"),
                  height: 35.0),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  'Sign in with Google',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
