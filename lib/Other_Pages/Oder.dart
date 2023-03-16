import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'Account.dart';
import 'DatabaseManager/DatabaseManager.dart';
import 'Home_Screen.dart';
import 'cart.dart';

class Oder extends StatefulWidget {
  String uid;
  Oder({super.key, required this.uid});

  @override
  State<Oder> createState() => _OderState(uid);
}

class _OderState extends State<Oder> {
  String uid;
  _OderState(this.uid);
  bool loading = true;
  List<Container> OderArray = [];
  double scrnwidth = 0;
  double scrnheight = 0;

  dynamic oderDeatails;
  @override
  initState() {
    super.initState();
    getOder();
  }

  getOder() async {
    dynamic oder = await DatabaseManager().getFromOder(uid);
    setState(() {
      oderDeatails = oder;
      loading = false;

      for (int i = 1; i <= oderDeatails['oderID']; i++) {
        OderArray.add(
          Container(
              // width: double.infinity,
              height: scrnheight * 0.125,
              margin: EdgeInsets.all(scrnheight * 0.01),
              padding: EdgeInsets.all(scrnheight * 0.01),
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 189, 188, 188),
                boxShadow: [
                  BoxShadow(
                    color: Color.fromARGB(120, 0, 0, 0),
                    offset: Offset(0, 1),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: Row(
                children: [
                  Column(
                    children: [
                      SizedBox(
                        width: scrnheight * 0.1,
                        height: scrnheight * 0.1,
                        child: Image.network(
                          oderDeatails['$i']['dataMeasurements']['url'],
                        ),
                      ),
                      // Text("Delete"),
                    ],
                  ),
                  SizedBox(width: scrnwidth * 0.015),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: scrnwidth * 0.585,
                            child: Text(
                                oderDeatails['$i']['basicData']['ClothType']),
                          ),
                          oderDeatails['$i']['price'] != "Pending"
                              ? IconButton(
                                
                                  onPressed: () async {
                                    
                                  },
                                  
                                  icon: const Icon(Icons.payment))
                              : Container(),
                        ],
                      ),
                      Text(
                          "Quantity: ${oderDeatails['$i']['basicData']['quantity']}"),
                      Text(
                        "Rs: ${oderDeatails['$i']['price']}",
                        style: const TextStyle(
                          color: Colors.deepOrange,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              )),
        );
      }
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
      if (index == 2) {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => cart(uid: uid)));
      }
      if (index == 3) {
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => AccountPage(uid: uid)));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      scrnwidth = MediaQuery.of(context).size.width;
      scrnheight = MediaQuery.of(context).size.height;
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text("Oders"),
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
                  children: OderArray,
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
        currentIndex: 1,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
