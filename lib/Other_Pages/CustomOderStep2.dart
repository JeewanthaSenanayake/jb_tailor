import 'package:flutter/material.dart';
import 'package:jb_tailor/Other_Pages/DatabaseManager/DatabaseManager.dart';
import 'package:jb_tailor/Other_Pages/Oder.dart';
import 'package:jb_tailor/Other_Pages/OnlinePayment/OnlinePayment.dart';

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
  bool loading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    inputDataFiled();
  }

  dynamic adminData;
  inputDataFiled() async {
    dynamic adminDataSet = await DatabaseManager().adminTelNo();

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
    setState(() {
      adminData = adminDataSet;
      loading = false;
    });
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
      body: loading
          ? Container(
              alignment: Alignment.center,
              height: scrnheight,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            )
          : SingleChildScrollView(
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
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Color.fromARGB(255, 182, 189, 190)),
                            ),
                            onPressed: () {
                              showGuideImage(scrnheight, scrnwidth);
                            },
                            child: Text(
                              "Guide Image",
                              style: TextStyle(
                                  fontSize: scrnheight * 0.02,
                                  color: Color.fromARGB(255, 0, 0, 0),
                                  fontWeight: FontWeight.bold),
                            )),
                      ),
                      // Image.network(
                      //   data["basicData"]["url"],
                      //   height: scrnwidth * 0.5,
                      // ),
                      FadeInImage(
                        placeholder:
                            const AssetImage('assets/loading/loading.jpg'),
                        image: NetworkImage("${data["basicData"]["url"]}"),
                        height: scrnheight * 0.15,
                      ),
                      Container(
                          padding: const EdgeInsets.only(top: 16.0),
                          alignment: Alignment.bottomLeft,
                          child: const Text(
                            "Please input all measurements are in cm",
                            style: TextStyle(color: Colors.red),
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
                Container(
                  margin: const EdgeInsets.all(10.0),
                  alignment: Alignment.topLeft,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Price : ${double.parse(data['price'])}",
                          style: TextStyle(fontSize: 15),
                        ),
                        Container(
                            margin: EdgeInsets.only(top: 7, bottom: 7),
                            child: Text(
                                "Delivery : ${adminData['deliveryFee']}",
                                style: TextStyle(fontSize: 15))),
                        Text(
                          "Total : ${double.parse(data['price']) + adminData['deliveryFee']}",
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                      ]),
                ),
                SizedBox(
                  width: scrnwidth * 0.5,
                  height: scrnheight * 0.055,
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
                            'Place order',
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
                        int ammount = ((double.parse(data['price']) +
                                    adminData['deliveryFee']) *
                                100)
                            .toInt();
                        if (await OnlinePayment()
                            .makePayment(ammount.toString())) {
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
                ),
              ],
            )),
    );
  }
}
