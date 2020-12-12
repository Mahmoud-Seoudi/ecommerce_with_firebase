import 'dart:ui';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:store_app/forgot_pass_screen.dart';
import 'package:store_app/home_screen.dart';
import 'package:store_app/signup_screen.dart';

class LogInScreen extends StatefulWidget {
  @override
  _LogInScreenState createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  bool signInState = false;
  String email = "", password = "";
  var _formKey = GlobalKey<FormState>();

  FirebaseAuth auth = FirebaseAuth.instance;

  Future<String> logIn() async {
//////    change FirebaseUser   to       UserCredential
    String user = auth
        .signInWithEmailAndPassword(email: email.trim(), password: password)
        .toString();

    return user;
  }

//////////////////   google sign in
  GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);
  Future<void> _GoogleSignIn() async {
    GoogleSignInAccount signInAccount = await _googleSignIn.signIn();
    GoogleSignInAuthentication signInAuthentication =
        await signInAccount.authentication;
    AuthCredential credential = GoogleAuthProvider.getCredential(
        idToken: signInAuthentication.idToken,
        accessToken: signInAuthentication.accessToken);

    UserCredential user = (await auth.signInWithCredential(credential));

    print(user);

    setState(() {
      signInState = true;
    });
  }

  @override
  void initState() {
    super.initState();
    Future(() async {
      if (await auth.currentUser != null) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => HomeScreen(email)));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1A237E),
      body: Form(
        key: _formKey,
        child: ListView(
          children: <Widget>[
            Container(
              width: double.infinity,
              height: 150.0,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Log In',
                      style: TextStyle(
                        fontSize: 35.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'Welcome to our store',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.only(bottomRight: Radius.circular(150.0)),
                color: Color(0xFFEC407A),
              ),
            ),
/////////////    add email input text
            Theme(
              data: ThemeData(hintColor: Colors.blue),
              child: Padding(
                padding: EdgeInsets.only(
                  top: 20.0,
                  right: 20.0,
                  left: 20.0,
                ),
                child: TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter your email';
                    } else {
                      email = value;
                    }
                    return null;
                  },
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  decoration: InputDecoration(
                    labelText: 'Enter Email',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: BorderSide(
                        color: Color(0xFFEC407A),
                        width: 1,
                      ),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: BorderSide(
                        color: Color(0xFFEC407A),
                        width: 1,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: BorderSide(
                        color: Color(0xFFEC407A),
                        width: 1,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: BorderSide(
                        color: Color(0xFFEC407A),
                        width: 1,
                      ),
                    ),
                  ),
                ),
              ),
            ),
/////////////    add password input text
            Theme(
              data: ThemeData(hintColor: Colors.blue),
              child: Padding(
                padding: EdgeInsets.only(
                  top: 10.0,
                  right: 20.0,
                  left: 20.0,
                ),
                child: TextFormField(
                  obscureText: true,
                  autocorrect: false,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter your password';
                    } else {
                      password = value;
                    }
                    return null;
                  },
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  decoration: InputDecoration(
                    labelText: 'Enter Password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: BorderSide(
                        color: Color(0xFFEC407A),
                        width: 1,
                      ),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: BorderSide(
                        color: Color(0xFFEC407A),
                        width: 1,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: BorderSide(
                        color: Color(0xFFEC407A),
                        width: 1,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: BorderSide(
                        color: Color(0xFFEC407A),
                        width: 1,
                      ),
                    ),
                  ),
                ),
              ),
            ),
//////////////   add button forget password
            Padding(
              padding: const EdgeInsets.only(
                right: 20.0,
              ),
              child: Container(
                width: double.infinity,
                child: InkWell(
                  onTap: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                ForgotPassScreen()));
                  },
                  child: Text(
                    'Forgot Password?',
                    style: TextStyle(
                      color: Color(0xFFEC407A),
                    ),
                    textAlign: TextAlign.right,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
//////////////  add button log in
            Padding(
              padding: const EdgeInsets.only(
                left: 20.0,
                right: 20.0,
              ),
              child: RaisedButton(
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    Future<String> check = logIn();
                    if (check != null) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  HomeScreen(auth.currentUser.email)));
                    }
                  }
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                color: Color(0xFFEC407A),
                child: Text(
                  'Log In',
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                padding: EdgeInsets.all(10.0),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Container(
              width: double.infinity,
              height: 1.0,
              color: Colors.blue,
            ),
///////////        add button sign in with google
            Padding(
              padding: EdgeInsets.only(
                top: 10.0,
                right: 20.0,
                left: 20.0,
              ),
              child: RaisedButton(
                onPressed: () {
                  _GoogleSignIn();
                  if (signInState) {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                HomeScreen(email)));
                  }
                },
                color: Colors.white,
                padding: EdgeInsets.all(10.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Row(
                  children: <Widget>[
                    Icon(
                      FontAwesomeIcons.google,
                      color: Color(0xFFEC407A),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Text(
                      'Sign in with Google',
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Color(0xFF1A237E),
                      ),
                    ),
                  ],
                ),
              ),
            ),
///////////        add button sign in with facebook
            Padding(
              padding: EdgeInsets.only(
                top: 5.0,
                right: 20.0,
                left: 20.0,
              ),
              child: RaisedButton(
                onPressed: () {},
                color: Colors.white,
                padding: EdgeInsets.all(10.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Row(
                  children: <Widget>[
                    Icon(
                      FontAwesomeIcons.facebook,
                      color: Colors.blue,
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Text(
                      'Sign in with Facebook',
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Color(0xFF1A237E),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
//////////////  add button sign up
            Center(
              child: Column(
                children: <Widget>[
                  Text(
                    "Don't have an account",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  FlatButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (BuildContext context) => SignUpScreen()));
                    },
                    child: Column(
                      children: <Widget>[
                        Text(
                          'Sign Up',
                          style: TextStyle(
                            color: Colors.blue,
                          ),
                        ),
                        Container(
                          width: 45.0,
                          height: 1.0,
                          color: Colors.blue,
                        ),
                      ],
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
}
