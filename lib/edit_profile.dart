import 'dart:collection';
import 'dart:io';
import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  List genderList = ["Male", "Female", "Other"];

  var formKey = GlobalKey<FormState>();
  String name, birthDate, gender, address;
  FirebaseAuth auth = FirebaseAuth.instance;

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
      ),
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
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
                  height: 10.0,
                ),
                Text(
                  auth.currentUser.email,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
//////////////////////////////////  input text name
                Theme(
                  data: ThemeData(hintColor: Colors.blue),
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: 10.0,
                      right: 20.0,
                      left: 20.0,
                    ),
                    child: TextFormField(
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter your name';
                        } else {
                          name = value;
                        }
                      },
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.person_outline,
                          color: Colors.blue,
                        ),
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
                SizedBox(
                  height: 5.0,
                ),
/////////////////////////////  input date of birth
                Theme(
                  data: ThemeData(hintColor: Colors.blue),
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: 10.0,
                      right: 20.0,
                      left: 20.0,
                    ),
                    child: TextFormField(
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter your birth date';
                        } else {
                          birthDate = value;
                        }
                      },
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.event,
                          color: Colors.blue,
                        ),
                        labelText: 'Birth Date',
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
//////////////////////////////////////////////////////////
                //
/////////////////////////////////////////    gender type
                SizedBox(
                  height: 10.0,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Gender',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        addRadioButton(0, 'Male'),
                        addRadioButton(1, 'Female'),
                        addRadioButton(2, 'Others'),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.0,
                ),
/////////////////////////////  input date of birth
                Theme(
                  data: ThemeData(hintColor: Colors.blue),
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: 10.0,
                      right: 20.0,
                      left: 20.0,
                    ),
                    child: TextFormField(
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter your address';
                        } else {
                          address = value;
                        }
                      },
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.location_on,
                          color: Colors.blue,
                        ),
                        labelText: 'Address',
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
                SizedBox(
                  height: 20.0,
                ),
                RaisedButton.icon(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  icon: Icon(
                    Icons.save,
                    color: Colors.white,
                  ),
                  color: Color(0xFFEC407A),
                  label: Text(
                    'Save Data',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
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

//////////////////////////////////////////////////////////////////

  Future<void> _upload() async {
    if (formKey.currentState.validate()) {
      Reference reference = FirebaseStorage.instance
          .ref()
          .child('imagesUser')
          .child(new DateTime.now().millisecondsSinceEpoch.toString() +
              "." +
              imageFile.path);

      UploadTask uploadTask = reference.putFile(imageFile);

      uploadTask.whenComplete(() async {
        String imageUrl = await reference.getDownloadURL();
        String url = imageUrl.toString();

        DatabaseReference databaseReference =
            FirebaseDatabase.instance.reference().child("UserData");
        String uploadId = databaseReference.push().key;
        HashMap map = HashMap();
        map["imageUrl"] = url;
        map["name"] = name;
        map["birthDate"] = birthDate;
        map["gender"] = gender;
        map["address"] = address;

        databaseReference.child(uploadId).set(map);
      });
    }
  }

///////////////////   radio button gender type
  Row addRadioButton(int btnValue, String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Radio(
          activeColor: Colors.white,
          value: genderList[btnValue],
          groupValue: gender,
          onChanged: (value) {
            setState(() {
              print(value);
              gender = value;
            });
          },
        ),
        Text(
          title,
          style: TextStyle(
            color: Colors.blue,
          ),
        )
      ],
    );
  }
}
