import 'package:flutter/material.dart';
import 'package:jb_tailor/Other_Pages/OnlinePayment/OnlinePayment.dart';

import 'Account.dart';
import 'CustomOderStep2.dart';
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

  void RejectedDialogBox(dynamic oder, int oderId, String uid) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: const Text("Rjected remark"),
          children: <Widget>[
            Container(
              padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
              child: Column(
                children: [
                  Text(oder["remark"]),
                  Row(
                    children: [
                      Container(
                        alignment: Alignment.topLeft,
                        child: TextButton(
                          child: const Text("Remove item"),
                          onPressed: () async {
                            await DatabaseManager()
                                .RejectedOder(uid, oderId, oder);
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => Oder(uid: uid)));
                          },
                        ),
                      ),
                      Container(
                        alignment: Alignment.topRight,
                        child: TextButton(
                          child: const Text("Cancel"),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  getOder() async {
    dynamic oder = await DatabaseManager().getFromOder(uid);
    setState(() {
      oderDeatails = oder;
      loading = false;

      for (int i = 1; i <= oderDeatails['oderID']; i++) {
        if (oderDeatails['$i']['oderType'] == "custom" &&
            (oderDeatails['$i']['isPending'] == 2 ||
                oderDeatails['$i']['isPending'] == 1 ||
                oderDeatails['$i']['isPending'] == 3)) {
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
                          // child: Image.network(
                          //   oderDeatails['$i']['basicData']['url'],
                          // ),
                          child: FadeInImage(
                            placeholder:
                                const AssetImage('assets/loading/loading.jpg'),
                            image: NetworkImage(
                                "${oderDeatails['$i']['basicData']['url']}"),
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
                            oderDeatails['$i']['price'] != "Pending" &&
                                    oderDeatails['$i']['isPending'] == 1
                                ? IconButton(
                                    onPressed: () async {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  CustomOderStep2(
                                                      uid: uid,
                                                      customOderId:
                                                          i.toString(),
                                                      data:
                                                          oderDeatails['$i'])));
                                    },
                                    icon: const Icon(Icons.payment))
                                : oderDeatails['$i']['isPending'] == 3
                                    ? IconButton(
                                        onPressed: () async {
                                          OderResived(oderDeatails['$i'],
                                              i.toString(), uid);
                                        },
                                        icon: const Icon(Icons.check_circle))
                                    : oderDeatails['$i']['isPending'] == 1
                                        ? IconButton(
                                            onPressed: () async {
                                              await DatabaseManager()
                                                  .deleteItemFromoder(uid, i,
                                                      oderDeatails['$i']);
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          Oder(uid: uid)));
                                            },
                                            icon: const Icon(Icons.delete))
                                        : Container(),
                          ],
                        ),
                        Text(
                            "Quantity: ${oderDeatails['$i']['basicData']['quantity']}"),
                        oderDeatails['$i']['isPending'] == 1
                            ? Text(
                                "Rs: ${oderDeatails['$i']['price']}",
                                style: const TextStyle(
                                  color: Colors.deepOrange,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            : Text(
                                oderDeatails['$i']['isPending'] == 3
                                    ? "${oderDeatails['$i']['status']}"
                                    : "\n${oderDeatails['$i']['status']}",
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
        } else if (oderDeatails['$i']['oderType'] == "normal" &&
            (oderDeatails['$i']['isPending'] == 2 ||
                oderDeatails['$i']['isPending'] == 1 ||
                oderDeatails['$i']['isPending'] == 3)) {
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
                          // child: Image.network(
                          //   oderDeatails['$i']['link'],
                          // ),
                          child: FadeInImage(
                            placeholder:
                                const AssetImage('assets/loading/loading.jpg'),
                            image:
                                NetworkImage("${oderDeatails['$i']['link']}"),
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
                              child: Text(oderDeatails['$i']['oderName']),
                            ),
                            oderDeatails['$i']['isPending'] == 3
                                ? IconButton(
                                    onPressed: () async {
                                      OderResived(oderDeatails['$i'],
                                          i.toString(), uid);
                                    },
                                    icon: const Icon(Icons.check_circle))
                                : Container(),
                          ],
                        ),
                        Text("Quantity: ${oderDeatails['$i']['quantity']}"),
                        Text(
                          oderDeatails['$i']['isPending'] == 3
                              ? "${oderDeatails['$i']['status']}"
                              : "\n${oderDeatails['$i']['status']}",
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
        } else if (oderDeatails['$i']['oderType'] == "custom" &&
            oderDeatails['$i']['isPending'] == 5) {
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
                          // child: Image.network(
                          //   oderDeatails['$i']['basicData']['url'],
                          // ),
                          child: FadeInImage(
                            placeholder:
                                const AssetImage('assets/loading/loading.jpg'),
                            image: NetworkImage(
                                "${oderDeatails['$i']['basicData']['url']}"),
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
                            IconButton(
                                onPressed: () async {
                                  RejectedDialogBox(oderDeatails['$i'], i, uid);
                                },
                                icon: const Icon(Icons.quiz_rounded))
                          ],
                        ),
                        Text(
                            "Quantity: ${oderDeatails['$i']['basicData']['quantity']}"),
                        Text(
                          "${oderDeatails['$i']['status']}",
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
      }
      if (OderArray.isEmpty) {
        OderArray.add(Container(
          alignment: Alignment.center,
          child: const Padding(
            padding: EdgeInsets.all(30),
            child: Text(
              "No any pending orders",
              style: TextStyle(color: Colors.grey, fontSize: 24),
            ),
          ),
        ));
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

  void OderResived(dynamic cartData, String oderID, String uid) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: const Text("Did you received this order?"),
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
                        await DatabaseManager()
                            .oderResived(cartData, oderID, uid);
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => Oder(
                                  uid: uid,
                                )));
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

  @override
  Widget build(BuildContext context) {
    setState(() {
      scrnwidth = MediaQuery.of(context).size.width;
      scrnheight = MediaQuery.of(context).size.height;
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text("Order"),
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
            label: 'Order',
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
