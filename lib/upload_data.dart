import 'dart:collection';
import 'dart:io';
import 'dart:async';
import 'dart:ui';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UploadDate extends StatefulWidget {
  @override
  _UploadDateState createState() => _UploadDateState();
}

class _UploadDateState extends State<UploadDate> {
  File imageFile;

  void _openGallery(BuildContext context) async {
    var picture = await ImagePicker.pickImage(source: ImageSource.gallery);
    this.setState(() {
      imageFile = picture;
    });
    Navigator.of(context).pop();
  }

  void _openCamera(BuildContext context) async {
    var picture = await ImagePicker.pickImage(source: ImageSource.camera);
    this.setState(() {
      imageFile = picture;
    });
    Navigator.of(context).pop();
  }

  var formKey = GlobalKey<FormState>();
  String name, material, price;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1A237E),
      appBar: AppBar(
        backgroundColor: Color(0xFFEC407A),
        title: Text(
          'Upload Data',
          style: TextStyle(
            color: Color(0xFFFFFFFF),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 20.0),
                ),
                Container(
                  child: imageFile == null
                      ? FlatButton(
                          onPressed: () {
                            _showDialog(context);
                          },
                          child: Icon(
                            Icons.add_a_photo,
                            size: 50.0,
                            color: Color(0xFFEC407A),
                          ),
                        )
                      : Image.file(
                          imageFile,
                          width: 200.0,
                          height: 200.0,
                        ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  'Product Details',
                  style: TextStyle(
                    color: Color(0xFFEC407A),
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                SizedBox(
                  height: 20.0,
                ),
/////////////    add product name input text
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Theme(
                        data: ThemeData(hintColor: Colors.blue),
                        child: Padding(
                          padding: EdgeInsets.only(
                            left: 5.0,
                          ),
                          child: TextFormField(
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter the name of product';
                              } else {
                                name = value;
                              }
                            },
                            style: TextStyle(
                              color: Colors.white,
                            ),
                            decoration: InputDecoration(
                              labelText: 'Name',
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
                    ),
                    // SizedBox(
                    //   width: 2.0,
                    // ),
                    Expanded(
                      flex: 1,
                      child: Theme(
                        data: ThemeData(hintColor: Colors.blue),
                        child: Padding(
                          padding: EdgeInsets.only(
                            left: 5.0,
                          ),
                          child: TextFormField(
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter the material of product';
                              } else {
                                material = value;
                              }
                            },
                            style: TextStyle(
                              color: Colors.white,
                            ),
                            decoration: InputDecoration(
                              labelText: 'Material',
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
                    ),
                    // SizedBox(
                    //   width: 5.0,
                    // ),
                    Expanded(
                      flex: 1,
                      child: Theme(
                        data: ThemeData(hintColor: Colors.blue),
                        child: Padding(
                          padding: EdgeInsets.only(
                            left: 5.0,
                          ),
                          child: TextFormField(
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter the price of product';
                              } else {
                                price = value;
                              }
                            },
                            style: TextStyle(
                              color: Colors.white,
                            ),
                            decoration: InputDecoration(
                              labelText: 'Price',
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
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.0,
                ),
/////////////////   button to upload  data
                RaisedButton(
                  onPressed: () {
                    if (imageFile == null) {
                      Fluttertoast.showToast(
                          msg: 'Please select an image',
                          gravity: ToastGravity.CENTER,
                          toastLength: Toast.LENGTH_LONG,
                          timeInSecForIosWeb: 2);
                    } else {
                      _upload();
                    }
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  color: Color(0xFFEC407A),
                  child: Text(
                    'Upload',
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.blue,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

///////////////////////////////////////////////////////////////
  Future<void> _showDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Text("From where do you want to take the photo?"),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    GestureDetector(
                      child: Text("Gallery"),
                      onTap: () {
                        _openGallery(context);
                      },
                    ),
                    Padding(padding: EdgeInsets.all(8.0)),
                    GestureDetector(
                      child: Text("Camera"),
                      onTap: () {
                        _openCamera(context);
                      },
                    )
                  ],
                ),
              ));
        });
  }

  Future<void> _upload() async {
    if (formKey.currentState.validate()) {
      Reference reference = FirebaseStorage.instance
          .ref()
          .child('images')
          .child(new DateTime.now().millisecondsSinceEpoch.toString() +
              "." +
              imageFile.path);

      UploadTask uploadTask = reference.putFile(imageFile);

      uploadTask.whenComplete(() async {
        String imageUrl = await reference.getDownloadURL();
        String url = imageUrl.toString();

        DatabaseReference databaseReference =
            FirebaseDatabase.instance.reference().child("Data");
        String uploadId = databaseReference.push().key;
        HashMap map = HashMap();
        map["imageUrl"] = url;
        map["name"] = name;
        map["material"] = material;
        map["price"] = price;

        databaseReference.child(uploadId).set(map);
      });
    }
  }
}
