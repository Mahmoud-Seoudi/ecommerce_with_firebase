import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:store_app/login_screen.dart';

class ForgotPassScreen extends StatefulWidget {
  @override
  _ForgotPassScreenState createState() => _ForgotPassScreenState();
}

class _ForgotPassScreenState extends State<ForgotPassScreen> {
  var _formKey = GlobalKey<FormState>();
  String email = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.login),
            label: Text('Log In'),
            onPressed: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LogInScreen(),
                  ));
            },
          ),
        ],
        backgroundColor: Color(0xFFEC407A),
        title: Text(
          'Forgotten Screen',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      backgroundColor: Color(0xFF1A237E),
      body: Center(
        child: Padding(
          padding: EdgeInsets.only(
            top: 50.0,
            right: 20.0,
            left: 20.0,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Text(
                  "We will mail you a link ... \nPlease click on that link to reset your password",
                  style: TextStyle(
                    color: Color(0xFFFFFFFF),
                    fontSize: 20.0,
                  ),
                ),
/////////////    add email input text to send reset password link
                Theme(
                  data: ThemeData(hintColor: Colors.blue),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 30.0),
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
                        labelText: 'Enter your Email',
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
//////////////  add button send mail to reset password
                Padding(
                  padding: const EdgeInsets.only(
                    top: 20.0,
                    left: 20.0,
                    right: 20.0,
                  ),
                  child: RaisedButton(
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        FirebaseAuth.instance
                            .sendPasswordResetEmail(email: email)
                            .then((value) => Fluttertoast.showToast(
                                  msg: "Check your mail inbox",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIosWeb: 1,
                                ));
                      }
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    color: Color(0xFFEC407A),
                    child: Text(
                      'Send Email',
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    padding: EdgeInsets.all(10.0),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
