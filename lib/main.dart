
import "package:flutter/material.dart";
import 'package:flutter_stripe/flutter_stripe.dart';
import 'Other_Pages/Login_Screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';



Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey = "pk_test_51Ll0yTCVIWYVyGGaWjkeHPEwQw1nHApyaZrhKjM0VbPrHsaAZFdJGc2pxVkHK228UfWTDyhdVo3BA0yaCZ1K4Iiq00obJh0Xa0";

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
