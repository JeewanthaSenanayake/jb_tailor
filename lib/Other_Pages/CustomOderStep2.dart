import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:jb_tailor/Other_Pages/DatabaseManager/DatabaseManager.dart';
import 'package:jb_tailor/Other_Pages/Oder.dart';

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

  List<TextFormField> TextForm = [];
  List<dynamic> inputData = [];
  List<String> inputDataName = [];
  final GlobalKey<FormState> _formkey1 = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    if (data['ClothType'] == "Skirt") {
      inputDataName = ["Waist", "Hips", "Waist to length", "Crotch length"];
      for (String name in inputDataName) {
        TextForm.add(
          TextFormField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              // border: OutlineInputBorder(),
              labelText: "$name*",
              labelStyle: const TextStyle(
                // fontSize: scrnheight * 0.02,
                color: Colors.black,
              ),
              // hintText: ClothTypeDiscrip,
            ),
            validator: (text) {
              if (text.toString().isEmpty) {
                return '$name can not be empty';
              }
              final doubleNumber = double.tryParse(text!);
              final intNumber = int.tryParse(text);
              if (doubleNumber == null && intNumber == null) {
                return 'Invalide $name';
              }
              if (double.parse(text) <= 0) {
                return '$name can not be zero or negative';
              }

              return null;
            },
            onSaved: (text) {
              if (_formkey1.currentState!.validate()) {
                inputData.add({name: text.toString()});
              }
            },
          ),
        );
      }
    }
  }

  //upload img to firebase storage
  Future<String> uploadImage() async {
    if (imageFile == null) {
      return "fail";
    }

    final firebase_storage.Reference ref = firebase_storage
        .FirebaseStorage.instance
        .ref()
        .child('customizedOderImage/$uid/$type')
        .child(DateTime.now().toString() + '.jpg');

    await ref.putFile(imageFile);
    final url = await ref.getDownloadURL();

    // Do something with the download URL (e.g. save to Firebase Firestore)
    return url;
    // print(url);
  }

  void showGuideImage(double scrnheight, double scrnwidth) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
              title: const Text('Refer this image as guide'),
              children: <Widget>[
                Image.asset(
                  "assets/Guide/women_guide.png",
                  width: scrnwidth,
                  // width: 70,
                ),
                Container(
                  alignment: Alignment.bottomCenter,
                  child: TextButton(
                    child: const Text("Ok"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ]);
        });
  }

  bool _isLoading = false;
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
          Container(
            margin: const EdgeInsets.all(10.0),
            alignment: Alignment.center,
            child: Column(
              children: [
                Image.file(
                  imageFile,
                  height: scrnwidth * 0.5,
                ),
                TextButton(
                    onPressed: () {
                      showGuideImage(scrnheight, scrnwidth);
                    },
                    child: Text(
                      "Get guide Image",
                      style: TextStyle(
                          fontSize: scrnheight * 0.02, color: Colors.red),
                    ))
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.all(10.0),
            child: Form(
                key: _formkey1,
                child: Column(
                  children: TextForm,
                )),
          ),
          ElevatedButton(
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
                    'Submit',
                    style: TextStyle(
                        fontSize: scrnheight * 0.025,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
            onPressed: () async {
              setState(() {
                _isLoading = true;
              });
              _formkey1.currentState!.save();
              if (_formkey1.currentState!.validate()) {
                String URL = await uploadImage();
                if (URL != "fail") {
                  inputData.add({"url": URL});
                  Map<String, String> dataMeasurements = {
                    for (var inputData in inputData)
                      inputData.keys.first: inputData.values.first
                  };
                  await DatabaseManager()
                      .addCustomOder(uid, data, dataMeasurements);
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
        ],
      )),
    );
  }
}
