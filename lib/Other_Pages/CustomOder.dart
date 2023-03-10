import 'package:flutter/material.dart';
import 'DatabaseManager/DatabaseManager.dart';

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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserDeatails();
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

  String ClothType = "",
      FabricType = "",
      ClothTypeDiscrip = "",
      Colour = "",
      address = "",
      TimeDuration = "",
      Note = "",
      ContactNumber = "";
  int quantity = 1;

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

  @override
  Widget build(BuildContext context) {
    double scrnwidth = MediaQuery.of(context).size.width;
    double scrnheight = MediaQuery.of(context).size.height;
    if (type == "Men") {
      ClothTypeDiscrip = "Shirt/Trouser/Short...ect";
    }
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
                            hintText: ClothTypeDiscrip,
                          ),
                          validator: (text) {
                            if (text.toString().isEmpty) {
                              return 'Cloth type can not be empty';
                            }
                            return null;
                          },
                          onSaved: (text) {
                            ClothType = text.toString();
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
                            // hintText: ClothTypeDiscrip,
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
                          controller: TextEditingController(
                              text: userDeatails['address'].toString()),
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
                            Colour = text.toString();
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
                          margin: EdgeInsets.only(top: scrnheight * 0.03),
                          alignment: Alignment.bottomRight,
                          child: TextButton(
                            child: Text(
                              'Next',
                              style: TextStyle(
                                  fontSize: scrnheight * 0.025,
                                  color: Colors.orange,
                                  fontWeight: FontWeight.bold),
                            ),
                            onPressed: () async {
                              _formkey1.currentState!.save();
                              if (_formkey1.currentState!.validate()) {
                                print(
                                    "$ClothType $FabricType  $Colour $address $TimeDuration $Note $ContactNumber $quantity");
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
