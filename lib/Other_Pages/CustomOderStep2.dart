import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class CustomOderStep2 extends StatefulWidget {
  String uid, type;
  dynamic data;
  File? imageFile;
  CustomOderStep2(
      {super.key,
      required this.uid,
      required this.type,
      required this.data,
      required this.imageFile});

  @override
  State<CustomOderStep2> createState() =>
      _CustomOderStep2State(uid, type, data, imageFile!);
}

class _CustomOderStep2State extends State<CustomOderStep2> {
  String uid, type;
  dynamic data;
  File imageFile;
  _CustomOderStep2State(this.uid, this.type, this.data, this.imageFile);

  //upload img to firebase storage
  Future<void> uploadImage() async {
    if (imageFile == null) {
      return;
    }

    final firebase_storage.Reference ref = firebase_storage
        .FirebaseStorage.instance
        .ref()
        .child('customizedOderImage/$uid/$type')
        .child(DateTime.now().toString() + '.jpg');

    await ref.putFile(imageFile);
    final url = await ref.getDownloadURL();

    // Do something with the download URL (e.g. save to Firebase Firestore)
    print(url);
  }

  @override
  Widget build(BuildContext context) {
    double scrnwidth = MediaQuery.of(context).size.width;
    double scrnheight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Set measurements"),
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          Text(
              "${data['ClothType']}\n${data['FabricType']}\n${data['Colour']}\n${data['address']}\n${data['TimeDuration']}\n${data['Note']}\n${data['ContactNumber']}\n${data['quantity']}\n"),
          TextButton(
            child: Text(
              'Next',
              style: TextStyle(
                  fontSize: scrnheight * 0.025,
                  color: Colors.orange,
                  fontWeight: FontWeight.bold),
            ),
            onPressed: () async {
              await uploadImage();
            },
          ),
        ],
      )),
    );
  }
}
