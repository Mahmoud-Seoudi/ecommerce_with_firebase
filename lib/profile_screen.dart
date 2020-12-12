import 'dart:async';
import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:store_app/edit_profile.dart';
import 'package:store_app/profile_data.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  List<ProfileData> dataList = [];
///////////////
  @override
  void initState() {
    super.initState();

    DatabaseReference referenceData =
        FirebaseDatabase.instance.reference().child("UserData");

    referenceData.once().then((DataSnapshot dataSnapshot) {
      dataList.clear();

      var keys = dataSnapshot.value.keys;
      var values = dataSnapshot.value;

      for (var key in keys) {
        ProfileData profileData = ProfileData(
          values[key]['imageUrl'],
          values[key]['name'],
          values[key]['birthDate'],
          values[key]['gender'],
          values[key]['address'],
          key,
          //// key is the uploadid
        );
        dataList.add(profileData);

        User user = FirebaseAuth.instance.currentUser;

        auth.currentUser;
        DatabaseReference reference = FirebaseDatabase.instance
            .reference()
            .child("UserData")
            .child(key)
            .child(user.uid);
        reference.once().then(
              (DataSnapshot snapShot) {},
            );
      }
      Timer(Duration(seconds: 1), () {
        setState(() {
          //
        });
      });
    });
  }

///////////////
  FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1A237E),
      appBar: AppBar(
        backgroundColor: Color(0xFFEC407A),
        title: Text(
          'My Profile',
          style: TextStyle(
            color: Colors.white,
            fontSize: 25.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          FlatButton.icon(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => EditProfile()));
            },
            icon: Icon(Icons.edit),
            label: Text('Edit Profile'),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: dataList.length,
        itemBuilder: (context, index) {
          return CardUI(
            dataList[index].imageUrl,
            dataList[index].name,
            dataList[index].gender,
            dataList[index].birthDate,
            dataList[index].address,
            dataList[index].uploadid,
            index,
          );
        },
      ),
    );
  }

  Widget CardUI(
    String imageUrl,
    String name,
    String gender,
    String birthDate,
    String address,
    String uploadId,
    int index,
  ) {
    return Card(
      elevation: 7.0,
      margin: EdgeInsets.all(15.0),
      color: Color(0xFFEC407A),
      child: Container(
        color: Colors.white,
        margin: EdgeInsets.all(1.5),
        padding: EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
                height: 150.0,
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              "Name : ${name}",
              style: TextStyle(
                color: Colors.black,
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              "Email : ${auth.currentUser.email}",
              style: TextStyle(
                color: Colors.black,
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              "Gender : ${gender}",
              style: TextStyle(
                color: Colors.black,
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              "Birth Date : ${birthDate}",
              style: TextStyle(
                color: Colors.black,
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              "Address : ${address}",
              style: TextStyle(
                color: Colors.black,
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

////////////////////////////////////    log out
  Future<void> logOut() async {
    Future<void> user = auth.signOut();
  }
}
