import 'package:flutter/material.dart';
import 'Login_Screen.dart';
import 'Services/AuthenticationServices.dart';

class SinginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<SinginPage> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  final AuthenticationServices _auth = AuthenticationServices();

  String _Fname = "";
  String _Lname = "";
  String _Email = "";
  // String _ConEmail = "";
  String _Address = "";
  String _Password = "";
  String _ConPassword = "";

  Widget _CreateTextFeald(value, len, hidetext) {
    return TextFormField(
      maxLength: len,
      obscureText: hidetext,
      decoration: InputDecoration(
        labelText: value,
      ),
      // decoration: InputDecoration(
      //   border: OutlineInputBorder(),
      //   labelText: value,
      // ),
      validator: (text) {
        if (text.toString().isEmpty) {
          return '$value cannot be empty';
        }

        if (value == 'Password' || value == 'Confirm Password') {
          if (!(_Password == _ConPassword)) {
            return 'Password doesnt match';
          } else if (_Password.length < 8) {
            return 'Password must contains at least 8 charactors';
          }
        }

        // if (value == 'Email' || value == 'Confirm Email') {
        //   if (!(_Email == _ConEmail)) {
        //     return 'Email doesnt match';
        //   }
        // }

        return null;
      },
      onSaved: (text) {
        if (value == 'First Name') {
          _Fname = text.toString();
        } else if (value == 'Last Name') {
          _Lname = text.toString();
        } else if (value == 'Email') {
          _Email = text.toString();
        } else if (value == 'Confirm Email') {
          // _ConEmail = text.toString();
        } else if (value == 'Delivery Address') {
          _Address = text.toString();
        } else if (value == 'Password') {
          _Password = text.toString();
        } else if (value == 'Confirm Password') {
          _ConPassword = text.toString();
        }
      },
    );
  }

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
                    'Create Account',
                    style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                  ),
                ),

                const SizedBox(
                  height: 40,
                ),

                _CreateTextFeald('First Name', 15, false), //call function
                _CreateTextFeald('Last Name', 15, false),
                _CreateTextFeald('Email', 30, false),
                // _CreateTextFeald('Confirm Email', 30, false),
                _CreateTextFeald('Password', 12, true),
                _CreateTextFeald('Confirm Password', 12, true),
                _CreateTextFeald('Delivery Address', 30, false),

                const SizedBox(
                  height: 10,
                ),

                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(255, 42, 188, 171), // background
                    // onPrimary: Colors.white, // foreground
                  ),
                  child: const Text(
                    'Sign Up',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                    ),
                  ),
                  onPressed: () {
                    _formkey.currentState!.save();
                    if (_formkey.currentState!.validate()) {
                      print('fname = ' + _Fname);
                      print('lname = ' + _Lname);
                      print('email = ' + _Email);
                      // print('conemail = ' + _ConEmail);
                      print('VR = ' + _Address);
                      print('pass = ' + _Password);
                      print('Cpas = ' + _ConPassword);

                      //database connection
                      createUser();

                      //  Navigator.defaultGenerateInitialRoutes(navigator, initialRouteName)
                    } else {
                      _Fname = "";
                      _Lname = "";
                      _Email = "";
                      // _ConEmail = "";
                      _Address = "";
                      _Password = "";
                      _ConPassword = "";
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void createUser() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );

    dynamic result =
        await _auth.createNewUser(_Email, _Password, _Fname, _Lname, _Address);

    if (result == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Email is not valid"),
        ),
      );
      Navigator.of(context).pop();

      print("Email is not valide");
    } else {
      print(result.toString());
      _Fname = "";
      _Lname = "";
      _Email = "";
      // _ConEmail = "";
      _Address = "";
      _Password = "";
      _ConPassword = "";
      Navigator.of(context).popUntil((route) => route.isFirst);
    }
  }
}
