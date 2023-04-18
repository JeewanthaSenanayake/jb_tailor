import 'dart:io';
import 'package:flutter/material.dart';
import 'DatabaseManager/DatabaseManager.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import 'Oder.dart';

class CustomOder extends StatefulWidget {
  String uid, type;
  CustomOder({super.key, required this.uid, required this.type});

  @override
  State<CustomOder> createState() => _CustomOderState(uid, type);
}

class _CustomOderState extends State<CustomOder> {
  String uid, type;
  _CustomOderState(this.uid, this.type);

  bool loading = true;

  // for input data
  String FabricType = "",
      Colour = "",
      address = "",
      TimeDuration = "",
      Note = "",
      ContactNumber = "",
      imageValidator = "",
      SelectedType = "";
  int quantity = 1;

  String clothItems = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserDeatails();

    if (type == "Men") {
      clothItems = "Shirt, Trouser ...";
    } else if (type == "Women") {
      clothItems = "Skirt, Blouse, Frock ...";
    } else if (type == "Kids") {
      clothItems = "Trouser, Short, Frock ...";
    }
  }

  //get data
  dynamic userDeatails;

  getUserDeatails() async {
    dynamic data = await DatabaseManager().getUserDatails(uid);
    setState(() {
      userDeatails = data;
      loading = false;
    });
  }

  final GlobalKey<FormState> _formkey1 = GlobalKey<FormState>();

  void incresequantity() {
    setState(() {
      quantity++;
    });
  }

  void decreasequanitity() {
    setState(() {
      if (quantity > 1) {
        quantity--;
      }
    });
  }

// select image from galary
  File? _imageFile;
  final picker = ImagePicker();

  Future<void> getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      // Do something with the picked image file, e.g. display it in an Image widget
      // or upload it to a server
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  //upload img to firebase storage
  Future<String> uploadImage() async {
    if (_imageFile == null) {
      return "fail";
    }

    final firebase_storage.Reference ref = firebase_storage
        .FirebaseStorage.instance
        .ref()
        .child('customizedOderImage/$uid/$type')
        .child(DateTime.now().toString() + '.jpg');

    await ref.putFile(_imageFile!);
    final url = await ref.getDownloadURL();

    // Do something with the download URL (e.g. save to Firebase Firestore)
    return url;
    // print(url);
  }

  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    double scrnwidth = MediaQuery.of(context).size.width;
    double scrnheight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Details about the clothing item"),
      ),
      body: SingleChildScrollView(
        child: loading
            ? Container(
                alignment: Alignment.center,
                height: scrnheight,
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              )
            : Container(
                margin: const EdgeInsets.all(10.0),
                child: Form(
                    key: _formkey1,
                    child: Column(
                      children: [
                        TextFormField(
                          decoration: InputDecoration(
                            // border: OutlineInputBorder(),
                            labelText: 'Cloth type*',
                            labelStyle: TextStyle(
                              fontSize: scrnheight * 0.02,
                              color: Colors.black,
                            ),
                            hintText: clothItems,
                          ),
                          validator: (text) {
                            if (text.toString().isEmpty) {
                              return 'Cloth type can not be empty';
                            }
                            return null;
                          },
                          onSaved: (text) {
                            SelectedType = text.toString();
                          },
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            // border: OutlineInputBorder(),
                            labelText: 'Fabric type*',
                            labelStyle: TextStyle(
                              fontSize: scrnheight * 0.02,
                              color: Colors.black,
                            ),
                            hintText: "Viscose, Cotton, Mazza...",
                          ),
                          validator: (text) {
                            if (text.toString().isEmpty) {
                              return 'Fabric type can not be empty';
                            }
                            return null;
                          },
                          onSaved: (text) {
                            FabricType = text.toString();
                          },
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            // border: OutlineInputBorder(),
                            labelText: 'Colour*',
                            labelStyle: TextStyle(
                              fontSize: scrnheight * 0.02,
                              color: Colors.black,
                            ),
                            hintText:
                                'Please explain each part colour in deatail',
                          ),
                          validator: (text) {
                            if (text.toString().isEmpty) {
                              return 'Colour can not be empty';
                            }
                            return null;
                          },
                          onSaved: (text) {
                            Colour = text.toString();
                          },
                        ),
                        Row(children: [
                          Text(
                            "Quantity*",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: scrnheight * 0.02,
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.remove),
                            color: Colors.black,
                            onPressed: () {
                              decreasequanitity();
                            },
                          ),
                          Text(
                            "$quantity",
                          ),
                          IconButton(
                            icon: const Icon(Icons.add),
                            color: Colors.black,
                            onPressed: () {
                              incresequantity();
                            },
                          ),
                        ]),
                        TextFormField(
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            // border: OutlineInputBorder(),
                            labelText: 'Time duration - in weeks*',
                            labelStyle: TextStyle(
                              fontSize: scrnheight * 0.02,
                              color: Colors.black,
                            ),
                            // hintText: ClothTypeDiscrip,
                          ),
                          validator: (text) {
                            if (text.toString().isEmpty) {
                              return 'Time duration can not be empty';
                            }
                            final doubleNumber = double.tryParse(text!);
                            final intNumber = int.tryParse(text);
                            if (doubleNumber == null && intNumber == null) {
                              return 'Invalide time duration';
                            }
                            if (double.parse(text) <= 0) {
                              return 'Time duration can not be zero or negative';
                            }

                            return null;
                          },
                          onSaved: (text) {
                            TimeDuration = text.toString();
                          },
                        ),
                        TextFormField(
                          initialValue: userDeatails['address'],
                          decoration: InputDecoration(
                            // border: OutlineInputBorder(),
                            labelText: 'Delivery address*',
                            labelStyle: TextStyle(
                              fontSize: scrnheight * 0.02,
                              color: Colors.black,
                            ),
                          ),
                          validator: (text) {
                            if (text.toString().isEmpty) {
                              return 'Address can not be empty';
                            }
                            return null;
                          },
                          onSaved: (text) {
                            address = text.toString();
                          },
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            // border: OutlineInputBorder(),
                            labelText: 'Note',
                            labelStyle: TextStyle(
                              fontSize: scrnheight * 0.02,
                              color: Colors.black,
                            ),
                            // hintText: ClothTypeDiscrip,
                          ),
                          validator: (text) {
                            return null;
                          },
                          onSaved: (text) {
                            Note = text.toString();
                          },
                        ),
                        TextFormField(
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            // border: OutlineInputBorder(),
                            labelText: 'Contact Number*',
                            labelStyle: TextStyle(
                              fontSize: scrnheight * 0.02,
                              color: Colors.black,
                            ),
                            // hintText: ClothTypeDiscrip,
                          ),
                          validator: (text) {
                            if (text.toString().isEmpty) {
                              return 'Contact Number can not be empty';
                            }
                            if (!RegExp(r'^[+0-9]+$').hasMatch(text!)) {
                              return 'Contact Number can only contain the characters "+0123456789"';
                            }
                            if (text.length != 10 && text.length != 12) {
                              return 'Invalide phone number';
                            }
                            return null;
                          },
                          onSaved: (text) {
                            ContactNumber = text.toString();
                          },
                        ),
                        Container(
                          alignment: Alignment.topLeft,
                          child: TextButton(
                            child: Column(
                              children: [
                                Container(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    'Browse image*',
                                    style: TextStyle(
                                      fontSize: scrnheight * 0.02,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    imageValidator,
                                    style: TextStyle(
                                      fontSize: scrnheight * 0.0125,
                                      color: Colors.red,
                                    ),
                                  ),
                                )
                              ],
                            ),
                            onPressed: () async {
                              getImage();
                            },
                          ),
                        ),
                        Container(
                          alignment: Alignment.topLeft,
                          child: _imageFile != null
                              ? GestureDetector(
                                  onTap: () {
                                    getImage();
                                  },
                                  child: Image.file(
                                    _imageFile!,
                                    width: scrnwidth * 0.43,
                                  ))
                              : Container(
                                  child: GestureDetector(
                                    onTap: () {
                                      getImage();
                                    },
                                    child: Image.asset(
                                      "assets/home/lodeImg.jpg",
                                      width: scrnwidth * 0.43,
                                      // width: 70,
                                    ),
                                  ),
                                ),
                        ),
                        Container(
                          alignment: Alignment.bottomCenter,
                          child: ElevatedButton(
                            child: _isLoading
                                ? const SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 3,
                                      color: Colors.white,
                                    ),
                                  )
                                : Text(
                                    'Submit Order',
                                    style: TextStyle(
                                        fontSize: scrnheight * 0.025,
                                        fontWeight: FontWeight.bold),
                                  ),
                            onPressed: () async {
                              _formkey1.currentState!.save();
                              if (_imageFile == null) {
                                setState(() {
                                  imageValidator =
                                      "Plese select a image from your galary";
                                });
                              }
                              if (_formkey1.currentState!.validate() &&
                                  _imageFile != null) {
                                setState(() {
                                  _isLoading = true;
                                });
                                String URL = await uploadImage();
                                if (URL != "fail") {
                                  dynamic data = {
                                    "ClothType": SelectedType,
                                    "FabricType": FabricType,
                                    "Colour": Colour,
                                    "address": address,
                                    "TimeDuration": TimeDuration,
                                    "Note": Note,
                                    "ContactNumber": ContactNumber,
                                    "quantity": quantity,
                                    "url": URL
                                  };

                                  await DatabaseManager()
                                      .addCustomOderStep1(uid, data,type);

                                  setState(() {
                                    _isLoading = false;
                                  });

                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => Oder(
                                            uid: uid,
                                          )));
                                }
                              }
                            },
                          ),
                        ),
                      ],
                    )),
              ),
      ),
    );
  }
}
