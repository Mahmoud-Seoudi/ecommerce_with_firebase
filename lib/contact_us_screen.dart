import 'dart:ui';

import 'package:contactus/contactus.dart';
import 'package:flutter/material.dart';
import 'package:store_app/splash_screen.dart';

class ContactUsScreen extends StatefulWidget {
  @override
  _ContactUsScreenState createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFEC407A),
        title: Text(
          'Contact Us',
          style: TextStyle(
            color: Colors.white,
            fontSize: 25.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      bottomNavigationBar: ContactUsBottomAppBar(
        companyName: 'Mahmoud Seoudi',
        textColor: Colors.white,
        backgroundColor: Colors.teal[500],
        email: 'eng.mahmoud.seoudi@outlook.com',
      ),
      backgroundColor: Colors.teal[100],
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            MyImage(),
            ContactUs(
              cardColor: Colors.teal[50],
              textColor: Colors.black,
              // logo: AssetImage("images/mslogo.png"),
              companyName: 'Mahmoud Seoudi',
              tagLine: 'Flutter Developer',
              companyColor: Colors.black,
              taglineColor: Colors.black,
              website: 'https://www.google.com',
              phoneNumber: '+201145971654',
              email: 'eng.mahmoud.seoudi@outlook.com',
              emailText: 'Email',
              twitterHandle: 'mseoudi89',
              instagram: 'm7mod_s3odi',
              githubUserName: 'Mahmoud-Seoudi',
              linkedinURL: 'https://www.linkedin.com/',
            ),
          ],
        ),
      ),
    );
  }
}
