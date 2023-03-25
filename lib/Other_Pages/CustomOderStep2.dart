import 'package:flutter/material.dart';
import 'package:jb_tailor/Other_Pages/DatabaseManager/DatabaseManager.dart';
import 'package:jb_tailor/Other_Pages/Oder.dart';

import 'OnlinePayment/OnlinePayment.dart';

class CustomOderStep2 extends StatefulWidget {
  String uid, customOderId;
  dynamic data;
  CustomOderStep2({
    super.key,
    required this.uid,
    required this.customOderId,
    required this.data,
  });

  @override
  State<CustomOderStep2> createState() => _CustomOderStep2State(
        uid,
        customOderId,
        data,
      );
}

class _CustomOderStep2State extends State<CustomOderStep2> {
  String uid, customOderId;
  dynamic data;
  _CustomOderStep2State(this.uid, this.customOderId, this.data);

  List<TextFormField> TextForm = [];
  List<dynamic> inputData = [];
  List<String> inputDataName = [];
  final GlobalKey<FormState> _formkey1 = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    inputDataFiled();
  }

  inputDataFiled() {
    for (String name in data["Measurements"]) {
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

  void showGuideImage(double scrnheight, double scrnwidth) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
              // title: const Text('Refer this image as guide'),
              children: <Widget>[
                InteractiveViewer(
                  child: Image.asset(
                    "assets/Guide/women_guide.jpg",
                    width: scrnwidth,
                    // width: 70,
                  ),
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
                Container(
                  alignment: Alignment.topRight,
                  child: ElevatedButton(
                      onPressed: () {
                        showGuideImage(scrnheight, scrnwidth);
                      },
                      child: Text(
                        "Get guide Image",
                        style: TextStyle(
                            fontSize: scrnheight * 0.02, color: Colors.yellow),
                      )),
                ),
                // Image.network(
                //   data["basicData"]["url"],
                //   height: scrnwidth * 0.5,
                // ),
                FadeInImage(
                  placeholder: const AssetImage('assets/loading/loading.jpg'),
                  image: NetworkImage("${data["basicData"]["url"]}"),
                  height: scrnheight * 0.15,
                ),
                Container(
                    padding: const EdgeInsets.only(top: 16.0),
                    alignment: Alignment.bottomLeft,
                    child:
                        const Text("Please input all measurements are in cm"))
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
              _formkey1.currentState!.save();
              if (_formkey1.currentState!.validate()) {
                setState(() {
                  _isLoading = true;
                });
                if (await OnlinePayment().makePayment(
                    (double.parse(data['price']) * 100).toInt().toString())) {
                  await DatabaseManager().customOderPaymentSucsessful(
                      data, inputData, customOderId, uid);

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
