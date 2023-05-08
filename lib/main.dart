import "package:flutter/material.dart";
import 'package:flutter_stripe/flutter_stripe.dart';
import 'Other_Pages/Login_Screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey =
      "pk_test_51Ll0yTCVIWYVyGGaWjkeHPEwQw1nHApyaZrhKjM0VbPrHsaAZFdJGc2pxVkHK228UfWTDyhdVo3BA0yaCZ1K4Iiq00obJh0Xa0";

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.teal),
        home: LoginPage());
  }
}

// Is pending
// 0-delete 
// 1-in customized order customer placed order, tailor may or may not be accepted (tailor accepted can be identified using the price tag) / readymade order in the cart
// 2 – customer paid it means working with order, wrapping with order
// 3 – tailor posted order
// 4 -  received order
// 5 – rejected order
