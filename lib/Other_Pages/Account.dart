import 'package:flutter/material.dart';
import 'package:jb_tailor/Other_Pages/cart.dart';
import 'Login_Screen.dart';
import 'package:jb_tailor/Other_Pages/Home_Screen.dart';
import 'package:jb_tailor/Other_Pages/Services/AuthenticationServices.dart';
import 'DatabaseManager/DatabaseManager.dart';

class AccountPage extends StatefulWidget {
  String uid;
  AccountPage({super.key, required this.uid});

  @override
  State<StatefulWidget> createState() => _State(uid);
}

class _State extends State<AccountPage> {
  String uid;
  _State(this.uid);

  bool loading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserDeatails();
  }

  //get data
  dynamic userDeatails;
  dynamic adminTell;

  getUserDeatails() async {
    dynamic data = await DatabaseManager().getUserDatails(uid);
    dynamic tel = await DatabaseManager().adminTelNo();
    setState(() {
      userDeatails = data;
      adminTell = tel;
      loading = false;
    });
  }

  // for footer
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (index == 0) {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => HomePage(uid: uid)));
      }
      if (index == 3) {
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => AccountPage(uid: uid)));
      }
      if (index == 2) {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => cart(uid: uid)));
      }
    });
  }

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  void logOutDialogBox() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: const Text("Do you want to logout"),
          children: <Widget>[
            Container(
              padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
              child: Row(
                children: [
                  Container(
                    alignment: Alignment.topLeft,
                    child: TextButton(
                      child: const Text("Yes"),
                      onPressed: () async {
                        await AuthenticationServices().singOut();
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => LoginPage()));
                      },
                    ),
                  ),
                  Container(
                    alignment: Alignment.topRight,
                    child: TextButton(
                      child: const Text("No"),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  void showMyDialog(String value, String selector) {
    String newValue = "";
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: Text('Update $selector'),
          children: <Widget>[
            Container(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Form(
                  key: _formkey,
                  child: Column(
                    children: [
                      TextFormField(
                          maxLength: 30,
                          controller: TextEditingController(text: value),
                          decoration: InputDecoration(
                            labelText: "Enter your $selector",
                          ),
                          validator: (text) {
                            if (text.toString().isEmpty) {
                              return '$selector cannot be empty';
                            }
                          },
                          onSaved: (text) {
                            newValue = text.toString();
                          }),
                      TextButton(
                        child: const Text('Update'),
                        onPressed: () async {
                          _formkey.currentState!.save();
                          if (_formkey.currentState!.validate()) {
                            await DatabaseManager()
                                .updateNameAddress(newValue, selector, uid);
                            // ignore: use_build_context_synchronously
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => AccountPage(uid: uid)));
                          }
                        },
                      ),
                    ],
                  )),
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double scrnwidth = MediaQuery.of(context).size.width;
    double scrnheight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text("My Profile"),
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
                  child: Column(children: <Widget>[
                    Container(
                      height: scrnheight * 0.075,
                      decoration: const BoxDecoration(
                          color: Color.fromARGB(34, 194, 192, 192),
                          border: Border(
                              bottom: BorderSide(
                            color: Color.fromARGB(141, 138, 136, 136),
                            width: 1,
                          ))),
                      child: Row(
                        children: [
                          Icon(
                            Icons.account_circle_outlined,
                            size: scrnheight * 0.035,
                          ),
                          SizedBox(width: scrnwidth * 0.025),
                          Text(
                            userDeatails['name'],
                            style: TextStyle(fontSize: scrnheight * 0.022),
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            child: IconButton(
                                onPressed: () {
                                  showMyDialog(
                                      userDeatails['name'].toString(), "name");
                                },
                                icon: Icon(
                                  Icons.drive_file_rename_outline_outlined,
                                  size: scrnheight * 0.025,
                                )),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: scrnheight * 0.075,
                      decoration: const BoxDecoration(
                          color: Color.fromARGB(34, 194, 192, 192),
                          border: Border(
                              bottom: BorderSide(
                            color: Color.fromARGB(141, 138, 136, 136),
                            width: 1,
                          ))),
                      child: Row(
                        children: [
                          Icon(
                            Icons.location_city_rounded,
                            size: scrnheight * 0.035,
                          ),
                          SizedBox(width: scrnwidth * 0.025),
                          Text(
                            userDeatails['address'],
                            style: TextStyle(fontSize: scrnheight * 0.022),
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            child: IconButton(
                                onPressed: () {
                                  showMyDialog(
                                      userDeatails['address'].toString(),
                                      "address");
                                },
                                icon: Icon(
                                  Icons.drive_file_rename_outline_outlined,
                                  size: scrnheight * 0.025,
                                )),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: scrnheight * 0.075,
                      decoration: const BoxDecoration(
                          color: Color.fromARGB(34, 194, 192, 192),
                          border: Border(
                              bottom: BorderSide(
                            color: Color.fromARGB(141, 138, 136, 136),
                            width: 1,
                          ))),
                      child: Row(
                        children: [
                          Icon(
                            Icons.email_outlined,
                            size: scrnheight * 0.035,
                          ),
                          SizedBox(width: scrnwidth * 0.025),
                          Text(
                            userDeatails['email'],
                            style: TextStyle(fontSize: scrnheight * 0.022),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: scrnheight * 0.05,
                    ),
                    Container(
                      height: scrnheight * 0.075,
                      decoration: const BoxDecoration(
                          color: Color.fromARGB(34, 194, 192, 192),
                          border: Border(
                              bottom: BorderSide(
                            color: Color.fromARGB(141, 138, 136, 136),
                            width: 1,
                          ))),
                      child: Row(
                        children: [
                          Icon(
                            Icons.phone,
                            size: scrnheight * 0.03,
                          ),
                          SizedBox(width: scrnwidth * 0.025),
                          Text(
                            "Contact us : ${adminTell['telNo']}",
                            style: TextStyle(fontSize: scrnheight * 0.022),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: scrnheight * 0.075,
                      decoration: const BoxDecoration(
                          color: Color.fromARGB(34, 194, 192, 192),
                          border: Border(
                              bottom: BorderSide(
                            color: Color.fromARGB(141, 138, 136, 136),
                            width: 1,
                          ))),
                      child: Row(
                        children: [
                          TextButton.icon(
                            onPressed: () async {
                              logOutDialogBox();
                            },
                            icon: Icon(
                              Icons.logout_rounded,
                              size: scrnheight * 0.03,
                              color: Colors.black,
                            ),
                            label: Text(
                              'Logout',
                              style: TextStyle(
                                fontSize: scrnheight * 0.02,
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                              ),
                            ), // <-- Text
                          ),
                        ],
                      ),
                    ),
                  ]),
                )),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: Color.fromARGB(255, 128, 128, 128),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt),
            label: 'Oders',
            backgroundColor: Color.fromARGB(255, 128, 128, 128),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
            backgroundColor: Color.fromARGB(255, 128, 128, 128),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_sharp),
            label: 'Account',
            backgroundColor: Color.fromARGB(255, 128, 128, 128),
          ),
        ],
        currentIndex: 3,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
