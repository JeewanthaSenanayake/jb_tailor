import 'package:flutter/material.dart';
// import 'package:jb_tailor/Other_Pages/Send_email.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ForgotPasswordPage extends StatefulWidget {
  // const ForgotPasswordPage({super.key});

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<ForgotPasswordPage> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  String Email = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formkey,
          child: Container(
            margin: const EdgeInsets.all(24.0),
            child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 10,
                ),
                Container(
                  alignment: Alignment.topLeft,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: const Icon(
                      Icons.arrow_back,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                const Align(
                  alignment: Alignment.topCenter,
                  child: Text(
                    'Reset Password',
                    style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                const Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                      "Enter the Email associated with your account and we'll send an Email with instruction to reset your password.",
                      style: TextStyle(fontSize: 18)),
                ),
                const SizedBox(
                  height: 40,
                ),
                TextFormField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Email",
                    ),
                    validator: (text) {
                      if (text.toString().isEmpty) {
                        return 'Email cannot be empty';
                      }
                    },
                    onSaved: (text) {
                      Email = text.toString();
                    }),
                const SizedBox(
                  height: 15,
                ),
                Container(
                  child: ElevatedButton(
                    child: const Text(
                      'Send email',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                    onPressed: () {
                      _formkey.currentState!.save();
                      if (_formkey.currentState!.validate()) {
                        print(Email);
                        //database connection
                        resetPassword();
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(builder: (context) => SendEmail()),
                        // );
                      } else {
                        Email = "";
                      }
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future resetPassword() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Center(
        child: CircularProgressIndicator(),
      ),
    );
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: Email);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Password reset email sent'),
        ),
      );
      Navigator.of(context).popUntil((route) => route.isFirst);
      
    } on FirebaseException catch (e) {
      print(e);
      // Utils.showSnackBar(e.message);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("This emil does not have an account"),
        ),
      );
      Navigator.of(context).pop();
    }
  }
}
