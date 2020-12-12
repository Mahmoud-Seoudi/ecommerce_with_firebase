import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:store_app/login_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1A237E),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  MyImage(),
                  Text(
                    'MS Programming Company',
                    style: TextStyle(
                      fontSize: 25.0,
                      fontStyle: FontStyle.italic,
                      color: Color(0xFFEC407A),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CircularProgressIndicator(),
                  SizedBox(
                    height: 20.0,
                  ),
                  Text(
                    'Online Store for every thing',
                    style: TextStyle(
                      fontStyle: FontStyle.italic,
                      fontSize: 12.0,
                      color: Color(0xFFFFFFFF),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // first navigate to login screen
  void NavigateToLogIn() {
    Timer(
        Duration(seconds: 5),
        () => Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => LogInScreen())));
  }

  @override
  void initState() {
    super.initState();
    NavigateToLogIn();
  }
}

class MyImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AssetImage image = AssetImage('images/mslogo.png');
    Image logo = Image(
      image: image,
      width: 90.0,
      height: 90.0,
    );
    return logo;
  }
}
