import 'dart:async';
import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:store_app/data.dart';

class MyFavoriteScreen extends StatefulWidget {
  @override
  _MyFavoriteScreenState createState() => _MyFavoriteScreenState();
}

class _MyFavoriteScreenState extends State<MyFavoriteScreen> {
  List<Data> dataList = [];
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();

    FavoriteFunc();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Favorites',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Color(0xFFEC407A),
      ),
      body: dataList.length == 0
          ? Center(
              child: Text(
                // 'No Data Available',
                'Loading .....',
                style: TextStyle(fontSize: 30.0),
              ),
            )
          : ListView.builder(
              itemCount: dataList.length,
              itemBuilder: (_, index) {
                return CardUI(
                  dataList[index].imageUrl,
                  dataList[index].name,
                  dataList[index].material,
                  dataList[index].price,
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
    String material,
    String price,
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
          children: <Widget>[
            // imageUrl != null
            //     ? Image.network(
            //         imageUrl,
            //         // fit: BoxFit.cover,
            //         height: 100,
            //       )
            //     : Container(
            //         width: double.infinity,
            //         height: 100.0,
            //       ),
            Image.network(
              imageUrl,
              fit: BoxFit.cover,
              height: 100.0,
            ),
            SizedBox(
              height: 1.0,
            ),
            Text(
              name,
              style: TextStyle(
                color: Colors.black,
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 1.0,
            ),
            Text("material : $material"),
            SizedBox(
              height: 1.0,
            ),
            Container(
              width: double.infinity,
              child: Text(
                price,
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.right,
              ),
            ),
            SizedBox(
              height: 1.0,
            ),

            IconButton(
              icon: Icon(
                Icons.favorite,
                color: Colors.red,
              ),
              onPressed: () {
                User user = FirebaseAuth.instance.currentUser;

                auth.currentUser;
                DatabaseReference favRef = FirebaseDatabase.instance
                    .reference()
                    .child("Data")
                    .child(uploadId)
                    .child("Fav")
                    .child(user.uid)
                    .child("state");

                favRef.set("false");

                setState(() {
                  FavoriteFunc();
                });
              },
            )
          ],
        ),
      ),
    );
  }

  void FavoriteFunc() {
    DatabaseReference referenceData =
        FirebaseDatabase.instance.reference().child("Data");

    referenceData.once().then((DataSnapshot dataSnapshot) {
      dataList.clear();
      var keys = dataSnapshot.value.keys;
      var values = dataSnapshot.value;

      for (var key in keys) {
        Data data = Data(
          values[key]['imageUrl'],
          values[key]['name'],
          values[key]['material'],
          values[key]['price'],
          key,

          //// key is the uploadid
        );
        User user = FirebaseAuth.instance.currentUser;

        auth.currentUser;
        DatabaseReference reference = FirebaseDatabase.instance
            .reference()
            .child("Data")
            .child(key)
            .child("Fav")
            .child(user.uid)
            .child("state");
        reference.once().then((DataSnapshot snapShot) {
          if (snapShot.value != null) {
            if (snapShot.value == "true") {
              dataList.add(data);
            }
          }
        });
        Timer(Duration(seconds: 1), () {
          setState(() {});
        });
      }
    });
  }
}
