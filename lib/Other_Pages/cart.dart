import 'package:flutter/material.dart';
import 'package:jb_tailor/Other_Pages/Account.dart';
import 'package:jb_tailor/Other_Pages/Chechout.dart';
import 'package:jb_tailor/Other_Pages/Home_Screen.dart';
import 'DatabaseManager/DatabaseManager.dart';

class cart extends StatefulWidget {
  String uid;
  cart({super.key, required this.uid});

  @override
  State<cart> createState() => _cartState(uid);
}

class _cartState extends State<cart> {
  String uid;
  _cartState(this.uid);
  bool loading = true;

  @override
  initState() {
    super.initState();
    getCart();
  }

  dynamic oderDeatails;
  getCart() async {
    dynamic oder = await DatabaseManager().getFromCart(uid);
    setState(() {
      oderDeatails = oder;
      loading = false;
    });
  }

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
    });
  }

  @override
  Widget build(BuildContext context) {
    double scrnwidth = MediaQuery.of(context).size.width;
    double scrnheight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cart"),
      ),
      body: SingleChildScrollView(
        child: loading
            ? Container(
                alignment: Alignment.center,
                height: scrnheight,
                child: const Center(
                  child: CircularProgressIndicator(),
                ))
            : Column(
                children: List.generate(
                  oderDeatails['oderID'],
                  (index) => oderDeatails['${index + 1}']['isPending'] == 1
                      ? GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Chechout(
                                        uid: uid,
                                        cartData: oderDeatails['${index + 1}'],
                                        oderID: (index + 1).toString(),
                                      )),
                            );
                          },
                          child: Container(
                              width: double.infinity,
                              height: scrnheight * 0.125,
                              margin: EdgeInsets.all(scrnheight * 0.01),
                              padding: EdgeInsets.all(scrnheight * 0.01),
                              decoration: const BoxDecoration(
                                color: Color.fromARGB(255, 189, 188, 188),
                                boxShadow: [
                                  BoxShadow(
                                    color: Color.fromARGB(120, 0, 0, 0),
                                    offset: Offset(0, 5),
                                    blurRadius: 10,
                                  ),
                                ],
                              ),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: scrnheight * 0.1,
                                    height: scrnheight * 0.1,
                                    child: Image.network(
                                      oderDeatails['${index + 1}']['link'],
                                    ),
                                  ),
                                  SizedBox(width: scrnwidth * 0.015),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(oderDeatails['${index + 1}']
                                          ['oderName']),
                                      Text(
                                        "\nRs: ${oderDeatails['${index + 1}']['price']}",
                                        style: const TextStyle(
                                          color: Colors.deepOrange,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                          "\nSize: ${oderDeatails['${index + 1}']['size']} \t Quantity: ${oderDeatails['${index + 1}']['quantity']} \t Colour: ${oderDeatails['${index + 1}']['colour']}"),
                                    ],
                                  ),
                                ],
                              )))
                      : Container(),
                ),
              ),
      ),
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
        currentIndex: 2,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
