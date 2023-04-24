import 'package:flutter/material.dart';
import 'Signin_Screen.dart';
import 'Forgot_Password.dart';
import 'package:jb_tailor/Other_Pages/Services/AuthenticationServices.dart';
import 'package:jb_tailor/Other_Pages/Home_Screen.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<LoginPage> {
  final GlobalKey<FormState> _formkey1 = GlobalKey<FormState>();

  final AuthenticationServices _auth = AuthenticationServices();

  String _LogEmail = "";
  String _LogPassword = "";

  bool UsernamePassword = false;

  String name = '';

  bool loading = false;
  String LogingId = "";

  @override
  void initState() {
    super.initState();
    isLogedOrNot();
  }

  isLogedOrNot() async {
    String islogd = await _auth.getCurrentUser();

    setState(() {
      if (islogd == "null") {
        loading = false;
        // print("$islogd no log");
      } else {
        loading = true;
        LogingId = islogd;
        // print("$islogd log");
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => HomePage(uid: LogingId)));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double scrnheight = MediaQuery.of(context).size.height;
    return Scaffold(
        body: loading
            ? Container(
                alignment: Alignment.center,
                height: scrnheight,
                child: const Center(
                  child: CircularProgressIndicator(),
                ))
            : Padding(
                padding: EdgeInsets.all(10),
                child: Form(
                  key: _formkey1,
                  child: ListView(
                    children: <Widget>[
                      const SizedBox(
                        height: 120,
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        child: TextFormField(
                          decoration: const InputDecoration(
                            // border: OutlineInputBorder(),
                            icon: Icon(
                              Icons.account_circle_rounded,
                              size: 40.0,
                            ),
                            labelText: 'Email',
                          ),
                          validator: (text) {
                            if (text.toString().isEmpty) {
                              return 'Email can not be empty';
                            }

                            if (UsernamePassword) {
                              return 'Invalid Username or Password';
                            }

                            return null;
                          },
                          onSaved: (text) {
                            _LogEmail = text.toString();
                          },
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                        child: TextFormField(
                          obscureText: true,
                          //controller: passwordController,
                          decoration: const InputDecoration(
                            // border: OutlineInputBorder(),
                            icon: Icon(
                              Icons.explore_rounded,
                              size: 40.0,
                            ),
                            labelText: 'Password',
                          ),
                          validator: (text) {
                            if (text.toString().isEmpty) {
                              return 'Password cannot be empty';
                            }

                            if (UsernamePassword) {
                              return 'Invalid Username or Password';
                            }

                            return null;
                          },
                          onSaved: (text) {
                            _LogPassword = text.toString();
                          },
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          //forgot password screen
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ForgotPasswordPage()),
                          );
                        },
                        //  textColor: Color.fromARGB(255, 0, 0, 255),
                        style: TextButton.styleFrom(
                          foregroundColor: Color.fromARGB(255, 0, 0, 255),
                        ),
                        child: const Align(
                          alignment: Alignment.topRight,
                          child: Text(
                            'Forgot Password?',
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                          height: 50,
                          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Color.fromARGB(
                                  255, 42, 188, 171), // background
                              // onPrimary: Colors.white, // foreground
                            ),
                            child: const Text(
                              'Login',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            onPressed: () {
                              if (_formkey1.currentState!.validate()) {
                                _formkey1.currentState!.save();
                                logInUser();
                              } else {
                                _LogEmail = "";
                                _LogPassword = "";
                                UsernamePassword = false;
                              }
                            },
                          )),
                      const SizedBox(
                        height: 50,
                      ),
                      Container(
                        child: const Align(
                          alignment: Alignment.center,
                          child: Text(
                            'or login with',
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Gesture detector for facebook Login
                              GestureDetector(
                                onTap: () {
                                  // Call facebook login methon
                                  // AuthService().signInWithFacebook();
                                  print("facebook");
                                },
                                child: Image.asset(
                                  "assets/icons/facebook.png",
                                  height: 55,
                                  width: 55,
                                ),
                              ),
                              SizedBox(width: 50),
                              // Gesture detector for the Google icon
                              GestureDetector(
                                onTap: () {
                                  // Call the a method to sign in with Google
                                  // AuthService().signInWithGoogle();
                                  googleLogin();

                                  print("google");
                                },
                                child: Image.asset(
                                  "assets/icons/google.png",
                                  height: 50,
                                  width: 50,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Container(
                          child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text('Does not have account?'),
                          TextButton(
                            style: TextButton.styleFrom(
                              foregroundColor: Color.fromARGB(255, 0, 0, 255),
                            ),
                            child: const Text(
                              'Sign up',
                              style: TextStyle(fontSize: 18),
                            ),
                            onPressed: () {
                              //signup screen
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SinginPage()),
                              );
                            },
                          )
                        ],
                      ))
                    ],
                  ),
                )));
  }

  void logInUser() async {
    dynamic result = await _auth.loginUser(_LogEmail, _LogPassword);
    if (result == null) {
      print("Login faild");
      UsernamePassword = true;
      _formkey1.currentState!.validate();
    } else {
      _LogEmail = "";
      _LogPassword = "";
      print("Login sucsesful");

      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => HomePage(uid: result)));
    }
  }

  Future<void> googleLogin() async {
    dynamic result = await _auth.signInWithGoogle();
    print(result.uid);
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => HomePage(uid: result.uid)));
  }
}
