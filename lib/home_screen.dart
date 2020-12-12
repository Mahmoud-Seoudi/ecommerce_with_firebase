import 'dart:async';
import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:store_app/contact_us_screen.dart';
import 'package:store_app/data.dart';
import 'package:store_app/login_screen.dart';
import 'package:store_app/myfavorite_screen.dart';
import 'package:store_app/profile_screen.dart';
import 'package:store_app/upload_data.dart';

class HomeScreen extends StatefulWidget {
  String currentEmail;

  HomeScreen(this.currentEmail);
  @override
  _HomeScreenState createState() => _HomeScreenState(currentEmail);
}

class _HomeScreenState extends State<HomeScreen> {
  String currentEmail;
  List<Data> dataList = [];
  List<bool> favList = [];
  bool searchState = false;
  FirebaseAuth auth = FirebaseAuth.instance;

  _HomeScreenState(this.currentEmail);

  Future<void> logOut() async {
    Future<void> user = auth.signOut();
  }

  @override
  void initState() {
    super.initState();

    DatabaseReference referenceData =
        FirebaseDatabase.instance.reference().child("Data");

    referenceData.once().then((DataSnapshot dataSnapshot) {
      dataList.clear();
      favList.clear();
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
        dataList.add(data);

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
              favList.add(true);
            } else {
              favList.add(false);
            }
          } else {
            favList.add(false);
          }
        });
      }

      Timer(Duration(seconds: 1), () {
        setState(() {
          //
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      appBar: AppBar(
        backgroundColor: Color(0xFFEC407A),
        title: !searchState
            ? Text('Home')
            : TextField(
                decoration: InputDecoration(
                  icon: Icon(Icons.search),
                  hintText: 'Search ...',
                  hintStyle: TextStyle(color: Colors.white),
                ),
                onChanged: (text) {
                  SearchMethod(text);
                },
              ),
        actions: <Widget>[
          !searchState
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      searchState = !searchState;
                    });
                  },
                  icon: Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                )
              : IconButton(
                  onPressed: () {
                    setState(() {
                      searchState = !searchState;
                    });
                  },
                  icon: Icon(
                    Icons.cancel,
                    color: Colors.white,
                  ),
                ),
          FlatButton.icon(
            onPressed: () {
              logOut();
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => LogInScreen()));
            },
            icon: Icon(Icons.exit_to_app),
            label: Text('Log Out'),
          ),
        ],
      ),
      drawer: Drawer(
        child: Column(
          children: <Widget>[
            Container(
              width: double.infinity,
              height: 170.0,
              color: Color(0xFF1A237E),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 30.0),
                  ),
                  Image(
                    image: AssetImage(
                      'images/user.jpg',
                    ),
                    width: 70.0,
                    height: 70.0,
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    //////////  display your account email or name
                    auth.currentUser.email,
                    style: TextStyle(
                      color: Color(0xFFFFFFFF),
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              title: Text('Add Product'),
              leading: Icon(Icons.cloud_upload),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => UploadDate()));
              },
            ),
            ListTile(
              title: Text('My Favorite'),
              leading: Icon(Icons.favorite),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => MyFavoriteScreen()));
              },
            ),
            ListTile(
              title: Text('My Profile'),
              leading: Icon(Icons.person),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => ProfileScreen(),
                    ));
              },
            ),
            Divider(
              color: Color(0xFF1A237E),
            ),
            ListTile(
              title: Text('Contact Us'),
              leading: Icon(Icons.email),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => ContactUsScreen()));
              },
            ),
          ],
        ),
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

            favList[index]
                ? IconButton(
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
                : IconButton(
                    icon: Icon(Icons.favorite_border),
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

                      favRef.set("true");
                      setState(() {
                        FavoriteFunc();
                      });
                    },
                  ),
          ],
        ),
      ),
    );
  }

  void FavoriteFunc() {
    DatabaseReference referenceData =
        FirebaseDatabase.instance.reference().child("Data");

    referenceData.once().then((DataSnapshot dataSnapshot) {
      favList.clear();
      var keys = dataSnapshot.value.keys;

      for (var key in keys) {
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
              favList.add(true);
            } else {
              favList.add(false);
            }
          } else {
            favList.add(false);
          }
        });
      }
      Timer(Duration(seconds: 1), () {
        setState(() {});
      });
    });
  }

  void SearchMethod(String text) {
    DatabaseReference searchRef =
        FirebaseDatabase.instance.reference().child("Data");

    searchRef.once().then(
      (DataSnapshot snapshot) {
        dataList.clear();
        var keys = snapshot.value.keys;
        var values = snapshot.value;

        for (var key in keys) {
          Data data = Data(
            values[key]['imageUrl'],
            values[key]['name'],
            values[key]['material'],
            values[key]['price'],
            key,
          );
          //// key is the uploadid);
          if (data.name.contains(text)) {
            dataList.add(data);
          }
        }
        Timer(Duration(seconds: 1), () {
          setState(() {
            //
          });
        });
      },
    );
  }
}
