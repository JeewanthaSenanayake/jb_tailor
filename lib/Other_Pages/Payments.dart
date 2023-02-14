// import 'dart:convert';
// import 'dart:developer';

// import 'package:flutter/material.dart';
// import 'DatabaseManager/DatabaseManager.dart';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import 'package:flutter_stripe/flutter_stripe.dart';


// // import 'package:dio/dio.dart';

// class Payments extends StatefulWidget {
//   String uid;
//   Payments({required this.uid});

//   @override
//   State<StatefulWidget> createState() => _State1(uid);
// }

// class _State1 extends State<Payments> {
//   String uid;
//   _State1(this.uid);

//   dynamic pay = "Calculating...";

//   dynamic UserData = {
//     'fname': "Loading...",
//     'lname': "Loading...",
//     'vnumber': "Loading..."
//   };

//   dynamic VehicleData = {
//     'entrance': "Loading...",
//     'exit': "Loading...",
//     'exdate': "Loading...",
//     'extime': "Loading...",
//   };

//   @override
//   void initState() {
//     super.initState();
//     getDataBaseData();
//   }

//   getDataBaseData() async {
//     dynamic UserResalts = await DatabaseManager().getUserDatails(uid);
//     dynamic VehicleResalts = await DatabaseManager().getVehicleDatails(uid);
//     dynamic PaymentResalts = await DatabaseManager().paymentDatails(uid);

//     setState(() {
//       UserData = UserResalts;
//       VehicleData = VehicleResalts;
//       pay = PaymentResalts;
//     });
//   }

//   Future<void> initPayment(
//       {required String email,
//       required double ammount,
//       required BuildContext context}) async {
//     try {
//       // create payment
//        final response = await http.post(
//           Uri.parse(
//               'https://us-central1-easyhighwaypay.cloudfunctions.net/stripePaymentIntentRequest'),
//           body: {
//           'email': email,
//           'ammount': "$ammount",
//           'customer': "2",
//           });

//       print(response);

//       final jsonResponse = jsonDecode(response.body);
//       log(jsonResponse.toString());
//       print(response.statusCode);

//       //initializ sripe
//       await Stripe.instance.initPaymentSheet(
//           paymentSheetParameters: SetupPaymentSheetParameters(
//         paymentIntentClientSecret: jsonResponse['paymentIntent'],
//         merchantDisplayName: 'Easy High Way Pay',
//         customerId: jsonResponse['customer'],
//         customerEphemeralKeySecret: jsonResponse['ephemeralKey'],
//         // testEnv: true,
//         // merchantCountryCode: 'SG',
//       ));
//       await Stripe.instance.presentPaymentSheet();
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text('Payment is successful'),
//         ),
//       );
//     } catch (errorr) {
//       if (errorr is StripeException) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content:
//                 Text('An error occured 1 ${errorr.error.localizedMessage}'),
//           ),
//         );
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text('An error occured 2 $errorr'),
//           ),
//         );
//         print(errorr);
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         // automaticallyImplyLeading: false,
//         title: Text('Payments'),
//       ),
//       body: SingleChildScrollView(
//           child: Column(children: <Widget>[
//         const SizedBox(height: 20),
//         Container(
//             alignment: Alignment.topCenter,
//             padding: const EdgeInsets.all(15),
//             child: Text(
//               "Pay & Go",
//               style: const TextStyle(
//                 color: Color.fromARGB(255, 255, 0, 0),
//                 fontSize: 30,
//                 fontWeight: FontWeight.w700,
//               ),
//             )),
//         const SizedBox(height: 40),
//         Container(
//             alignment: Alignment.topLeft,
//             padding: const EdgeInsets.all(10),
//             child: Text(
//               "Vehicle Number:\t\t${UserData['vnumber']}\n\nEntrance:\t\t${VehicleData['entrance']}\n\nExit:\t\t${VehicleData['exit']}\n\nDate:\t\t${VehicleData['exdate']}\n\nTime:\t\t${VehicleData['extime']}",
//               style: const TextStyle(
//                 color: Colors.black,
//                 fontSize: 25,
//                 fontWeight: FontWeight.w600,
//               ),
//             )),
//         const SizedBox(height: 40),
//         Container(
//           alignment: Alignment.center,
//           padding: const EdgeInsets.all(10),
//           child: Text(
//             "Rs:$pay",
//             style: const TextStyle(
//               color: Color.fromARGB(255, 255, 0, 0),
//               fontSize: 25,
//               fontWeight: FontWeight.w600,
//             ),
//           ),
//         ),
//         const SizedBox(height: 20),
//         Container(
//           child: RaisedButton(
//             color: Colors.blueAccent,
//             textColor: Colors.white,
//             child: Text('Pay'),

//             onPressed: () {
//               initPayment(email: "ssbjms123@gmail.com", ammount: 52.0, context: context);
//               print("object");
//             },
// //            {
// //              Navigator.of(context).push(MaterialPageRoute(
// //                builder: (context) => Payments(uid: uid),
// //              ));
// //            },
//           ),
//         )
//       ])),
//     );
//   }
// }
