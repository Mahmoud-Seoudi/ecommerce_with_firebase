import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:store_app/home_screen.dart';
import 'package:store_app/login_screen.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  String email = "", password = "";
  var _formKey = GlobalKey<FormState>();

  FirebaseAuth auth = FirebaseAuth.instance;
  Future<void> register() async {
//////    change FirebaseUser   to       UserCredential
    await auth
        .createUserWithEmailAndPassword(email: email.trim(), password: password)
        .then((value) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => HomeScreen(value.user.email)));
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
                      'Sign Up',
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
/////////////    add user name input text
            Theme(
              data: ThemeData(hintColor: Colors.blue),
              child: Padding(
                padding: EdgeInsets.only(
                  top: 20.0,
                  right: 20.0,
                  left: 20.0,
                ),
                child: TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter user name';
                    } else {
                      return null;
                    }
                  },
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  decoration: InputDecoration(
                    labelText: 'User Name',
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
/////////////    add email input text
            Theme(
              data: ThemeData(hintColor: Colors.blue),
              child: Padding(
                padding: EdgeInsets.only(
                  top: 10.0,
                  right: 20.0,
                  left: 20.0,
                ),
                child: TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter email';
                    } else {
                      email = value;
                    }
                    return null;
                  },
                  // onSaved: (value) {
                  //   email = value;
                  // },
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
                      return 'Please enter password';
                    } else if (value.length < 8) {
                      return "your password shouldn't have less than 8 characters";
                    } else {
                      password = value;
                    }
                    return null;
                  },
                  // onSaved: (value) {
                  //   password = value;
                  // },
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
            // /////////////    add confirm password input text
            // Theme(
            //   data: ThemeData(hintColor: Colors.blue),
            //   child: Padding(
            //     padding: EdgeInsets.only(
            //       top: 10.0,
            //       right: 20.0,
            //       left: 20.0,
            //     ),
            //     child: TextField(
            //       style: TextStyle(
            //         color: Colors.white,
            //       ),
            //       decoration: InputDecoration(
            //         labelText: 'Confirm Password',
            //         border: OutlineInputBorder(
            //           borderRadius: BorderRadius.circular(15.0),
            //           borderSide: BorderSide(
            //             color: Color(0xFFEC407A),
            //             width: 1,
            //           ),
            //         ),
            //         disabledBorder: OutlineInputBorder(
            //           borderRadius: BorderRadius.circular(15.0),
            //           borderSide: BorderSide(
            //             color: Color(0xFFEC407A),
            //             width: 1,
            //           ),
            //         ),
            //         enabledBorder: OutlineInputBorder(
            //           borderRadius: BorderRadius.circular(15.0),
            //           borderSide: BorderSide(
            //             color: Color(0xFFEC407A),
            //             width: 1,
            //           ),
            //         ),
            //         focusedBorder: OutlineInputBorder(
            //           borderRadius: BorderRadius.circular(15.0),
            //           borderSide: BorderSide(
            //             color: Color(0xFFEC407A),
            //             width: 1,
            //           ),
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
//////////////  add button sign up
            Padding(
              padding: const EdgeInsets.only(
                left: 20.0,
                right: 20.0,
              ),
              child: RaisedButton(
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    register();
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (BuildContext context) => HomeScreen()));
                  }
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                color: Color(0xFFEC407A),
                child: Text(
                  'Sign Up',
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
                      FontAwesomeIcons.google,
                      color: Color(0xFFEC407A),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Text(
                      'Sign up with Google',
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
                      'Sign up with Facebook',
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
                    "You already have an account",
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
                          builder: (BuildContext context) => LogInScreen()));
                    },
                    child: Column(
                      children: <Widget>[
                        Text(
                          'Log In',
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
