import 'package:flutter/material.dart';
import 'package:jb_tailor/Other_Pages/CustomOder.dart';
import 'package:jb_tailor/Other_Pages/Account.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:jb_tailor/Other_Pages/cart.dart';

import 'NormalOder.dart';
import 'Oder.dart';

class HomePage extends StatefulWidget {
  String uid;
  HomePage({required this.uid});

  @override
  State<StatefulWidget> createState() => _State(uid);
}

class _State extends State<HomePage> {
  String uid;
  _State(this.uid);

  bool loading = true;

  @override
  void initState() {
    super.initState();
    TrendingImgUrl();
  }

  dynamic img1, img2, img3, img4;

  TrendingImgUrl() async {
    dynamic downloadUrl1 = await FirebaseStorage.instance
        .ref()
        .child("Trending/T1.png")
        .getDownloadURL();
    dynamic downloadUrl2 = await FirebaseStorage.instance
        .ref()
        .child("Trending/T2.png")
        .getDownloadURL();
    dynamic downloadUrl3 = await FirebaseStorage.instance
        .ref()
        .child("Trending/T3.png")
        .getDownloadURL();
    dynamic downloadUrl4 = await FirebaseStorage.instance
        .ref()
        .child("Trending/T4.png")
        .getDownloadURL();

    setState(() {
      img1 = downloadUrl1;
      img2 = downloadUrl2;
      img3 = downloadUrl3;
      img4 = downloadUrl4;
      loading = false;
    });
  }

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (index == 1) {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => Oder(uid: uid)));
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

  void showMyDialog(double scrnheight, double scrnwidth) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: const Text('Select customer type'),
          children: <Widget>[
            Container(
              padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
              child: Column(
                children: [
                  TextButton(
                    child: Row(
                      children: [
                        Image.asset(
                          "assets/home/men.png",
                          height: scrnheight * 0.05,
                          // width: 70,
                        ),
                        SizedBox(width: scrnwidth * 0.05),
                        Text(
                          'Men',
                          style: TextStyle(
                            fontSize: scrnheight * 0.02,
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                          ),
                        )
                      ],
                    ),
                    onPressed: () async {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => CustomOder(
                                uid: uid,
                                type: "Men",
                              )));
                    },
                  ),
                  TextButton(
                    child: Row(
                      children: [
                        Image.asset(
                          "assets/home/women.png",
                          height: scrnheight * 0.05,
                          // width: 70,
                        ),
                        SizedBox(width: scrnwidth * 0.05),
                        Text(
                          'Women',
                          style: TextStyle(
                            fontSize: scrnheight * 0.02,
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                          ),
                        )
                      ],
                    ),
                    onPressed: () async {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => CustomOder(
                                uid: uid,
                                type: "Women",
                              )));
                    },
                  ),
                  TextButton(
                    child: Row(
                      children: [
                        Image.asset(
                          "assets/home/kids.png",
                          height: scrnheight * 0.05,
                          // width: 70,
                        ),
                        SizedBox(width: scrnwidth * 0.05),
                        Text(
                          'Kids',
                          style: TextStyle(
                            fontSize: scrnheight * 0.02,
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                          ),
                        )
                      ],
                    ),
                    onPressed: () async {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => CustomOder(
                                uid: uid,
                                type: "Kids",
                              )));
                    },
                  ),
                ],
              ),
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
      body: SingleChildScrollView(
        child: loading
            ? Container(
                alignment: Alignment.center,
                height: scrnheight,
                child: const Center(
                  child: CircularProgressIndicator(),
                ))
            : Container(
                // margin: const EdgeInsets.all(10.0),
                child: Column(
                  children: <Widget>[
                    // const SizedBox(
                    //   height: 10,
                    // ),
                    // Container(
                    //   alignment: Alignment.topLeft,
                    //   child: GestureDetector(
                    //     onTap: () {
                    //       Navigator.of(context).pop();
                    //     },
                    //     child: const Icon(
                    //       Icons.arrow_back,
                    //     ),
                    //   ),
                    // ),
                    // const SizedBox(
                    //   height: 25,
                    // ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(scrnwidth * 0.05),
                      child: Image.asset(
                        "assets/home/add.jpg",
                        width: scrnwidth,
                      ),
                    ),
                    // const SizedBox(height: 25),
                    Container(
                      margin: EdgeInsets.all(scrnheight * 0.01),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Categories",
                          style: TextStyle(
                              fontSize: scrnheight * 0.02,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    // const SizedBox(height: 13),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => NormalOder(
                                            uid: uid,
                                            type: "men",
                                          )));
                                },
                                child: Image.asset(
                                  "assets/home/men.png",
                                  height: scrnheight * 0.09,
                                  // width: 70,
                                ),
                              ),
                              const Text("Men"),
                            ]),
                            SizedBox(width: scrnwidth * 0.175),
                            Column(children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => NormalOder(
                                            uid: uid,
                                            type: "women",
                                          )));
                                },
                                child: Image.asset(
                                  "assets/home/women.png",
                                  height: scrnheight * 0.09,
                                  // width: 70,
                                ),
                              ),
                              const Text("Women"),
                            ]),
                            // const SizedBox(width: 50),
                            SizedBox(width: scrnwidth * 0.175),
                            Column(children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => NormalOder(
                                            uid: uid,
                                            type: "kids",
                                          )));
                                },
                                child: Image.asset(
                                  "assets/home/kids.png",
                                  height: scrnheight * 0.09,
                                  // width: 70,
                                ),
                              ),
                              const Text("Kids"),
                            ]),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: scrnheight * 0.008),
                    Container(
                      margin: EdgeInsets.all(scrnheight * 0.01),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Trending",
                          style: TextStyle(
                              fontSize: scrnheight * 0.02,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    // const SizedBox(height: 13),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                print("man");
                              },
                              child: Image.network(
                                "$img1",
                                height: scrnheight * 0.15,
                                // width: 120,
                              ),
                            ),
                            // const SizedBox(width: 60),
                            SizedBox(width: scrnwidth * 0.15),
                            GestureDetector(
                              onTap: () {
                                print("man");
                              },
                              child: Image.network(
                                "$img2",
                                height: scrnheight * 0.15,
                                // width: 120,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: scrnheight * 0.0351),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                print("man");
                              },
                              child: Image.network(
                                "$img3",
                                height: scrnheight * 0.15,
                                // width: 120,
                              ),
                            ),
                            // const SizedBox(width: 60),
                            SizedBox(width: scrnwidth * 0.15),
                            GestureDetector(
                              onTap: () {
                                print("man");
                              },
                              child: Image.network(
                                "$img4",
                                height: scrnheight * 0.15,
                                // width: 120,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    SizedBox(height: scrnheight * 0.015),
                    Container(
                      alignment: Alignment.topRight,
                      padding: EdgeInsets.all(scrnheight * 0.02),
                      child: ElevatedButton.icon(
                        onPressed: () {
                          showMyDialog(scrnheight, scrnwidth);
                        },
                        icon: Icon(
                          Icons.add_circle_rounded,
                          size: scrnheight * 0.0575,
                        ),
                        label: Text(
                          'Customized order',
                          style: TextStyle(fontSize: scrnheight * 0.02),
                        ), // <-- Text
                      ),
                    ),
                    // const SizedBox(height: 22),
                  ],
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
        currentIndex: 0,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
