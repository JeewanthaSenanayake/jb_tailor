import 'package:flutter/material.dart';
import 'package:jb_tailor/Other_Pages/DatabaseManager/DatabaseManager.dart';

class Chechout extends StatefulWidget {
  String uid;
  dynamic cartData;
  String oderID;
  Chechout(
      {super.key,
      required this.uid,
      required this.cartData,
      required this.oderID});

  @override
  State<Chechout> createState() => _ChechoutState(uid, cartData, oderID);
}

class _ChechoutState extends State<Chechout> {
  String uid;
  dynamic cartData;
  String oderID;
  _ChechoutState(this.uid, this.cartData, this.oderID);
  bool loading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserDeatails();
  }

  //get data
  dynamic userDeatails;
  dynamic adminData;

  getUserDeatails() async {
    dynamic data = await DatabaseManager().getUserDatails(uid);
    dynamic admin = await DatabaseManager().adminTelNo();
    setState(() {
      userDeatails = data;
      adminData = admin;
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    double scrnwidth = MediaQuery.of(context).size.width;
    double scrnheight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Checkout"),
      ),
      body: SingleChildScrollView(
        child: loading
            ? Container(
                alignment: Alignment.center,
                height: scrnheight,
                child: const Center(
                  child: CircularProgressIndicator(),
                ))
            : Container(
                margin: EdgeInsets.all(scrnheight * 0.01),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.home),
                        Text(
                          "Dilivery Address",
                          style: TextStyle(
                            fontSize: scrnheight * 0.02,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "${userDeatails['name']},\n${userDeatails['address']}",
                      style: const TextStyle(color: Colors.grey),
                    ),
                    Text('\n'),
                    Row(
                      children: [
                        const Icon(Icons.watch),
                        Text(
                          "Dilivery Time",
                          style: TextStyle(
                            fontSize: scrnheight * 0.02,
                          ),
                        ),
                      ],
                    ),
                    const Text(
                      "Standard time (6-7 days)",
                      // userDeatails['address'],
                      style: TextStyle(color: Colors.grey),
                    ),
                    Text(
                      "\n\n\nYour items\n",
                      style: TextStyle(
                        fontSize: scrnheight * 0.02,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(cartData['oderName']),
                        Text(cartData['price'])
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("\nQuantity"),
                        Text("\n${cartData['quantity'].toString()}")
                      ],
                    ),
                    Container(
                      height: 1,
                      width: scrnwidth,
                      color: Colors.black,
                      margin: const EdgeInsets.only(
                          left: 0, right: 0, top: 10, bottom: 10),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Subtotal"),
                        Text("${cartData['quantity']}*${cartData['price']}")
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(" "),
                        Text(
                            "${cartData['quantity'] * double.parse(cartData['price'])}")
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("\nDelivery fee"),
                        Text("\n${adminData['deliveryFee'].toString()}")
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "\nTotal",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: scrnheight * 0.021),
                        ),
                        Text(
                          "\n${(adminData['deliveryFee'] + cartData['quantity'] * double.parse(cartData['price'])).toString()}",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: scrnheight * 0.021),
                        )
                      ],
                    ),
                    Container(
                      height: 1,
                      width: scrnwidth,
                      color: Colors.black,
                      margin: const EdgeInsets.only(
                          left: 0, right: 0, top: 10, bottom: 10),
                    ),
                    Text(
                      "\nPayemnt option\n",
                      style: TextStyle(
                        fontSize: scrnheight * 0.02,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton.icon(
                            onPressed: () async {},
                            label: Text(
                              'Place oder',
                              style: TextStyle(fontSize: scrnheight * 0.02),
                            ),
                            icon: Icon(
                              Icons.payment,
                              size: scrnheight * 0.03,
                            ),
                            // <-- Text
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
      ),
    );
  }
}
